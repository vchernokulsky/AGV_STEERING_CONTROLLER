"""
Based on /opt/st/stm32cubeide_1.1.0/headless-build.sh
"""

import os
import re
import sys
import json
import click
import subprocess
from collections import namedtuple

Version = namedtuple('Version', ['major', 'minor', 'patch'])


class ReleaseDataManager:
    def __init__(self, release_data):
        self.version_arr = release_data['version_arr']
        self.start_version = Version(
            release_data['start_version']['major'],
            release_data['start_version']['minor'],
            release_data['start_version']['patch']
        )

    def get_release_data(self):
        return {
            'version_arr': self.version_arr,
            'start_version': {
                'major': self.start_version.major,
                'minor': self.start_version.minor,
                'patch': self.start_version.patch
            }
        }

    def get_last_major(self):
        return len(self.version_arr) - 1 + self.start_version.major

    def get_last_minor(self, major):
        tmp = len(self.version_arr[major - self.start_version.major]) - 1
        if major != self.start_version.major:
            return tmp
        return tmp + self.start_version.minor

    def get_last_patch(self, major, minor):
        patch_offset = 0

        if major == self.start_version.major and minor == self.start_version.minor:
            patch_offset += self.start_version.patch

        if major == self.start_version.major:
            minor -= self.start_version.minor

        major -= self.start_version.major

        return self.version_arr[major][minor] + patch_offset

    def inc_major(self):
        self.version_arr += [[0]]

    def inc_minor(self, major):
        self.version_arr[major - self.start_version.major] += [0]

    def inc_patch(self, major, minor):
        if major == self.start_version.major:
            minor -= self.start_version.minor
        major -= self.start_version.major

        self.version_arr[major][minor] += 1

    @classmethod
    def create_instance_from_version(cls, start_version):
        version_data = {
            'start_version': {
                'major': start_version.major,
                'minor': start_version.minor,
                'patch': start_version.patch
            },
            'version_arr': [[0]]
        }
        return cls(version_data)


class FirmwareBuilder:
    firmware_version_pattern = '#define FIRMWARE_VERSION \"v0.0.0\"'
    default_release_data_json = 'DiscoveryF4RobotController.json'

    def __init__(self, path_to_workspace, project, path_to_firmware_version_src,
                 release_data_json=None, major_opt=-1, minor_opt=-1, start_version=None):
        self.path_to_workspace = os.path.expanduser(path_to_workspace)
        self.project = project
        self.path_to_firmware_version_src = os.path.expanduser(path_to_firmware_version_src)
        self.release_data = os.path.expanduser(release_data_json if release_data_json else self.default_release_data_json)
        self.major_opt = major_opt
        self.minor_opt = minor_opt
        self.start_version = start_version
        self._build_cmd = f'/opt/st/stm32cubeide_1.1.0/headless-build.sh -data {self.path_to_workspace} -build {self.project}/Release'
        self.return_code = 0

    @classmethod
    def create_instance_for_first_release(cls, path_to_workspace, project, path_to_firmware_version_src, start_version,
                                          release_data_json=None):
        return cls(path_to_workspace, project, path_to_firmware_version_src, start_version=start_version,
                   release_data_json=release_data_json)

    @classmethod
    def create_instance_for_next_release(cls, path_to_workspace, project, path_to_firmware_version_src, major_opt=-1,
                                         minor_opt=-1, release_data_json=None):
        return cls(path_to_workspace, project, path_to_firmware_version_src, major_opt=major_opt, minor_opt=minor_opt,
                   release_data_json=release_data_json)

    def build(self):
        self._prebuild()
        self._build()
        self._postbuild()

    def _prebuild(self):
        self._locate_firmware_version_pattern()

        if self.start_version:
            self._init_release_data()
        else:
            self._read_release_data()
            self._check_version_options()
            self._upgrade_firmware_version()

        self._put_firmware_version()

    def _build(self):
        out = subprocess.check_output(self._build_cmd, shell=True)

        if out.find(b'Build Failed') != -1:
            self.return_code = 1
        else:
            self.return_code = 0

        print(out.decode('utf-8'))

    def _postbuild(self):
        if self.return_code == 0:
            if not self.start_version:
                self._update_release_data()
            self._commit_release_data()
        self._recover_firmware_version_pattern_in_src()

        if self.return_code == 0:
            print(f'Release v{self.version.major}.{self.version.minor}.{self.version.patch} was built successfully.')
        else:
            print(f'Failed to build release v{self.version.major}.{self.version.minor}.{self.version.patch}.')

    def _check_version_options(self):
        if self.major_opt < -1:
            raise Exception('invalid major option')
        if self.minor_opt < -1:
            raise Exception('invalid minor option')

        last_major = self.release_data_manager.get_last_major()

        if last_major < self.major_opt:
            raise Exception('no such major')

        last_minor = 0
        if self.minor_opt == -1:
            last_minor = self.release_data_manager.get_last_minor(last_major)
        else:
            last_minor = self.release_data_manager.get_last_minor(self.major_opt)

        if last_minor < self.minor_opt:
            raise Exception('no such minor')

        start_version = self.release_data_manager.start_version

        if self.major_opt == start_version.major:
            if self.minor_opt < start_version.minor and self.minor_opt != -1:
                raise Exception('New release version is lower than start version')

    def _locate_firmware_version_pattern(self):
        with open(self.path_to_firmware_version_src, 'r') as f:
            self.firmware_version_src_content = f.read()

        self.firmware_version_pattern_pos = self.firmware_version_src_content.find(self.firmware_version_pattern)

        if self.firmware_version_pattern_pos == -1:
            print(f'there is no {self.firmware_version_pattern} pattern in {self.path_to_firmware_version_src}')
            sys.exit(1)

        self.version_end_pos = self.firmware_version_pattern_pos + len(self.firmware_version_pattern) - 1
        self.version_begin_pos = self.version_end_pos - 5

    def _read_release_data(self):
        with open(self.release_data, 'r') as f:
            self.release_data_manager = ReleaseDataManager(json.load(f))

    def _init_release_data(self):
        self.version = Version(self.start_version['major'],
                               self.start_version['minor'],
                               self.start_version['patch']
                               )
        self.release_data_manager = ReleaseDataManager.create_instance_from_version(self.version)

    def _upgrade_firmware_version(self):
        # release new major (new_major.0.0)
        if self.major_opt == -1 and self.minor_opt == -1:
            new_major = self.release_data_manager.get_last_major() + 1
            self.version = Version(new_major, 0, 0)

        # release new patch of minor of last major (last_major.minor.new_patch)
        elif self.major_opt == -1:
            last_major = self.release_data_manager.get_last_major()
            new_patch = self.release_data_manager.get_last_patch(last_major, self.minor_opt) + 1
            self.version = Version(last_major, self.minor_opt, new_patch)

        # release new minor of major (major.new_minor.0)
        elif self.minor_opt == -1:
            new_minor = self.release_data_manager.get_last_minor(self.major_opt) + 1
            self.version = Version(self.major_opt, new_minor, 0)

        # release new patch of minor of major (major.minor.new_patch)
        else:
            new_patch = self.release_data_manager.get_last_patch(self.major_opt, self.minor_opt) + 1
            self.version = Version(self.major_opt, self.minor_opt, new_patch)

    def _put_firmware_version(self):
        self.firmware_version_src_content = self.firmware_version_src_content[:self.firmware_version_pattern_pos] + \
                                            f'#define FIRMWARE_VERSION \"v{self.version.major}.{self.version.minor}.{self.version.patch}\"' + \
                                            self.firmware_version_src_content[
                                            self.firmware_version_pattern_pos + len(self.firmware_version_pattern):]
        with open(self.path_to_firmware_version_src, 'w') as f:
            f.write(self.firmware_version_src_content)

    def _update_release_data(self):
        if self.major_opt == -1 and self.minor_opt == -1:
            self.release_data_manager.inc_major()

        elif self.minor_opt == -1:
            self.release_data_manager.inc_minor(self.version.major)

        else:
            self.release_data_manager.inc_patch(self.version.major, self.version.minor)

    def _commit_release_data(self):
        with open(self.release_data, 'w') as f:
            json.dump(self.release_data_manager.get_release_data(), f)

    def _recover_firmware_version_pattern_in_src(self):
        replace_len = len(
            f'#define FIRMWARE_VERSION \"v{self.version.major}.{self.version.minor}.{self.version.patch}\"')
        self.firmware_version_src_content = self.firmware_version_src_content[:self.firmware_version_pattern_pos] + \
                                            self.firmware_version_pattern + \
                                            self.firmware_version_src_content[
                                            self.firmware_version_pattern_pos + replace_len:]

        with open(self.path_to_firmware_version_src, 'w') as f:
            f.write(self.firmware_version_src_content)


def parse_start_version(s):
    numbers = list(map(lambda e: int(e), re.findall('\d+', s)))
    return {'major': numbers[0], 'minor': numbers[1], 'patch': numbers[2]}


@click.command()
@click.option('--workspace', '-w', required=True, help='Path to STM32CubeIDE workspace.')
@click.option('--project', '-p', required=True, help='Path to project in STM32CubeIDE workspace.')
@click.option('--version_src', '-src', required=True,
              help=f'Path to {FirmwareBuilder.firmware_version_pattern} pattern holder')
@click.option('--version', '-v', help=f'Use this option to release first project. '
                                      f'The first release will have this version and '
                                      f'the next ones will be recounted from this version.')
@click.option('--release_data', help=f'Release data is a json that stores release history. '
                                     f'If you\'re going to  make first release, then choose an appropriate file name. '
                                     f'The default name is \"DiscoveryF4RobotController.json\".')
@click.option('--major', default=-1, help=f'X.Y.Z, X - major', type=click.IntRange(-1))
@click.option('--minor', default=-1, help=f'X.Y.Z, Y - minor', type=click.IntRange(-1))
def main(workspace, project, version_src, version, release_data, major, minor):
    firmware_builder = None

    if version and (major != -1 or minor != -1):
        print('Error: Incompatible set of options. Don\'t use version option with major and minor options.')
        return

    if version:
        start_version = parse_start_version(version)
        firmware_builder = FirmwareBuilder.create_instance_for_first_release(workspace, project, version_src,
                                                                             start_version, release_data)
    else:
        firmware_builder = FirmwareBuilder.create_instance_for_next_release(workspace, project, version_src, major,
                                                                            minor, release_data)

    firmware_builder.build()


if __name__ == '__main__':
    main()
