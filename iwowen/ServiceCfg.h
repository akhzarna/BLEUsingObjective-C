//
//  ServiceCfg.h
//  Vidonn
//
//  Created by 曾 言伟 on 13-6-15.
//  Copyright (c) 2013年 曾 言伟. All rights reserved.
//

#ifndef Vidonn_ServiceCfg_h
#define Vidonn_ServiceCfg_h

//PedoMeter Service

#define VIDONN_service_pedometer_UUID                           0xFF01//main service
#define VIDONN_characteristic_device_name_UUID                  0xF005//name
#define VIDONN_characteristic_device_name_LEN                   20
#define VIDONN_characteristic_temperature_measurement_UUID      0x2A1C//temperature
#define VIDONN_characteristic_alarmclock_contrl_point_UUID      0xF001//alarm clock
#define VIDONN_characteristic_pedometer_configuration_UUID      0xF002//hight....
#define VIDONN_characteristic_pedometer_configuration_LEN       20
#define VIDONN_characteristic_pedometer_measurement_UUID        0xF003//step
#define VIDONN_characteristic_led_control_point_UUID            0xF004//led
#define VIDONN_characteristic_Pair                              0xF007
#define VIDONN_characteristic_Time                              0xF006

#define VIDONN_characteristic_alert_UUID                        0x1802
#define VIDONN_characteristic_alert_level_UUID                  0x2A06
#define VIDONN_main_service_pedometer_UUID                      0x1800

#define VIDONN_battery_service_UUID                             0x180f//Battery service
#define VIDONN_battery_level_UUID                               0x2a19//Battery
#define VIDONN_battery_level_LEN                                1

#endif
