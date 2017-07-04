//
//  LSGlobal.m
//  Runtime
//
//  Created by jinzhong xu on 2017/7/4.
//  Copyright © 2017年 jinzhong xu. All rights reserved.
//

#import "LSGlobal.h"

@implementation LSGlobal

static LSGlobal *_instance = nil;

+ (instancetype)share
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[LSGlobal alloc] init];
    });
    
    return _instance;
}

+ (void) writeGlobeVariablesToFile
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *archivedDataFile = kGlobeVariablesArchiveFileName;
        NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:_instance];
        if(archivedData){
            [archivedData writeToFile:archivedDataFile atomically:NO];
        }
    });
}

+(LSGlobal *) readGlobeVariablesFromFile
{
    LSGlobal * object = nil;
    NSString *archivedDataFile = kGlobeVariablesArchiveFileName;
    if(![[NSFileManager defaultManager] fileExistsAtPath:archivedDataFile]) return object;
    NSData *archivedData = [[NSData alloc] initWithContentsOfFile:archivedDataFile];
    if(archivedData) {
        object = (LSGlobal *)[NSKeyedUnarchiver unarchiveObjectWithData:archivedData];
    }
    return object;
}


- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if(self)
    {
        //不光归档自身的属性，还要循环把所有父类的属性也找出来
        Class selfClass = self.class;
        while (selfClass &&selfClass != [NSObject class]) {
            unsigned int outCount = 0;
            Ivar *ivars = class_copyIvarList(selfClass, &outCount);
            for (int i = 0; i < outCount; i++) {
                Ivar ivar = ivars[i];
                NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
                id value = [decoder decodeObjectForKey:key];
                [self setValue:value forKey:key];
            }
            free(ivars);
            selfClass = [selfClass superclass];
        }
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    Class selfClass = self.class;
    while (selfClass &&selfClass != [NSObject class]) {
        unsigned int outCount = 0;
        Ivar *ivars = class_copyIvarList([self class], &outCount);
        for (int i = 0; i < outCount; i++) {
            Ivar ivar = ivars[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            id value = [self valueForKeyPath:key];
            [encoder encodeObject:value forKey:key];
        }
        free(ivars);
        selfClass = [selfClass superclass];
    }
}

@end
