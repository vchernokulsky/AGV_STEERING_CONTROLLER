# AGV_STEERING_CONTROLLER

## DiscoveryF4RobotController

После генерации кода необходимо проверить корректность полученного кода.
* стандартный вызов функции инициализации LWIP должен быть закомментирован

_firmware/DiscoveryF4RobotController/Core/Src/main.c_


     /* init code for LWIP */
    //  MX_LWIP_Init();

* Приритет прирываний ETH должен быть выставлен в 5

_firmware/DiscoveryF4RobotController/LWIP/Target/ethernetif.c_

    /* Peripheral interrupt init */
    HAL_NVIC_SetPriority(ETH_IRQn, 5, 0);
    HAL_NVIC_EnableIRQ(ETH_IRQn);
    HAL_NVIC_SetPriority(ETH_WKUP_IRQn, 5, 0);
    HAL_NVIC_EnableIRQ(ETH_WKUP_IRQn);