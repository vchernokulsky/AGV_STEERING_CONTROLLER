import sys
import json
from collections import namedtuple

Version = namedtuple('Version', ['major', 'minor', 'patch'])


def show_versions(release_data_json):
    with open(release_data_json, 'r') as f:
        release_data = json.load(f)

    start_version = Version(
        release_data['start_version']['major'],
        release_data['start_version']['minor'],
        release_data['start_version']['patch']
    )
    version_arr = release_data['version_arr']

    for i in range(len(version_arr)):
        major = start_version.major + i
        print(major)
        for j in range(len(version_arr[i])):
            minor = j
            if major == start_version.major:
                minor += start_version.minor
            minor_node = f'{major}.{minor}'
            print('\t', minor_node)
            for k in range(version_arr[i][j] + 1):
                patch = k
                if major == start_version.major and minor == start_version.minor:
                    patch += start_version.patch
                patch_node = f'{major}.{minor}.{patch}'
                print('\t\t', patch_node)


if __name__ == '__main__':
    show_versions(sys.argv[1])