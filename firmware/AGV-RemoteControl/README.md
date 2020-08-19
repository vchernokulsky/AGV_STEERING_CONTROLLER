## AGV-RemoteControl

#### Установка средств разработки
Для работы над данным проектом необходимо установить toolchain и фреймворк ESP-IDF (https://docs.espressif.com/projects/esp-idf/en/latest/esp32/get-started/index.html).
Версия ESP-IDF: 3.3.1. Чтобы переключиться на версию 3.3.1 ESP-IDF, в директории esp-idf/ в терминале необходимо выполнить следующие команды:
```bash
git fetch
git checkout release/v3.3
git pull
git submodule update --init --recursive
```
#### Сборка проекта
Перед сборкой проект необходимо сконфигурировать: в директории `AGV-RemoteControl/` в терминале нужно выполнить команду `make menuconfig` и настроить среду.
Чтобы настроить WI-FI и SerialNode, в `menuconfig` необходимо выбрать `Component config` и найти компонент `rosserial`.
Чтобы собрать проект, сразу прошить МК и наблюдать за его отладочным выводом в USB-UART, можно выполнить команду `make -j(nproc) flash monitor` (цель `monitor` - начать отладочный вывод). Проект можно собрать без прошивания МК: `make -j(nproc) all`.
#### Документация на микроконтроллер
В директории `docs/ESP32/` есть распиновка, technical reference, hardware reference на микроконтроллер.
