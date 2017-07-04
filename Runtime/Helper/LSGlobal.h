//
//  LSGlobal.h
//  Runtime
//
//  Created by jinzhong xu on 2017/7/4.
//  Copyright © 2017年 jinzhong xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSGlobal : NSObject<NSCoding>

+ (instancetype)share;

+ (void) writeGlobeVariablesToFile;

+(LSGlobal *) readGlobeVariablesFromFile;

@end
