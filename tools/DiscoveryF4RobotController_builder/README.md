## Релизная сборка прошивки

**python3.6+**

Скрипт `build_DiscoveryF4RobotController.py` предназначен для сборки релизной прошивки с подстановкой её очередной версии. Скрипт использует утилиту STMCubeIDE `headless-build.sh` (`/opt/st/stm32cubeide_1.1.0/headless-build.sh`).

По умолчанию скрипт `build_DiscoveryF4RobotController.py` работает с файлом `DiscoveryF4RobotController.json`, который предназначен для хранения данных о выпущенных версиях прошивки. В ходе первого релиза утилита создаст его самостоятельно. Конкретное имя файла с данными о выпущенных версиях можно указать с помощью опции `--release_data`. 
Со всеми выпущенными версиями прошивки удобно ознакомиться с помощью утилиты `show_released_versions.py`:
```bash
python3 show_released_versions.py <файл с данными о выпущенных версиях прошивки>
```

Версия прошивки: `X.Y.Z`,`X` - major, `Y` -minor, `Z` - patch.

Шаблоны версиии прошивки: `#define FIRMWARE_VERSION_STR "v0.0.0"`, `#define FIRMWARE_VERSION_BUF "{0, 0, 0}"`. Оба шаблона должны присутствовать в файле.


### Примеры использования

Выпустить первую версию:
```bash
python3 build_DiscoveryF4RobotController.py -w <путь до workspace STMCubeIDE> -p <проект в workspace STMCubeIDE> -src <путь до файла с шаблоном версии> -v <номер первой версии, например, 1.2.3>
```

Выпустить новый major (major.0.0):
```bash
python3 build_DiscoveryF4RobotController.py -w <путь до workspace STMCubeIDE> -p <проект в workspace STMCubeIDEe> -src <путь до файла с шаблоном версии>
```

Выпустить новый minor (major.new_minor.0):
```bash
python3 build_DiscoveryF4RobotController.py -w <путь до workspace STMCubeIDE> -p <проект в workspace STMCubeIDE> -src <путь до файла с шаблоном версии> --major <major>
```

Выпустить новый patch (major.minor.new_patch):
```bash
python3 build_DiscoveryF4RobotController.py -w <путь до workspace STMCubeIDE> -p <проект в workspace STMCubeIDE> -src <путь до файла с шаблоном версии> --major <major> --minor <minor>
```