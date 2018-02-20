//
//  BT.m
//  BTDemo
//
//  Created by 曾 言伟 on 13-11-15.
//  Copyright (c) 2013年 曾 言伟. All rights reserved.
//

#import "BT.h"
#import "ServiceCfg.h"
#import "Globals.h"
#import "FourDidgitViewController.h"

@implementation BT
@synthesize CM;
@synthesize activePeripheral;
@synthesize discoveryDelegate;

- (void) initCM
{
    
    if(self.CM == nil)
        self.CM = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    peripherals = [[NSMutableArray alloc] initWithCapacity:0];
    
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    if (central.state != CBCentralManagerStatePoweredOn) {
        // In a real app, you'd deal with all the states correctly
        return;
    }
}

- (void)scan
{
    
    if (self->CM.state  != CBCentralManagerStatePoweredOn) {
        return;
    }
    [peripherals removeAllObjects];
    [self.CM scanForPeripheralsWithServices:nil
                                    options:0];
    
    // [self.CM scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:suuid]]
    //                                            options:@{ CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
    
    NSLog(@"Scanning started");
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    
    NSLog(@"Discovered Periphirals %@",peripheral);
    
    // Reject any where the value is above reasonable range
    if (RSSI.integerValue > -15) {
        // return;
    }
    
    // Reject if the signal strength is too low to be close enough (Close is around -22dB)
    if (RSSI.integerValue < -80) {
        // return;
    }
    
    if(peripheral.name == nil)
        return;
    
    [peripherals addObject:peripheral];
    [discoveryDelegate discoveryDidRefresh:peripherals];
    
    
}

-(void) connectPeripheral:(CBPeripheral *)peripheral
{
    [self.CM connectPeripheral:peripheral options:nil];
}

-(void)  disconnectPeripheral:(CBPeripheral *)peripheral
{
    [self.CM cancelPeripheralConnection:peripheral];
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"Failed to connect to %@. (%@)", peripheral, [error localizedDescription]);
    [self cleanup];
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
   
    NSLog(@"Peripheral Connected");
    self.activePeripheral = peripheral;
    self.activePeripheral.delegate = self;
    [self.activePeripheral discoverServices:nil];
    [discoveryDelegate connectPeripheral];

}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    [discoveryDelegate disconnectPeripheral];
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    
    if (error) {
        NSLog(@"Error discovering services: %@", [error localizedDescription]);
        [self cleanup];
        return;
    }
        
    for (CBService *service in peripheral.services)
    {
        [peripheral discoverCharacteristics:nil forService:service];
    }
    
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    
    
    //    For testing To Write Data
    
    //    UInt8 buf[1] = {0x02};
    //
    //    NSData *dataToWrite = [[NSData alloc] initWithBytes:buf length:1];
    //
    //    //        [peripheral writeValue:dataToWrite forCharacteristic:interestingCharacteristic type:CBCharacteristicWriteWithResponse];
    //
    //    [peripheral writeValue:dataToWrite forCharacteristic:[CBUUID UUIDWithString:@"F000FF06-0451-4000-B000-000000000000"] type:CBCharacteristicWriteWithResponse];
    
    if (error) {
        
        NSLog(@"Error discovering characteristics: %@", [error localizedDescription]);
        [self cleanup];
        return;
    
    }
    
    // Again, we loop through the array, just in case.
    
    NSLog(@"Characteristics List for service %@ is = %@",service,service.characteristics);
    NSLog(@"Characteristics List for service UUID %@ is = %@",service.UUID,service.characteristics);
    
    for (CBCharacteristic *characteristic in service.characteristics) {
        
//        [peripheral discoverDescriptorsForCharacteristic:characteristic];
        
        NSLog(@"Characteristics list is = %@",characteristic);
        NSLog(@"Characteristics list UUID is = %@",characteristic.UUID);
        
        //        NSData *dataToWrite = [NSData dataWithData:@"1234 1234"];
        
        //        [peripheral writeValue:dataToWrite forCharacteristic:interestingCharacteristic type:CBCharacteristicWriteWithResponse];
        
        
        //        [peripheral readValueForCharacteristic:characteristic];
        
        
        if ([service.UUID isEqual:[CBUUID UUIDWithString:@"F000FF00-0451-4000-B000-000000000000"]]) {
            // If it is, subscribe to it
            NSLog(@"Yes Found Service 0");
            
            
            //To Write Data For Pairing
            
            if([[NSUserDefaults standardUserDefaults] stringForKey:@"BraceletMacAddress"] == nil){
            
          
                
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"F000FF06-0451-4000-B000-000000000000"]]) {
                // If it is, subscribe to it
                NSLog(@"Yes Found Characteristic 6 For Pairing");
                
                
                UInt16 buf[3] = {0x10};
                
                NSLog(@"buf values wParam:%u",buf[0]);
                NSLog(@"buf values wParam:%u",buf[1]);
                NSLog(@"buf values wParam:%u",buf[2]);

                NSData *dataToWrite = [[NSData alloc] initWithBytes:buf length:1];
                
                [peripheral writeValue:dataToWrite forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
                
                //[peripheral setNotifyValue:YES forCharacteristic:characteristic];
                
//                return;
            }
                
                
        }
            
            if([[NSUserDefaults standardUserDefaults] stringForKey:@"BraceletMacAddress"] != nil){
            
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"F000FF03-0451-4000-B000-000000000000"]]) {
                    // If it is, subscribe to it
            NSLog(@"Yes Found Characteristic 3");
            
//            [peripheral discoverDescriptorsForCharacteristic:characteristic];
            
//            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
            
                [peripheral readValueForCharacteristic:characteristic];
                
                activePeripheral = peripheral;
                activePeripheralCharacteristics = characteristic;

            [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(DataSyncWithServer) userInfo:nil repeats:YES];

                
//            [CBCharacteristicPropertyRead];
                
            }
            
        }
//            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"F000FF02-0451-4000-B000-000000000000"]]) {
//                // If it is, subscribe to it
//                NSLog(@"Yes Found Characteristic 3");
//                
//                [peripheral readValueForCharacteristic:characteristic];
//                
//                //            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
//                
//            }
//            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"F000FF01-0451-4000-B000-000000000000"]]) {
//                // If it is, subscribe to it
//                NSLog(@"Yes Found Characteristic 3");
//                
//                [peripheral readValueForCharacteristic:characteristic];
//                
//                //            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
//                
//            }
//            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"F000FF04-0451-4000-B000-000000000000"]]) {
//                // If it is, subscribe to it
//                NSLog(@"Yes Found Characteristic 3");
//                
//                [peripheral readValueForCharacteristic:characteristic];
//                
//                //            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
//                
//            }
//            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"F000FF05-0451-4000-B000-000000000000"]]) {
//                // If it is, subscribe to it
//                NSLog(@"Yes Found Characteristic 3");
//                
//                [peripheral readValueForCharacteristic:characteristic];
//                
//                //            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
//                
//            }
            
            
            
            //            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
            
        }
        
        
        //        if ([service.UUID isEqual:[CBUUID UUIDWithString:@"F000FF01-0451-4000-B000-000000000000"]]) {
        //            // If it is, subscribe to it
        //            NSLog(@"Yes Found 1");
        //            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
        //        }
        //        if ([service.UUID isEqual:[CBUUID UUIDWithString:@"F000FF02-0451-4000-B000-000000000000"]]) {
        //            // If it is, subscribe to it
        //            NSLog(@"Yes Found 2");
        //            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
        //        }
        //        if ([service.UUID isEqual:[CBUUID UUIDWithString:@"F000FF03-0451-4000-B000-000000000000"]]) {
        //            // If it is, subscribe to it
        //            NSLog(@"Yes Found 3");
        //            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
        //        }
        //        if ([service.UUID isEqual:[CBUUID UUIDWithString:@"F000FF04-0451-4000-B000-000000000000"]]) {
        //            // If it is, subscribe to it
        //            NSLog(@"Yes Found 4");
        //            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
        //        }
        //        if ([service.UUID isEqual:[CBUUID UUIDWithString:@"F000FF05-0451-4000-B000-000000000000"]]) {
        //            // If it is, subscribe to it
        //            NSLog(@"Yes Found 5");
        //            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
        //        }
        //        if ([service.UUID isEqual:[CBUUID UUIDWithString:@"F000FF06-0451-4000-B000-000000000000"]]) {
        //            // If it is, subscribe to it
        //            NSLog(@"Yes Found 6");
        //            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
        //        }
        
        
        
    }
    
    
    //    else{
    //        for (CBCharacteristic *characteristic in service.characteristics) {
    //            NSLog(@"Discovered characteristic %@", characteristic.UUID);
    //            NSLog(@"---------------------------------------------------");
    //            NSLog(@"Reading value for characteristic %@", characteristic.UUID);
    //            [peripheral readValueForCharacteristic:characteristic];
    //            NSLog(@"+++++++++++++++++++++++++++++++++++++++++++++++++++");
    //            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
    //        }
    //    }
    
    
}

-(void) DataSyncWithServer{
    
    [activePeripheral readValueForCharacteristic:activePeripheralCharacteristics];

}


//- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
//{
//    if (error) {
//        NSLog(@"Error discovering characteristics: %@", [error localizedDescription]);
//        [self cleanup];
//        return;
//    }
////    else{
////        for (CBCharacteristic *characteristic in service.characteristics) {
////            NSLog(@"Discovered characteristic %@", characteristic.UUID);
////            NSLog(@"---------------------------------------------------");
////            NSLog(@"Reading value for characteristic %@", characteristic.UUID);
////            [peripheral readValueForCharacteristic:characteristic];
////            NSLog(@"+++++++++++++++++++++++++++++++++++++++++++++++++++");
////            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
////        }
////    }
//
//}


-(void) readGeneralInfo:(int)serviceUUID characteristicUUID:(int)characteristicUUID

{
//    if(characteristicUUID == VIDONN_characteristic_pedometer_configuration_UUID){
        currentRequest = characteristicUUID;
//    }

    
    UInt16 s = [self swap:serviceUUID];
    UInt16 c = [self swap:characteristicUUID];
    NSData *sd = [[NSData alloc] initWithBytes:(char *)&s length:2];
    NSData *cd = [[NSData alloc] initWithBytes:(char *)&c length:2];
    CBUUID *su = [CBUUID UUIDWithData:sd];
    CBUUID *cu = [CBUUID UUIDWithData:cd];
    CBService *service = [self findServiceFromUUID:su p:self.activePeripheral];
    if (!service)
    {
       
        return;
    }
    CBCharacteristic *characteristic = [self findCharacteristicFromUUID:cu service:service];
    if (!characteristic)
    {
        
        return;
    }
    
    printf("Characteristics of service with UUID : %s found\r\n",[self CBUUIDToString:characteristic.UUID]);
    
    
    [self.activePeripheral readValueForCharacteristic:characteristic];
    
}

-(void) writeValue:(int)serviceUUID characteristicUUID:(int)characteristicUUID data:(NSData *)data {
    
    UInt16 s = [self swap:serviceUUID];
    UInt16 c = [self swap:characteristicUUID];
    NSData *sd = [[NSData alloc] initWithBytes:(char *)&s length:2];
    NSData *cd = [[NSData alloc] initWithBytes:(char *)&c length:2];
    CBUUID *su = [CBUUID UUIDWithData:sd];
    CBUUID *cu = [CBUUID UUIDWithData:cd];
    CBService *service = [self findServiceFromUUID:su p:self.activePeripheral];
    
    if (!service)
    {
       
        return;
    }
    CBCharacteristic *characteristic = [self findCharacteristicFromUUID:cu service:service];
    if (!characteristic)
    {
                return;
    }
    
    [self.activePeripheral writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithoutResponse];
    
}

-(void) readValueForCharacteristicTest{
    
    
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    
    // For Testing ////
    
//    NSData *data = [characteristic value];
//   
//    NSString *valueDataRaw = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//
//    NSLog(@"data is = %@",valueDataRaw);
//
//    u_int16_t value;
//    
//    [data getBytes:&value length:sizeof(value)];
//    
//    NSString *valueData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//
//    NSLog(@"data is = %@",valueData);
    
    
                                        
//    const uint8_t *reportData = [data bytes];
//    uint16_t bpm = 0;
//    
//    scanf("bpm = %hd", &bpm);
//    bpm = reportData[1];
//    
//    scanf("bpm = %hd", &bpm);
//    bpm = reportData[2];
//
//    
//    if ((reportData[0] & 0x01) == 0)
//    {
//        /* uint8 bpm */
//        bpm = reportData[0];
//        
//        scanf("bpm = %hd", &bpm);
//        bpm = reportData[1];
//        
//    }
//    else
//    {
//        /* uint16 bpm */
////        bpm = CFSwapInt16LittleToHost(*(uint16_t *
//        
//    }
    
//    :&value lenght:sizeof(value)];
    
    
    
//    NSLog(@"Error is = %@",error);
//    
//    if (CBCharacteristicPropertyRead) {
//        NSLog(@"Property can be read");
//    }
//    
//    NSLog(@"Characteristic value is = %@",characteristic.value);
//    
//    NSString *value1 = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
//    
//    NSLog(@"Value is = %@",value1);
//    
//    int keyData = 0;
//    [characteristic.value getBytes:&keyData length:2];
//    
//    NSLog(@"Characteristic Value Length is = %d",[characteristic.value length]);
//    
//    NSLog(@"KeyData is = %d",keyData);
    
    
//  NSData *data = characteristic.value;
//    NSLog(@"Hexa Values are %x",characteristic.value);
    
    
//    [peripheral readValueForCharacteristic:characteristic];
    
    const char *bytes = [characteristic.value bytes];
    
    NSLog(@"Characteristic UUID is = %@",characteristic.UUID);
    NSLog(@"Characteristic Description is = %@",[characteristic.value description]);
    
    ///// For testing...
    
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"read value is" message:[characteristic.value description] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//    
//    [alert show];
    
    
//    NSLog(@"Bytes are = %d",[bytes count]);

    
    NSString *str = [NSString stringWithUTF8String:bytes];
    
    NSLog(@"Characteristic: %@ -> with value: %@", characteristic.UUID, str);

    NSLog(@"Hexa Values for 0 %hhd",bytes[0]);

    DeviceData *obj = [[DeviceData alloc]init];
    obj.hour = [NSString stringWithFormat:@"%hhd",bytes[0]];
    obj.day = [NSString stringWithFormat:@"%hhd",bytes[1]];
    obj.month = [NSString stringWithFormat:@"%hhd",bytes[2]];
    obj.year = [NSString stringWithFormat:@"%hhd",bytes[3]];
    obj.hourSteps = [NSString stringWithFormat:@"%hhd",bytes[4]];
    obj.hourDistance = [NSString stringWithFormat:@"%hhd",bytes[5]];
    obj.hourCalories = [NSString stringWithFormat:@"%hhd",bytes[6]];
    obj.daySteps = [NSString stringWithFormat:@"%hhd",bytes[7]];
    obj.dayDistance = [NSString stringWithFormat:@"%hhd",bytes[9]];
    obj.dayCalories = [NSString stringWithFormat:@"%hhd",bytes[11]];
    
    NSLog(@"%@",[obj description]);
    
    [discoveryDelegate currentDeviceData:obj];

    NSLog(@"Values for BCC %@",[NSString stringWithFormat:@"%hhd",bytes[0]]);
    NSLog(@"Values for Minute %@",[NSString stringWithFormat:@"%hhd",bytes[1]]);
    NSLog(@"Values for Hour %@",[NSString stringWithFormat:@"%hhd",bytes[2]]);
    NSLog(@"Values for Day %@",[NSString stringWithFormat:@"%hhd",bytes[3]]);
    NSLog(@"Values for Month %@",[NSString stringWithFormat:@"%hhd",bytes[4]]);
    NSLog(@"Values for Year %@",[NSString stringWithFormat:@"%hhd",bytes[5]]);
    NSLog(@"Values for Flag %@",[NSString stringWithFormat:@"%hhd",bytes[6]]);
    NSLog(@"Values for Steps %@",[NSString stringWithFormat:@"%hhd",bytes[7]]);
    NSLog(@"Values for Distance %@",[NSString stringWithFormat:@"%hhd",bytes[9]]);
    NSLog(@"Values for Calories %@",[NSString stringWithFormat:@"%hhd",bytes[11]]);
    
//    NSLog(@"Values for 10 %@",[NSString stringWithFormat:@"%hhd",bytes[10]]);
//    NSLog(@"Values for 11 %@",[NSString stringWithFormat:@"%hhd",bytes[11]]);
//    NSLog(@"Values for 12 %@",[NSString stringWithFormat:@"%hhd",bytes[12]]);
//    NSLog(@"Values for 13 %@",[NSString stringWithFormat:@"%hhd",bytes[13]]);
//    NSLog(@"Values for 14 %@",[NSString stringWithFormat:@"%hhd",bytes[14]]);
//    NSLog(@"Values for 15 %@",[NSString stringWithFormat:@"%hhd",bytes[15]]);

//    if([characteristic.value length] == 19){
    
    
//        DeviceData *obj = [[DeviceData alloc]init];
//        obj.hour = [NSString stringWithFormat:@"%hhd",bytes[0]];
//        obj.day = [NSString stringWithFormat:@"%hhd",bytes[1]];
//        obj.month = [NSString stringWithFormat:@"%hhd",bytes[2]];
//        obj.year = [NSString stringWithFormat:@"%hhd",bytes[3]];
//        obj.hourSteps = [NSString stringWithFormat:@"%hhd",bytes[4]];
//        obj.hourDistance = [NSString stringWithFormat:@"%hhd",bytes[6]];
//        obj.hourCalories = [NSString stringWithFormat:@"%hhd",bytes[8]];
//        obj.daySteps = [NSString stringWithFormat:@"%hhd",bytes[10]];
//        obj.dayDistance = [NSString stringWithFormat:@"%hhd",bytes[13]];
//        obj.dayCalories = [NSString stringWithFormat:@"%hhd",bytes[16]];
    
    
//
//        NSLog(@"%@",[obj description]);
//        
//        [discoveryDelegate currentDeviceData:obj];
//    }

    
    if (error)
    {
        NSLog(@"Error discovering characteristics: %@", [error localizedDescription]);
        return;
    }
    if (currentRequest == VIDONN_characteristic_pedometer_measurement_UUID) {
        
        const char *bytes = [characteristic.value bytes];
        if([characteristic.value length] == 19){
        
            DeviceData *obj = [[DeviceData alloc]init];
            obj.hour = [NSString stringWithFormat:@"%hhd",bytes[0]];
            obj.day = [NSString stringWithFormat:@"%hhd",bytes[1]];
            obj.month = [NSString stringWithFormat:@"%hhd",bytes[2]];
            obj.year = [NSString stringWithFormat:@"%hhd",bytes[3]];
            obj.hourSteps = [NSString stringWithFormat:@"%hhd",bytes[4]];
            obj.hourDistance = [NSString stringWithFormat:@"%hhd",bytes[6]];
            obj.hourCalories = [NSString stringWithFormat:@"%hhd",bytes[8]];
            obj.daySteps = [NSString stringWithFormat:@"%hhd",bytes[10]];
            obj.dayDistance = [NSString stringWithFormat:@"%hhd",bytes[13]];
            obj.dayCalories = [NSString stringWithFormat:@"%hhd",bytes[16]];
            NSLog(@"%@",[obj description]);
            
            
            
            [discoveryDelegate currentDeviceData:obj];
            
        }
//        NSMutableString *result = [NSMutableString string];
        
//        for (int i = 0; i < [characteristic.value length]; i++)
//        {
//            NSLog(@"%hhd",bytes[i]);
//            [result appendFormat:@"%hhd", bytes[i]];
//        }
//        NSLog(@"%i",result.length);
        
    }else{
        
        
//        [discoveryDelegate didUpdateValueForCharacteristic:[NSString stringWithFormat:@"%@",characteristic.value]];
    
    
    }
    return;
    
    UInt16 characteristicUUID = [self CBUUIDToInt:characteristic.UUID];
    switch (characteristicUUID) {
        case VIDONN_battery_level_UUID://电量:
        {
            char batlevel;
            [characteristic.value getBytes:&batlevel length:1];
            int bl = (int)batlevel;
            printf("batlevel  ---  %d",bl);
            NSString *value = [NSString stringWithFormat:@"%d",bl];
//            [discoveryDelegate didUpdateValueForCharacteristic:value];
            break;
        }
        case VIDONN_characteristic_device_name_UUID://名称
        {
            NSString *stringFromData = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
            NSString *value = [NSString stringWithFormat:@"%@",stringFromData];
//            [discoveryDelegate didUpdateValueForCharacteristic:value];
            break;
        }
        case VIDONN_characteristic_pedometer_configuration_UUID://SG{
        {
            NSLog(@"aaaaa ----- %@",characteristic.value);
            CGFloat result  = NAN;
            int16_t value   = 0;
            if (characteristic) {
                [[characteristic value] getBytes:&value length:sizeof (value)];
                result = (CGFloat)value / 10.0f;
            }
            NSLog(@"result ::: %f",result);
        }
            break;
        case VIDONN_characteristic_temperature_measurement_UUID://温度
            break;
        case VIDONN_characteristic_alarmclock_contrl_point_UUID://闹钟
            break;
        case VIDONN_characteristic_led_control_point_UUID://色彩
            break;
        case VIDONN_characteristic_Time://时间
        {
            NSLog(@"aaaaa ----- %@",characteristic.value);
            break;
        }
        default:
            break;
    }
    
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (error)
    {
        NSLog(@"Error changing notification state: %@", error.localizedDescription);
    }
}


- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    NSLog(@"Did write characteristic value : %@ with ID %@", characteristic.value, characteristic.UUID);
    NSLog(@"With error: %@", [error localizedDescription]);
    [discoveryDelegate FourDidgitCodeAuth];
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error {
    NSLog(@"Did write characteristic value : %@ with ID %@", descriptor.value, descriptor.UUID);
    NSLog(@"With error: %@", [error localizedDescription]);

}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
        NSLog(@"Characteristic UUID is = %@",characteristic.UUID);
        NSLog(@"Descriptor is = %@",characteristic.description);
    for (CBDescriptor *descriptor in characteristic.descriptors) {
        [peripheral readValueForDescriptor:descriptor];
        NSLog(@"descriptor description is = %@",descriptor.description);
        NSLog(@"descriptor value is = %@",descriptor.value);
        NSLog(@"descriptor UUID is = %@",descriptor.UUID);
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error{
    NSLog(@"Value is = %@",descriptor.value);
    NSLog(@"Descriptor Characteristic is = %@",descriptor.characteristic.UUID);    
}

- (void)cleanup
{
//    if (!self.activePeripheral.isConnected) {
//        return;
//    }
    
    [self.CM cancelPeripheralConnection:self.activePeripheral];
    self.CM = nil;
}

- (BOOL) isconnectPeripheral
{
//    return self.activePeripheral.isConnected;
}

///////////////////////////////////////////////////////////////////////////////////////

-(UInt16) swap:(UInt16)s {
    
    UInt16 temp = s << 8;
    temp |= (s >> 8);
    return temp;

}

-(CBService *) findServiceFromUUID:(CBUUID *)UUID p:(CBPeripheral *)p {
    
    for(int i = 0; i < p.services.count; i++) {
        CBService *s = [p.services objectAtIndex:i];
        if ([self compareCBUUID:s.UUID UUID2:UUID]) return s;
    }
    return nil; //Service not found on this peripheral

}

-(CBCharacteristic *) findCharacteristicFromUUID:(CBUUID *)UUID service:(CBService*)service {
    
    for(int i=0; i < service.characteristics.count; i++) {
        CBCharacteristic *c = [service.characteristics objectAtIndex:i];
        if ([self compareCBUUID:c.UUID UUID2:UUID]) return c;
    }
    return nil; //Characteristic not found on this service

}

-(const char *) UUIDToString:(CFUUIDRef)UUID {
    
    if (!UUID) return "NULL";
    CFStringRef s = CFUUIDCreateString(NULL, UUID);
    return CFStringGetCStringPtr(s, 0);
    

}

-(const char *) CBUUIDToString:(CBUUID *) UUID {
    
    return [[UUID.data description] cStringUsingEncoding:NSStringEncodingConversionAllowLossy];

}

-(int) compareCBUUID:(CBUUID *) UUID1 UUID2:(CBUUID *)UUID2 {
    
    char b1[16];
    char b2[16];
    [UUID1.data getBytes:b1];
    [UUID2.data getBytes:b2];
    if (memcmp(b1, b2, UUID1.data.length) == 0)return 1;
    else return 0;

}

-(int) compareCBUUIDToInt:(CBUUID *)UUID1 UUID2:(UInt16)UUID2 {
    
    char b1[16];
    [UUID1.data getBytes:b1];
    UInt16 b2 = [self swap:UUID2];
    if (memcmp(b1, (char *)&b2, 2) == 0) return 1;
    else return 0;

}

-(UInt16) CBUUIDToInt:(CBUUID *) UUID {
    
    char b1[16];
    [UUID.data getBytes:b1];
    return ((b1[0] << 8) | b1[1]);

}

- (int) UUIDSAreEqual:(CFUUIDRef)u1 u2:(CFUUIDRef)u2 {
    
    CFUUIDBytes b1 = CFUUIDGetUUIDBytes(u1);
    CFUUIDBytes b2 = CFUUIDGetUUIDBytes(u2);
    if (memcmp(&b1, &b2, 16) == 0) {
        return 1;
    }
    else return 0;

}

///////////////////////////////////////////////////////////////////////////////////////


@end
