//
//  UserDefaultsUtil.m
//  meU
//
//  Created by Ali Asghar on 9/12/13.
//  Copyright (c) 2013 MacrosoftInc. All rights reserved.
//

#import "UserDefaultsUtil.h"

@implementation UserDefaultsUtil

+(void)setObject:(NSObject*)obj forKey:(NSString*)aKey{
    
    NSUserDefaults *datastore = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:obj];
    @try {
        [datastore setObject:encodedObject forKey:aKey];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception :::: %@",[exception debugDescription]);
        @throw exception;
    }
}

+(void)removeObject:(NSObject*)obj forKey:(NSString*)aKey{
    
}

+(NSData*)getDataForKey:(NSString*)aKey{
    
    NSUserDefaults *dataStore = [NSUserDefaults standardUserDefaults];
    return [dataStore objectForKey:aKey];

}


+(NSObject*)getObjectForKey:(NSString*)aKey{
    NSUserDefaults *dataStore = [NSUserDefaults standardUserDefaults];
    NSData *decodedObject = [dataStore objectForKey:aKey];
    if(decodedObject != nil){
        return [NSKeyedUnarchiver unarchiveObjectWithData:decodedObject];
    }
    return nil;
}
@end
