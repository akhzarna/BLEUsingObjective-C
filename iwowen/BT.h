//
//  BT.h
//  BTDemo
//
//  Created by 曾 言伟 on 13-11-15.
//  Copyright (c) 2013年 曾 言伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreBluetooth/CBService.h>
#import "DeviceData.h"

@protocol LeDiscoveryDelegate <NSObject>

- (void) discoveryDidRefresh:(NSMutableArray*) peripherals;
- (void) connectPeripheral;
- (void) disconnectPeripheral;
- (void) didUpdateValueForCharacteristic:(NSString*) value;
- (void) currentDeviceData:(DeviceData*) info;
- (void) FourDidgitCodeAuth;

@end


@interface BT : NSObject<CBCentralManagerDelegate, CBPeripheralDelegate>
{
    CBCentralManager *CM;
    CBPeripheral *activePeripheral;
    CBCharacteristic *activePeripheralCharacteristics;
    NSString *suuid;
    NSMutableArray *peripherals;
    
    int currentRequest;
}

@property (nonatomic, assign) id <LeDiscoveryDelegate> discoveryDelegate;
@property (strong, nonatomic) CBCentralManager *CM;
@property (strong, nonatomic) CBPeripheral *activePeripheral;

- (void) initCM;
- (void)scan;
-(void) connectPeripheral:(CBPeripheral *)peripheral;

- (void) disconnectPeripheral:(CBPeripheral *)peripheral;
- (BOOL) isconnectPeripheral;
- (void) cleanup;

-(void) readGeneralInfo:(int)serviceUUID characteristicUUID:(int)characteristicUUID;
-(void) writeValue:(int)serviceUUID characteristicUUID:(int)characteristicUUID  data:(NSData *)data;

@end
