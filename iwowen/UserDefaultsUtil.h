//
//  UserDefaultsUtil.h
//  meU
//
//  Created by Ali Asghar on 9/12/13.
//  Copyright (c) 2013 MacrosoftInc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultsUtil : NSObject

+(void)setObject:(NSObject*)obj forKey:(NSString*)aKey;
+(void)removeObject:(NSObject*)obj forKey:(NSString*)aKey;
+(NSObject*)getObjectForKey:(NSString*)aKey;
+(NSData*)getDataForKey:(NSString*)aKey;
@end
