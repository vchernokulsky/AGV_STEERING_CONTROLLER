EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 5 6
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L archive:Interface_Ethernet_LAN8720A U7
U 1 1 5E783466
P 4400 3600
F 0 "U7" H 4850 4900 50  0000 C CNN
F 1 "LAN8720AI-CP-TR" H 4850 4800 50  0000 C CNN
F 2 "Package_DFN_QFN:QFN-24-1EP_4x4mm_P0.5mm_EP2.6x2.6mm_ThermalVias" H 4450 2550 50  0001 L CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/8720a.pdf" H 4200 2650 50  0001 C CNN
F 4 "LAN8720AI-CP-TR" H 4400 3600 50  0001 C CNN "PartNumber"
	1    4400 3600
	1    0    0    -1  
$EndComp
$Comp
L archive:Device_R_Small R?
U 1 1 5E7AD790
P 5700 2800
AR Path="/5E77BE3B/5E7AD790" Ref="R?"  Part="1" 
AR Path="/5E77BE73/5E7AD790" Ref="R36"  Part="1" 
F 0 "R36" H 5759 2891 50  0000 L CNN
F 1 "49R9" H 5759 2800 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric" H 5700 2800 50  0001 C CNN
F 3 "~" H 5700 2800 50  0001 C CNN
F 4 "RC0603FR-0749R9L" H 5700 2800 50  0001 C CNN "PartNumber"
F 5 "1%" H 5759 2709 50  0000 L CNN "Tolerance"
	1    5700 2800
	1    0    0    -1  
$EndComp
Wire Wire Line
	5100 3200 6700 3200
Wire Wire Line
	8500 2900 7700 2900
Wire Wire Line
	7700 2900 7700 3200
Wire Wire Line
	8500 3100 7200 3100
Wire Wire Line
	8500 3500 7800 3500
Wire Wire Line
	7800 3500 7800 3400
Wire Wire Line
	7800 3400 5700 3400
Wire Wire Line
	8500 3700 7700 3700
Wire Wire Line
	7700 3700 7700 3300
$Comp
L archive:Device_R_Small R?
U 1 1 5E7B8C05
P 6200 2800
AR Path="/5E77BE3B/5E7B8C05" Ref="R?"  Part="1" 
AR Path="/5E77BE73/5E7B8C05" Ref="R37"  Part="1" 
F 0 "R37" H 6259 2891 50  0000 L CNN
F 1 "49R9" H 6259 2800 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric" H 6200 2800 50  0001 C CNN
F 3 "~" H 6200 2800 50  0001 C CNN
F 4 "RC0603FR-0749R9L" H 6200 2800 50  0001 C CNN "PartNumber"
F 5 "1%" H 6259 2709 50  0000 L CNN "Tolerance"
	1    6200 2800
	1    0    0    -1  
$EndComp
$Comp
L archive:Device_R_Small R?
U 1 1 5E7B9460
P 6700 2800
AR Path="/5E77BE3B/5E7B9460" Ref="R?"  Part="1" 
AR Path="/5E77BE73/5E7B9460" Ref="R38"  Part="1" 
F 0 "R38" H 6759 2891 50  0000 L CNN
F 1 "49R9" H 6759 2800 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric" H 6700 2800 50  0001 C CNN
F 3 "~" H 6700 2800 50  0001 C CNN
F 4 "RC0603FR-0749R9L" H 6700 2800 50  0001 C CNN "PartNumber"
F 5 "1%" H 6759 2709 50  0000 L CNN "Tolerance"
	1    6700 2800
	1    0    0    -1  
$EndComp
$Comp
L archive:Device_R_Small R?
U 1 1 5E7B98D7
P 7200 2800
AR Path="/5E77BE3B/5E7B98D7" Ref="R?"  Part="1" 
AR Path="/5E77BE73/5E7B98D7" Ref="R39"  Part="1" 
F 0 "R39" H 7259 2891 50  0000 L CNN
F 1 "49R9" H 7259 2800 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric" H 7200 2800 50  0001 C CNN
F 3 "~" H 7200 2800 50  0001 C CNN
F 4 "RC0603FR-0749R9L" H 7200 2800 50  0001 C CNN "PartNumber"
F 5 "1%" H 7259 2709 50  0000 L CNN "Tolerance"
	1    7200 2800
	1    0    0    -1  
$EndComp
Wire Wire Line
	5700 2900 5700 3400
Connection ~ 5700 3400
Wire Wire Line
	5700 3400 5100 3400
Wire Wire Line
	6200 2900 6200 3300
Connection ~ 6200 3300
Wire Wire Line
	6200 3300 5100 3300
Wire Wire Line
	7200 2900 7200 3100
Connection ~ 7200 3100
Wire Wire Line
	7200 3100 5100 3100
Wire Wire Line
	5700 2700 5700 2500
Wire Wire Line
	5700 2500 6200 2500
Wire Wire Line
	7200 2500 7200 2700
Wire Wire Line
	6700 2700 6700 2500
Connection ~ 6700 2500
Wire Wire Line
	6700 2500 7200 2500
Wire Wire Line
	6200 2700 6200 2500
Connection ~ 6200 2500
Wire Wire Line
	6200 2500 6450 2500
Connection ~ 6450 2500
Wire Wire Line
	6450 2500 6700 2500
$Comp
L archive:Mainboard_HR911105A P1
U 1 1 5E78A4D3
P 9200 3900
F 0 "P1" H 9728 3853 60  0000 L CNN
F 1 "HR911105A" H 9728 3747 60  0000 L CNN
F 2 "PatternLibs:HR911105" H 9200 4200 60  0001 C CNN
F 3 "" H 9200 4200 60  0000 C CNN
F 4 "HR911105A" H 9200 3900 50  0001 C CNN "PartNumber"
	1    9200 3900
	1    0    0    -1  
$EndComp
Wire Wire Line
	8500 3900 7900 3900
Wire Wire Line
	7900 3900 7900 3300
Wire Wire Line
	7900 3300 8500 3300
$Comp
L archive:Device_C_Small C?
U 1 1 5E7C3F33
P 7900 4100
AR Path="/5E77BE3B/5E7C3F33" Ref="C?"  Part="1" 
AR Path="/5E77BE73/5E7C3F33" Ref="C39"  Part="1" 
F 0 "C39" H 7992 4237 50  0000 L CNN
F 1 "22n" H 7992 4146 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 7900 4100 50  0001 C CNN
F 3 "~" H 7900 4100 50  0001 C CNN
F 4 "CC0603KRX7R9BB223" H 7900 4100 50  0001 C CNN "PartNumber"
F 5 "6V3" H 7992 4055 50  0000 L CNN "Ratio"
F 6 "X7R" H 7992 3964 50  0000 L CNN "Tolerance"
	1    7900 4100
	1    0    0    -1  
$EndComp
$Comp
L archive:Device_C_Small C?
U 1 1 5E7C52D5
P 8200 5400
AR Path="/5E77BE3B/5E7C52D5" Ref="C?"  Part="1" 
AR Path="/5E77BE73/5E7C52D5" Ref="C40"  Part="1" 
F 0 "C40" H 8292 5537 50  0000 L CNN
F 1 "1n" H 8292 5446 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 8200 5400 50  0001 C CNN
F 3 "~" H 8200 5400 50  0001 C CNN
F 4 "CC1206KKX7RDBB102" H 8200 5400 50  0001 C CNN "PartNumber"
F 5 "2KV" H 8292 5355 50  0000 L CNN "Ratio"
F 6 "X7R" H 8292 5264 50  0000 L CNN "Tolerance"
	1    8200 5400
	1    0    0    -1  
$EndComp
Connection ~ 7900 3300
Wire Wire Line
	7900 4000 7900 3900
Connection ~ 7900 3900
$Comp
L archive:power_GND #PWR0110
U 1 1 5E7C9DE4
P 7900 4300
F 0 "#PWR0110" H 7900 4050 50  0001 C CNN
F 1 "GND" H 7905 4127 50  0000 C CNN
F 2 "" H 7900 4300 50  0001 C CNN
F 3 "" H 7900 4300 50  0001 C CNN
	1    7900 4300
	1    0    0    -1  
$EndComp
Wire Wire Line
	7900 4200 7900 4300
Wire Wire Line
	7900 2800 7900 3300
$Comp
L archive:power_+3.3VA #PWR0109
U 1 1 5E7C7CC4
P 7900 2800
F 0 "#PWR0109" H 7900 2650 50  0001 C CNN
F 1 "+3.3VA" H 7915 2973 50  0000 C CNN
F 2 "" H 7900 2800 50  0001 C CNN
F 3 "" H 7900 2800 50  0001 C CNN
	1    7900 2800
	1    0    0    -1  
$EndComp
Wire Wire Line
	8500 4300 8200 4300
Wire Wire Line
	8200 4300 8200 5300
$Comp
L archive:power_GND #PWR0111
U 1 1 5E7CF606
P 8200 5600
F 0 "#PWR0111" H 8200 5350 50  0001 C CNN
F 1 "GND" H 8205 5427 50  0000 C CNN
F 2 "" H 8200 5600 50  0001 C CNN
F 3 "" H 8200 5600 50  0001 C CNN
	1    8200 5600
	1    0    0    -1  
$EndComp
Wire Wire Line
	8200 5500 8200 5600
Wire Wire Line
	8500 4900 8400 4900
Wire Wire Line
	8400 4900 8400 4500
Wire Wire Line
	8400 4500 8500 4500
Wire Wire Line
	8400 4200 8400 4500
Connection ~ 8400 4500
Wire Wire Line
	8500 4700 8000 4700
$Comp
L archive:Device_R_Small R?
U 1 1 5E7D2EE1
P 7900 4700
AR Path="/5E77BE3B/5E7D2EE1" Ref="R?"  Part="1" 
AR Path="/5E77BE73/5E7D2EE1" Ref="R40"  Part="1" 
F 0 "R40" V 8000 4650 50  0000 L CNN
F 1 "680" V 7800 4700 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" H 7900 4700 50  0001 C CNN
F 3 "~" H 7900 4700 50  0001 C CNN
F 4 "RC0805FR-07680RL" H 7900 4700 50  0001 C CNN "PartNumber"
F 5 "5%" V 7700 4700 50  0000 C CNN "Tolerance"
	1    7900 4700
	0    -1   -1   0   
$EndComp
$Comp
L archive:Device_R_Small R?
U 1 1 5E7D5128
P 7900 5600
AR Path="/5E77BE3B/5E7D5128" Ref="R?"  Part="1" 
AR Path="/5E77BE73/5E7D5128" Ref="R41"  Part="1" 
F 0 "R41" V 8000 5550 50  0000 L CNN
F 1 "680" V 7800 5600 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" H 7900 5600 50  0001 C CNN
F 3 "~" H 7900 5600 50  0001 C CNN
F 4 "RC0805FR-07680RL" H 7900 5600 50  0001 C CNN "PartNumber"
F 5 "5%" V 7700 5600 50  0000 C CNN "Tolerance"
	1    7900 5600
	0    -1   -1   0   
$EndComp
Wire Wire Line
	7500 4700 7800 4700
Text Label 5300 3900 0    50   ~ 0
LED1_LINK_ACT
Text Label 5300 4000 0    50   ~ 0
LED2_SPEED
Wire Wire Line
	5300 3900 5200 3900
Wire Wire Line
	5300 4000 5100 4000
$Comp
L archive:Device_R_Small R?
U 1 1 5E7DB0CC
P 5200 4350
AR Path="/5E77BE3B/5E7DB0CC" Ref="R?"  Part="1" 
AR Path="/5E77BE73/5E7DB0CC" Ref="R35"  Part="1" 
F 0 "R35" H 5300 4400 50  0000 L CNN
F 1 "10k" H 5350 4300 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" H 5200 4350 50  0001 C CNN
F 3 "~" H 5200 4350 50  0001 C CNN
F 4 "RC0603FR-0710KL" H 5200 4350 50  0001 C CNN "PartNumber"
F 5 "5%" H 5350 4200 50  0000 C CNN "Tolerance"
	1    5200 4350
	1    0    0    -1  
$EndComp
Wire Wire Line
	5200 3900 5200 4250
Connection ~ 5200 3900
Wire Wire Line
	5200 3900 5100 3900
$Comp
L archive:Device_R_Small R?
U 1 1 5E7F2BFB
P 5400 3700
AR Path="/5E77BE3B/5E7F2BFB" Ref="R?"  Part="1" 
AR Path="/5E77BE73/5E7F2BFB" Ref="R34"  Part="1" 
F 0 "R34" V 5500 3800 50  0000 L CNN
F 1 "12.1k" V 5500 3550 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" H 5400 3700 50  0001 C CNN
F 3 "~" H 5400 3700 50  0001 C CNN
F 4 "RC0603FR-0712K1L" H 5400 3700 50  0001 C CNN "PartNumber"
F 5 "1%" V 5500 3350 50  0000 C CNN "Tolerance"
	1    5400 3700
	0    -1   -1   0   
$EndComp
Wire Wire Line
	5100 3700 5300 3700
$Comp
L archive:power_GND #PWR0105
U 1 1 5E7F4AF5
P 5700 3700
F 0 "#PWR0105" H 5700 3450 50  0001 C CNN
F 1 "GND" H 5705 3527 50  0000 C CNN
F 2 "" H 5700 3700 50  0001 C CNN
F 3 "" H 5700 3700 50  0001 C CNN
	1    5700 3700
	1    0    0    -1  
$EndComp
Wire Wire Line
	5500 3700 5700 3700
$Comp
L archive:power_GND #PWR098
U 1 1 5E7F6A93
P 4400 4900
F 0 "#PWR098" H 4400 4650 50  0001 C CNN
F 1 "GND" H 4405 4727 50  0000 C CNN
F 2 "" H 4400 4900 50  0001 C CNN
F 3 "" H 4400 4900 50  0001 C CNN
	1    4400 4900
	1    0    0    -1  
$EndComp
Wire Wire Line
	4400 4700 4400 4900
$Comp
L archive:Device_R_Small R?
U 1 1 5E7F8787
P 2500 3300
AR Path="/5E77BE3B/5E7F8787" Ref="R?"  Part="1" 
AR Path="/5E77BE73/5E7F8787" Ref="R27"  Part="1" 
F 0 "R27" V 2550 3400 50  0000 L CNN
F 1 "10R" V 2550 3100 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" H 2500 3300 50  0001 C CNN
F 3 "~" H 2500 3300 50  0001 C CNN
F 4 "RC0603JR-0710RL" H 2500 3300 50  0001 C CNN "PartNumber"
F 5 "5%" V 2550 2950 50  0000 C CNN "Tolerance"
	1    2500 3300
	0    -1   -1   0   
$EndComp
$Comp
L archive:Device_R_Small R?
U 1 1 5E7F9686
P 2500 3400
AR Path="/5E77BE3B/5E7F9686" Ref="R?"  Part="1" 
AR Path="/5E77BE73/5E7F9686" Ref="R28"  Part="1" 
F 0 "R28" V 2550 3500 50  0000 L CNN
F 1 "10R" V 2550 3200 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" H 2500 3400 50  0001 C CNN
F 3 "~" H 2500 3400 50  0001 C CNN
F 4 "RC0603JR-0710RL" H 2500 3400 50  0001 C CNN "PartNumber"
F 5 "5%" V 2550 3050 50  0000 C CNN "Tolerance"
	1    2500 3400
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3600 3000 2250 3000
Wire Wire Line
	3600 3100 2250 3100
Wire Wire Line
	3600 3200 2250 3200
Wire Wire Line
	3600 3300 2600 3300
Wire Wire Line
	3600 3400 2600 3400
Wire Wire Line
	2400 3300 2250 3300
Wire Wire Line
	2400 3400 2250 3400
$Comp
L archive:Device_R_Small R?
U 1 1 5E802A9C
P 2500 3500
AR Path="/5E77BE3B/5E802A9C" Ref="R?"  Part="1" 
AR Path="/5E77BE73/5E802A9C" Ref="R29"  Part="1" 
F 0 "R29" V 2550 3600 50  0000 L CNN
F 1 "10R" V 2550 3300 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" H 2500 3500 50  0001 C CNN
F 3 "~" H 2500 3500 50  0001 C CNN
F 4 "RC0603JR-0710RL" H 2500 3500 50  0001 C CNN "PartNumber"
F 5 "5%" V 2550 3150 50  0000 C CNN "Tolerance"
	1    2500 3500
	0    -1   -1   0   
$EndComp
$Comp
L archive:Device_R_Small R?
U 1 1 5E802D8F
P 2500 3600
AR Path="/5E77BE3B/5E802D8F" Ref="R?"  Part="1" 
AR Path="/5E77BE73/5E802D8F" Ref="R30"  Part="1" 
F 0 "R30" V 2550 3700 50  0000 L CNN
F 1 "10R" V 2550 3400 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" H 2500 3600 50  0001 C CNN
F 3 "~" H 2500 3600 50  0001 C CNN
F 4 "RC0603JR-0710RL" H 2500 3600 50  0001 C CNN "PartNumber"
F 5 "5%" V 2550 3250 50  0000 C CNN "Tolerance"
	1    2500 3600
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3600 3500 2600 3500
Wire Wire Line
	3600 3600 2600 3600
Wire Wire Line
	2400 3500 2250 3500
Wire Wire Line
	2400 3600 2250 3600
Text HLabel 2250 3600 0    50   Output ~ 0
ETH_CRS_DV
Text HLabel 2850 4100 0    50   Output ~ 0
ETH_REF_CLK
Text HLabel 2250 3700 0    50   BiDi ~ 0
ETH_DIO
Text HLabel 2250 3200 0    50   Input ~ 0
ETH_TXEN
Text HLabel 2250 3000 0    50   Input ~ 0
ETH_TXD0
Text HLabel 2250 3100 0    50   Input ~ 0
ETH_TXD1
Text HLabel 2250 3300 0    50   Output ~ 0
ETH_RXD0
Text HLabel 2250 3400 0    50   Output ~ 0
ETH_RXD1
Text HLabel 2250 3800 0    50   Input ~ 0
ETH_MDC
Wire Wire Line
	2250 3700 3000 3700
Wire Wire Line
	2250 3800 3600 3800
$Comp
L archive:Device_Crystal_GND24 Y2
U 1 1 5EA3FAD7
P 3100 4750
F 0 "Y2" H 2950 5000 50  0000 L CNN
F 1 "25.000 Mhz" H 2900 4500 50  0000 L CNN
F 2 "PatternLibs:Crystal_SMD_Geyer_KX-7T-4Pin_3.2x2.5mm" H 3100 4750 50  0001 C CNN
F 3 "~" H 3100 4750 50  0001 C CNN
F 4 "KX-7 25.0 MHz" H 2800 5050 50  0001 L CNN "PartNumber"
F 5 "30ppm" H 2950 4400 50  0000 L CNN "Tolerance"
	1    3100 4750
	1    0    0    -1  
$EndComp
$Comp
L archive:Device_C_Small C?
U 1 1 5EA400A8
P 2700 5000
AR Path="/5E77BE3B/5EA400A8" Ref="C?"  Part="1" 
AR Path="/5E77BE73/5EA400A8" Ref="C28"  Part="1" 
F 0 "C28" H 2792 5137 50  0000 L CNN
F 1 "22pF" H 2792 5046 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 2700 5000 50  0001 C CNN
F 3 "~" H 2700 5000 50  0001 C CNN
F 4 "GRM1885C1H220JA01D" H 2700 5000 50  0001 C CNN "PartNumber"
F 5 "6V3" H 2792 4955 50  0000 L CNN "Ratio"
F 6 "NP0" H 2792 4864 50  0000 L CNN "Tolerance"
	1    2700 5000
	-1   0    0    -1  
$EndComp
$Comp
L archive:Device_C_Small C?
U 1 1 5EA40C2B
P 3500 5000
AR Path="/5E77BE3B/5EA40C2B" Ref="C?"  Part="1" 
AR Path="/5E77BE73/5EA40C2B" Ref="C31"  Part="1" 
F 0 "C31" H 3592 5137 50  0000 L CNN
F 1 "22pF" H 3592 5046 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 3500 5000 50  0001 C CNN
F 3 "~" H 3500 5000 50  0001 C CNN
F 4 "GRM1885C1H220JA01D" H 3500 5000 50  0001 C CNN "PartNumber"
F 5 "6V3" H 3592 4955 50  0000 L CNN "Ratio"
F 6 "NP0" H 3592 4864 50  0000 L CNN "Tolerance"
	1    3500 5000
	1    0    0    -1  
$EndComp
Wire Wire Line
	3600 4300 2700 4300
Wire Wire Line
	2700 4300 2700 4750
Wire Wire Line
	3600 4400 3500 4400
Wire Wire Line
	3500 4400 3500 4750
$Comp
L archive:power_GND #PWR094
U 1 1 5EA5CAB4
P 3500 5200
F 0 "#PWR094" H 3500 4950 50  0001 C CNN
F 1 "GND" H 3505 5027 50  0000 C CNN
F 2 "" H 3500 5200 50  0001 C CNN
F 3 "" H 3500 5200 50  0001 C CNN
	1    3500 5200
	1    0    0    -1  
$EndComp
$Comp
L archive:power_GND #PWR092
U 1 1 5EA5CDB2
P 3100 5200
F 0 "#PWR092" H 3100 4950 50  0001 C CNN
F 1 "GND" H 3105 5027 50  0000 C CNN
F 2 "" H 3100 5200 50  0001 C CNN
F 3 "" H 3100 5200 50  0001 C CNN
	1    3100 5200
	1    0    0    -1  
$EndComp
$Comp
L archive:power_GND #PWR089
U 1 1 5EA5D053
P 2700 5200
F 0 "#PWR089" H 2700 4950 50  0001 C CNN
F 1 "GND" H 2705 5027 50  0000 C CNN
F 2 "" H 2700 5200 50  0001 C CNN
F 3 "" H 2700 5200 50  0001 C CNN
	1    2700 5200
	1    0    0    -1  
$EndComp
Wire Wire Line
	2950 4750 2700 4750
Connection ~ 2700 4750
Wire Wire Line
	2700 4750 2700 4900
Wire Wire Line
	3250 4750 3500 4750
Connection ~ 3500 4750
Wire Wire Line
	3500 4750 3500 4900
Wire Wire Line
	3100 4950 3100 5200
Wire Wire Line
	3100 4550 3100 4450
Wire Wire Line
	2700 5100 2700 5200
Wire Wire Line
	3500 5100 3500 5200
$Comp
L archive:Device_R_Small R?
U 1 1 5EA73827
P 3100 4100
AR Path="/5E77BE3B/5EA73827" Ref="R?"  Part="1" 
AR Path="/5E77BE73/5EA73827" Ref="R32"  Part="1" 
F 0 "R32" V 3150 4200 50  0000 L CNN
F 1 "33R" V 3150 3900 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" H 3100 4100 50  0001 C CNN
F 3 "~" H 3100 4100 50  0001 C CNN
F 4 "RC0603FR-0733RL" H 3100 4100 50  0001 C CNN "PartNumber"
F 5 "5%" V 3150 3750 50  0000 C CNN "Tolerance"
	1    3100 4100
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2850 4100 3000 4100
Wire Wire Line
	3200 4100 3600 4100
$Comp
L archive:power_GND #PWR087
U 1 1 5EA6CA65
P 2300 5200
F 0 "#PWR087" H 2300 4950 50  0001 C CNN
F 1 "GND" H 2305 5027 50  0000 C CNN
F 2 "" H 2300 5200 50  0001 C CNN
F 3 "" H 2300 5200 50  0001 C CNN
	1    2300 5200
	1    0    0    -1  
$EndComp
Wire Wire Line
	3100 4450 2300 4450
Wire Wire Line
	2300 4450 2300 5200
$Comp
L archive:Device_R_Small R?
U 1 1 5EA9DD2C
P 3000 2750
AR Path="/5E77BE3B/5EA9DD2C" Ref="R?"  Part="1" 
AR Path="/5E77BE73/5EA9DD2C" Ref="R31"  Part="1" 
F 0 "R31" H 3059 2841 50  0000 L CNN
F 1 "1.5k" H 3059 2750 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric" H 3000 2750 50  0001 C CNN
F 3 "~" H 3000 2750 50  0001 C CNN
F 4 "RC0603JR-071K5L" H 3000 2750 50  0001 C CNN "PartNumber"
F 5 "5%" H 3059 2659 50  0000 L CNN "Tolerance"
	1    3000 2750
	1    0    0    -1  
$EndComp
$Comp
L archive:Device_R_Small R?
U 1 1 5EA9E41F
P 3300 2750
AR Path="/5E77BE3B/5EA9E41F" Ref="R?"  Part="1" 
AR Path="/5E77BE73/5EA9E41F" Ref="R33"  Part="1" 
F 0 "R33" H 3359 2841 50  0000 L CNN
F 1 "10k" H 3359 2750 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric" H 3300 2750 50  0001 C CNN
F 3 "~" H 3300 2750 50  0001 C CNN
F 4 "RC0603FR-0710KL" H 3300 2750 50  0001 C CNN "PartNumber"
F 5 "5%" H 3359 2659 50  0000 L CNN "Tolerance"
	1    3300 2750
	1    0    0    -1  
$EndComp
Wire Wire Line
	3000 2850 3000 3700
Connection ~ 3000 3700
Wire Wire Line
	3000 3700 3600 3700
Wire Wire Line
	3600 4000 3300 4000
Wire Wire Line
	3300 4000 3300 2850
Wire Wire Line
	3300 4000 2250 4000
Connection ~ 3300 4000
Text HLabel 2250 4000 0    50   Input ~ 0
ETH_~NRST
Wire Wire Line
	3000 2450 3000 2550
Wire Wire Line
	3300 2650 3300 2550
Wire Wire Line
	3300 2550 3000 2550
Connection ~ 3000 2550
Wire Wire Line
	3000 2550 3000 2650
$Comp
L archive:Device_C_Small C?
U 1 1 5EAB399D
P 1500 6750
AR Path="/5E77BE3B/5EAB399D" Ref="C?"  Part="1" 
AR Path="/5E77BE73/5EAB399D" Ref="C26"  Part="1" 
F 0 "C26" H 1592 6887 50  0000 L CNN
F 1 "4.7uF" H 1592 6796 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 1500 6750 50  0001 C CNN
F 3 "~" H 1500 6750 50  0001 C CNN
F 4 "CC0603KRX5R6BB475" H 1500 6750 50  0001 C CNN "PartNumber"
F 5 "10V" H 1592 6705 50  0000 L CNN "Ratio"
F 6 "X7R" H 1592 6614 50  0000 L CNN "Tolerance"
	1    1500 6750
	1    0    0    -1  
$EndComp
$Comp
L archive:Device_C_Small C?
U 1 1 5EAB41CB
P 2000 6750
AR Path="/5E77BE3B/5EAB41CB" Ref="C?"  Part="1" 
AR Path="/5E77BE73/5EAB41CB" Ref="C27"  Part="1" 
F 0 "C27" H 2092 6887 50  0000 L CNN
F 1 "100n" H 2092 6796 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 2000 6750 50  0001 C CNN
F 3 "~" H 2000 6750 50  0001 C CNN
F 4 "CC0603KRX7R9BB104" H 2000 6750 50  0001 C CNN "PartNumber"
F 5 "6V3" H 2092 6705 50  0000 L CNN "Ratio"
F 6 "X7R" H 2092 6614 50  0000 L CNN "Tolerance"
	1    2000 6750
	1    0    0    -1  
$EndComp
$Comp
L archive:Device_Ferrite_Bead_Small FB?
U 1 1 5EAB634B
P 3500 6500
AR Path="/5E77BE3B/5EAB634B" Ref="FB?"  Part="1" 
AR Path="/5E77BE73/5EAB634B" Ref="FB5"  Part="1" 
F 0 "FB5" V 3250 6500 50  0000 C CNN
F 1 "1000R @ 100 MHz" V 3350 6500 50  0000 C CNN
F 2 "Inductor_SMD:L_0603_1608Metric" V 3430 6500 50  0001 C CNN
F 3 "~" H 3500 6500 50  0001 C CNN
F 4 "BLM18AG102SN1D" H 3500 6500 50  0001 C CNN "PartNumber"
	1    3500 6500
	0    1    1    0   
$EndComp
$Comp
L archive:Device_Ferrite_Bead_Small FB?
U 1 1 5EABC2D7
P 1300 6500
AR Path="/5E77BE3B/5EABC2D7" Ref="FB?"  Part="1" 
AR Path="/5E77BE73/5EABC2D7" Ref="FB4"  Part="1" 
F 0 "FB4" V 1050 6500 50  0000 C CNN
F 1 "1000R @ 100 MHz" V 1150 6500 50  0000 C CNN
F 2 "Inductor_SMD:L_0603_1608Metric" V 1230 6500 50  0001 C CNN
F 3 "~" H 1300 6500 50  0001 C CNN
F 4 "BLM18AG102SN1D" H 1300 6500 50  0001 C CNN "PartNumber"
	1    1300 6500
	0    1    1    0   
$EndComp
$Comp
L archive:power_+3V3 #PWR?
U 1 1 5EABC2DD
P 1100 6500
AR Path="/5E77BE3B/5EABC2DD" Ref="#PWR?"  Part="1" 
AR Path="/5E77BE73/5EABC2DD" Ref="#PWR083"  Part="1" 
F 0 "#PWR083" H 1100 6350 50  0001 C CNN
F 1 "+3V3" V 1100 6650 50  0000 L CNN
F 2 "" H 1100 6500 50  0001 C CNN
F 3 "" H 1100 6500 50  0001 C CNN
	1    1100 6500
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1100 6500 1200 6500
$Comp
L archive:power_GND #PWR084
U 1 1 5EADDF44
P 1500 7000
F 0 "#PWR084" H 1500 6750 50  0001 C CNN
F 1 "GND" H 1505 6827 50  0000 C CNN
F 2 "" H 1500 7000 50  0001 C CNN
F 3 "" H 1500 7000 50  0001 C CNN
	1    1500 7000
	1    0    0    -1  
$EndComp
$Comp
L archive:power_GND #PWR086
U 1 1 5EADE6AF
P 2000 7000
F 0 "#PWR086" H 2000 6750 50  0001 C CNN
F 1 "GND" H 2005 6827 50  0000 C CNN
F 2 "" H 2000 7000 50  0001 C CNN
F 3 "" H 2000 7000 50  0001 C CNN
	1    2000 7000
	1    0    0    -1  
$EndComp
Wire Wire Line
	1400 6500 1500 6500
Wire Wire Line
	2000 6500 2000 6650
Wire Wire Line
	1500 6650 1500 6500
Connection ~ 1500 6500
Wire Wire Line
	1500 6500 2000 6500
Wire Wire Line
	1500 6850 1500 7000
Wire Wire Line
	2000 6850 2000 7000
$Comp
L archive:power_+3V3 #PWR?
U 1 1 5EB00B6A
P 2600 6500
AR Path="/5E77BE3B/5EB00B6A" Ref="#PWR?"  Part="1" 
AR Path="/5E77BE73/5EB00B6A" Ref="#PWR088"  Part="1" 
F 0 "#PWR088" H 2600 6350 50  0001 C CNN
F 1 "+3V3" V 2600 6650 50  0000 L CNN
F 2 "" H 2600 6500 50  0001 C CNN
F 3 "" H 2600 6500 50  0001 C CNN
	1    2600 6500
	0    -1   -1   0   
$EndComp
$Comp
L archive:Device_C_Small C?
U 1 1 5EB04847
P 6000 6750
AR Path="/5E77BE3B/5EB04847" Ref="C?"  Part="1" 
AR Path="/5E77BE73/5EB04847" Ref="C37"  Part="1" 
F 0 "C37" H 6092 6887 50  0000 L CNN
F 1 "1uF" H 6092 6796 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 6000 6750 50  0001 C CNN
F 3 "~" H 6000 6750 50  0001 C CNN
F 4 "GRM188R71C105KA12D" H 6000 6750 50  0001 C CNN "PartNumber"
F 5 "16V" H 6092 6705 50  0000 L CNN "Ratio"
F 6 "X7R" H 6092 6614 50  0000 L CNN "Tolerance"
	1    6000 6750
	1    0    0    -1  
$EndComp
$Comp
L archive:Device_C_Small C?
U 1 1 5EB04850
P 6500 6750
AR Path="/5E77BE3B/5EB04850" Ref="C?"  Part="1" 
AR Path="/5E77BE73/5EB04850" Ref="C38"  Part="1" 
F 0 "C38" H 6592 6887 50  0000 L CNN
F 1 "470pF" H 6592 6796 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 6500 6750 50  0001 C CNN
F 3 "~" H 6500 6750 50  0001 C CNN
F 4 "GRM188R71H471KA01D" H 6500 6750 50  0001 C CNN "PartNumber"
F 5 "50V" H 6592 6705 50  0000 L CNN "Ratio"
F 6 "X7R" H 6592 6614 50  0000 L CNN "Tolerance"
	1    6500 6750
	1    0    0    -1  
$EndComp
$Comp
L archive:power_GND #PWR0106
U 1 1 5EB04856
P 6000 6950
F 0 "#PWR0106" H 6000 6700 50  0001 C CNN
F 1 "GND" H 6005 6777 50  0000 C CNN
F 2 "" H 6000 6950 50  0001 C CNN
F 3 "" H 6000 6950 50  0001 C CNN
	1    6000 6950
	1    0    0    -1  
$EndComp
$Comp
L archive:power_GND #PWR0108
U 1 1 5EB0485C
P 6500 6950
F 0 "#PWR0108" H 6500 6700 50  0001 C CNN
F 1 "GND" H 6505 6777 50  0000 C CNN
F 2 "" H 6500 6950 50  0001 C CNN
F 3 "" H 6500 6950 50  0001 C CNN
	1    6500 6950
	1    0    0    -1  
$EndComp
Wire Wire Line
	6500 6500 6500 6650
Wire Wire Line
	6000 6650 6000 6500
Wire Wire Line
	6000 6850 6000 6950
Wire Wire Line
	6500 6850 6500 6950
Text Label 6600 6500 0    50   ~ 0
VDDCR
Wire Wire Line
	6600 6500 6500 6500
Wire Wire Line
	6500 6500 6000 6500
Connection ~ 6500 6500
Wire Wire Line
	3400 6500 3100 6500
$Comp
L archive:power_+3V3 #PWR?
U 1 1 5EB285ED
P 3000 2450
AR Path="/5E77BE3B/5EB285ED" Ref="#PWR?"  Part="1" 
AR Path="/5E77BE73/5EB285ED" Ref="#PWR091"  Part="1" 
F 0 "#PWR091" H 3000 2300 50  0001 C CNN
F 1 "+3V3" H 2900 2600 50  0000 L CNN
F 2 "" H 3000 2450 50  0001 C CNN
F 3 "" H 3000 2450 50  0001 C CNN
	1    3000 2450
	1    0    0    -1  
$EndComp
$Comp
L archive:Device_C_Small C?
U 1 1 5EB2E60F
P 2700 6750
AR Path="/5E77BE3B/5EB2E60F" Ref="C?"  Part="1" 
AR Path="/5E77BE73/5EB2E60F" Ref="C29"  Part="1" 
F 0 "C29" H 2792 6887 50  0000 L CNN
F 1 "10uF" H 2792 6796 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 2700 6750 50  0001 C CNN
F 3 "~" H 2700 6750 50  0001 C CNN
F 4 "CC0603KRX5R6BB106" H 2700 6750 50  0001 C CNN "PartNumber"
F 5 "10V" H 2792 6705 50  0000 L CNN "Ratio"
F 6 "X7R" H 2792 6614 50  0000 L CNN "Tolerance"
	1    2700 6750
	1    0    0    -1  
$EndComp
$Comp
L archive:power_GND #PWR090
U 1 1 5EB370B2
P 2700 7000
F 0 "#PWR090" H 2700 6750 50  0001 C CNN
F 1 "GND" H 2705 6827 50  0000 C CNN
F 2 "" H 2700 7000 50  0001 C CNN
F 3 "" H 2700 7000 50  0001 C CNN
	1    2700 7000
	1    0    0    -1  
$EndComp
$Comp
L archive:Device_C_Small C?
U 1 1 5EB3ECF6
P 3100 6750
AR Path="/5E77BE3B/5EB3ECF6" Ref="C?"  Part="1" 
AR Path="/5E77BE73/5EB3ECF6" Ref="C30"  Part="1" 
F 0 "C30" H 3192 6887 50  0000 L CNN
F 1 "100n" H 3192 6796 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 3100 6750 50  0001 C CNN
F 3 "~" H 3100 6750 50  0001 C CNN
F 4 "CC0603KRX7R9BB104" H 3100 6750 50  0001 C CNN "PartNumber"
F 5 "6V3" H 3192 6705 50  0000 L CNN "Ratio"
F 6 "X7R" H 3192 6614 50  0000 L CNN "Tolerance"
	1    3100 6750
	1    0    0    -1  
$EndComp
$Comp
L archive:Device_C_Small C?
U 1 1 5EB3F29B
P 4150 6750
AR Path="/5E77BE3B/5EB3F29B" Ref="C?"  Part="1" 
AR Path="/5E77BE73/5EB3F29B" Ref="C33"  Part="1" 
F 0 "C33" H 4242 6887 50  0000 L CNN
F 1 "100n" H 4242 6796 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 4150 6750 50  0001 C CNN
F 3 "~" H 4150 6750 50  0001 C CNN
F 4 "CC0603KRX7R9BB104" H 4150 6750 50  0001 C CNN "PartNumber"
F 5 "16V" H 4242 6705 50  0000 L CNN "Ratio"
F 6 "X7R" H 4242 6614 50  0000 L CNN "Tolerance"
	1    4150 6750
	1    0    0    -1  
$EndComp
$Comp
L archive:Device_C_Small C?
U 1 1 5EB3F8F0
P 4550 6750
AR Path="/5E77BE3B/5EB3F8F0" Ref="C?"  Part="1" 
AR Path="/5E77BE73/5EB3F8F0" Ref="C34"  Part="1" 
F 0 "C34" H 4642 6887 50  0000 L CNN
F 1 "10n" H 4642 6796 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 4550 6750 50  0001 C CNN
F 3 "~" H 4550 6750 50  0001 C CNN
F 4 "CC0603KRX7R9BB103" H 4550 6750 50  0001 C CNN "PartNumber"
F 5 "16V" H 4642 6705 50  0000 L CNN "Ratio"
F 6 "X7R" H 4642 6614 50  0000 L CNN "Tolerance"
	1    4550 6750
	1    0    0    -1  
$EndComp
$Comp
L archive:Device_C_Small C?
U 1 1 5EB3FE2B
P 4950 6750
AR Path="/5E77BE3B/5EB3FE2B" Ref="C?"  Part="1" 
AR Path="/5E77BE73/5EB3FE2B" Ref="C35"  Part="1" 
F 0 "C35" H 5042 6887 50  0000 L CNN
F 1 "100n" H 5042 6796 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 4950 6750 50  0001 C CNN
F 3 "~" H 4950 6750 50  0001 C CNN
F 4 "CC0603KRX7R9BB104" H 4950 6750 50  0001 C CNN "PartNumber"
F 5 "6V3" H 5042 6705 50  0000 L CNN "Ratio"
F 6 "X7R" H 5042 6614 50  0000 L CNN "Tolerance"
	1    4950 6750
	1    0    0    -1  
$EndComp
$Comp
L archive:Device_C_Small C?
U 1 1 5EB4095A
P 5350 6750
AR Path="/5E77BE3B/5EB4095A" Ref="C?"  Part="1" 
AR Path="/5E77BE73/5EB4095A" Ref="C36"  Part="1" 
F 0 "C36" H 5442 6887 50  0000 L CNN
F 1 "10n" H 5442 6796 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 5350 6750 50  0001 C CNN
F 3 "~" H 5350 6750 50  0001 C CNN
F 4 "CC0603KRX7R9BB103" H 5350 6750 50  0001 C CNN "PartNumber"
F 5 "16V" H 5442 6705 50  0000 L CNN "Ratio"
F 6 "X7R" H 5442 6614 50  0000 L CNN "Tolerance"
	1    5350 6750
	1    0    0    -1  
$EndComp
$Comp
L archive:power_GND #PWR093
U 1 1 5EB40E14
P 3100 7000
F 0 "#PWR093" H 3100 6750 50  0001 C CNN
F 1 "GND" H 3105 6827 50  0000 C CNN
F 2 "" H 3100 7000 50  0001 C CNN
F 3 "" H 3100 7000 50  0001 C CNN
	1    3100 7000
	1    0    0    -1  
$EndComp
$Comp
L archive:power_GND #PWR096
U 1 1 5EB41071
P 4150 7000
F 0 "#PWR096" H 4150 6750 50  0001 C CNN
F 1 "GND" H 4155 6827 50  0000 C CNN
F 2 "" H 4150 7000 50  0001 C CNN
F 3 "" H 4150 7000 50  0001 C CNN
	1    4150 7000
	1    0    0    -1  
$EndComp
$Comp
L archive:power_GND #PWR0100
U 1 1 5EB412EC
P 4550 7000
F 0 "#PWR0100" H 4550 6750 50  0001 C CNN
F 1 "GND" H 4555 6827 50  0000 C CNN
F 2 "" H 4550 7000 50  0001 C CNN
F 3 "" H 4550 7000 50  0001 C CNN
	1    4550 7000
	1    0    0    -1  
$EndComp
$Comp
L archive:power_GND #PWR0101
U 1 1 5EB4146B
P 4950 7000
F 0 "#PWR0101" H 4950 6750 50  0001 C CNN
F 1 "GND" H 4955 6827 50  0000 C CNN
F 2 "" H 4950 7000 50  0001 C CNN
F 3 "" H 4950 7000 50  0001 C CNN
	1    4950 7000
	1    0    0    -1  
$EndComp
$Comp
L archive:power_GND #PWR0103
U 1 1 5EB41731
P 5350 7000
F 0 "#PWR0103" H 5350 6750 50  0001 C CNN
F 1 "GND" H 5355 6827 50  0000 C CNN
F 2 "" H 5350 7000 50  0001 C CNN
F 3 "" H 5350 7000 50  0001 C CNN
	1    5350 7000
	1    0    0    -1  
$EndComp
Wire Wire Line
	5350 6500 5350 6650
Wire Wire Line
	4950 6650 4950 6500
Connection ~ 4950 6500
Wire Wire Line
	4950 6500 5350 6500
Wire Wire Line
	4550 6650 4550 6500
Connection ~ 4550 6500
Wire Wire Line
	4550 6500 4950 6500
Wire Wire Line
	4150 6650 4150 6500
Connection ~ 4150 6500
Wire Wire Line
	4150 6500 4550 6500
Wire Wire Line
	3100 6650 3100 6500
Connection ~ 3100 6500
Wire Wire Line
	3100 6500 2700 6500
Wire Wire Line
	2700 6650 2700 6500
Connection ~ 2700 6500
Wire Wire Line
	2700 6500 2600 6500
Wire Wire Line
	2700 6850 2700 7000
Wire Wire Line
	3100 6850 3100 7000
Wire Wire Line
	4150 6850 4150 7000
Wire Wire Line
	4550 6850 4550 7000
Wire Wire Line
	4950 6850 4950 7000
Wire Wire Line
	5350 6850 5350 7000
$Comp
L archive:Device_C_Small C?
U 1 1 5EB7FC17
P 3750 6750
AR Path="/5E77BE3B/5EB7FC17" Ref="C?"  Part="1" 
AR Path="/5E77BE73/5EB7FC17" Ref="C32"  Part="1" 
F 0 "C32" H 3842 6887 50  0000 L CNN
F 1 "10uF" H 3842 6796 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 3750 6750 50  0001 C CNN
F 3 "~" H 3750 6750 50  0001 C CNN
F 4 "CC0603KRX5R6BB106" H 3750 6750 50  0001 C CNN "PartNumber"
F 5 "10V" H 3842 6705 50  0000 L CNN "Ratio"
F 6 "X7R" H 3842 6614 50  0000 L CNN "Tolerance"
	1    3750 6750
	1    0    0    -1  
$EndComp
$Comp
L archive:power_GND #PWR095
U 1 1 5EB802CF
P 3750 7000
F 0 "#PWR095" H 3750 6750 50  0001 C CNN
F 1 "GND" H 3755 6827 50  0000 C CNN
F 2 "" H 3750 7000 50  0001 C CNN
F 3 "" H 3750 7000 50  0001 C CNN
	1    3750 7000
	1    0    0    -1  
$EndComp
Wire Wire Line
	3750 7000 3750 6850
Wire Wire Line
	3600 6500 3750 6500
Wire Wire Line
	3750 6650 3750 6500
Connection ~ 3750 6500
Wire Wire Line
	3750 6500 4150 6500
$Comp
L archive:power_+3.3VA #PWR0107
U 1 1 5E7C277E
P 6450 2500
F 0 "#PWR0107" H 6450 2350 50  0001 C CNN
F 1 "+3.3VA" H 6465 2673 50  0000 C CNN
F 2 "" H 6450 2500 50  0001 C CNN
F 3 "" H 6450 2500 50  0001 C CNN
	1    6450 2500
	1    0    0    -1  
$EndComp
$Comp
L archive:power_+3.3VA #PWR099
U 1 1 5EB94FEF
P 4500 2200
F 0 "#PWR099" H 4500 2050 50  0001 C CNN
F 1 "+3.3VA" H 4550 2350 50  0000 C CNN
F 2 "" H 4500 2200 50  0001 C CNN
F 3 "" H 4500 2200 50  0001 C CNN
	1    4500 2200
	1    0    0    -1  
$EndComp
Wire Wire Line
	4500 2400 4500 2300
Wire Wire Line
	4400 2400 4400 2300
Wire Wire Line
	4400 2300 4500 2300
Connection ~ 4500 2300
Wire Wire Line
	4500 2300 4500 2200
$Comp
L archive:power_+3.3VA #PWR0102
U 1 1 5EBA0A32
P 5350 6300
F 0 "#PWR0102" H 5350 6150 50  0001 C CNN
F 1 "+3.3VA" H 5365 6473 50  0000 C CNN
F 2 "" H 5350 6300 50  0001 C CNN
F 3 "" H 5350 6300 50  0001 C CNN
	1    5350 6300
	1    0    0    -1  
$EndComp
Wire Wire Line
	5350 6300 5350 6500
Connection ~ 5350 6500
Text Label 4300 2200 1    50   ~ 0
VDDCR
Wire Wire Line
	4300 2200 4300 2400
$Comp
L archive:power_VDD #PWR085
U 1 1 5EBAD547
P 2000 6300
F 0 "#PWR085" H 2000 6150 50  0001 C CNN
F 1 "VDD" H 2017 6473 50  0000 C CNN
F 2 "" H 2000 6300 50  0001 C CNN
F 3 "" H 2000 6300 50  0001 C CNN
	1    2000 6300
	1    0    0    -1  
$EndComp
Wire Wire Line
	2000 6300 2000 6500
Connection ~ 2000 6500
$Comp
L archive:power_VDD #PWR097
U 1 1 5EBB3965
P 4200 2200
F 0 "#PWR097" H 4200 2050 50  0001 C CNN
F 1 "VDD" H 4150 2350 50  0000 C CNN
F 2 "" H 4200 2200 50  0001 C CNN
F 3 "" H 4200 2200 50  0001 C CNN
	1    4200 2200
	1    0    0    -1  
$EndComp
Wire Wire Line
	4200 2200 4200 2400
Text Notes 500  3450 0    100  ~ 0
RXERROR Pin???
Wire Wire Line
	6200 3300 7700 3300
Wire Wire Line
	6700 2900 6700 3200
Connection ~ 6700 3200
Wire Wire Line
	6700 3200 7700 3200
Wire Wire Line
	7500 5200 7500 5300
Wire Wire Line
	7000 5000 7200 5000
$Comp
L archive:power_GND #PWR0127
U 1 1 5E8445C0
P 7500 5300
F 0 "#PWR0127" H 7500 5050 50  0001 C CNN
F 1 "GND" H 7505 5127 50  0000 C CNN
F 2 "" H 7500 5300 50  0001 C CNN
F 3 "" H 7500 5300 50  0001 C CNN
	1    7500 5300
	1    0    0    -1  
$EndComp
$Comp
L archive:Transistor_FET_BSS138 Q1
U 1 1 5E8427D6
P 7400 5000
F 0 "Q1" H 7604 5046 50  0000 L CNN
F 1 "BSS138" H 7604 4955 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 7600 4925 50  0001 L CIN
F 3 "https://www.fairchildsemi.com/datasheets/BS/BSS138.pdf" H 7400 5000 50  0001 L CNN
F 4 "BSS138-7-F" H 7400 5000 50  0001 C CNN "PartNumber"
	1    7400 5000
	1    0    0    -1  
$EndComp
Wire Wire Line
	7500 6000 7500 6100
Wire Wire Line
	7000 5800 7200 5800
$Comp
L archive:power_GND #PWR0128
U 1 1 5E85D6A0
P 7500 6100
F 0 "#PWR0128" H 7500 5850 50  0001 C CNN
F 1 "GND" H 7505 5927 50  0000 C CNN
F 2 "" H 7500 6100 50  0001 C CNN
F 3 "" H 7500 6100 50  0001 C CNN
	1    7500 6100
	1    0    0    -1  
$EndComp
$Comp
L archive:Transistor_FET_BSS138 Q2
U 1 1 5E85D6AA
P 7400 5800
F 0 "Q2" H 7604 5846 50  0000 L CNN
F 1 "BSS138" H 7604 5755 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 7600 5725 50  0001 L CIN
F 3 "https://www.fairchildsemi.com/datasheets/BS/BSS138.pdf" H 7400 5800 50  0001 L CNN
F 4 "BSS138-7-F" H 7400 5800 50  0001 C CNN "PartNumber"
	1    7400 5800
	1    0    0    -1  
$EndComp
Wire Wire Line
	7500 4700 7500 4800
Wire Wire Line
	7800 5600 7500 5600
Wire Wire Line
	8500 5100 8100 5100
Wire Wire Line
	8000 5600 8100 5600
Wire Wire Line
	8100 5600 8100 5100
$Comp
L archive:power_GND #PWR0104
U 1 1 5E8CD50B
P 5200 4550
F 0 "#PWR0104" H 5200 4300 50  0001 C CNN
F 1 "GND" H 5205 4377 50  0000 C CNN
F 2 "" H 5200 4550 50  0001 C CNN
F 3 "" H 5200 4550 50  0001 C CNN
	1    5200 4550
	1    0    0    -1  
$EndComp
Wire Wire Line
	5200 4450 5200 4550
Text Label 7000 5800 2    50   ~ 0
LED1_LINK_ACT
Text Label 7000 5000 2    50   ~ 0
LED2_SPEED
Text Label 5500 3100 0    50   ~ 0
TX+
Text Label 5500 3200 0    50   ~ 0
TX-
Text Label 5500 3300 0    50   ~ 0
RX+
Text Label 5500 3400 0    50   ~ 0
RX-
$Comp
L archive:power_+3V3 #PWR?
U 1 1 5E8679C6
P 8400 4200
AR Path="/5E77BE3B/5E8679C6" Ref="#PWR?"  Part="1" 
AR Path="/5E77BE73/5E8679C6" Ref="#PWR0112"  Part="1" 
F 0 "#PWR0112" H 8400 4050 50  0001 C CNN
F 1 "+3V3" H 8300 4350 50  0000 L CNN
F 2 "" H 8400 4200 50  0001 C CNN
F 3 "" H 8400 4200 50  0001 C CNN
	1    8400 4200
	1    0    0    -1  
$EndComp
Text HLabel 2250 3500 0    50   Output ~ 0
ETH_RXERR
$EndSCHEMATC
