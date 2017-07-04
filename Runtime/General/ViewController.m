//
//  ViewController.m
//  Runtime
//
//  Created by jinzhong xu on 2017/7/4.
//  Copyright © 2017年 jinzhong xu. All rights reserved.
//

#import "ViewController.h"
#import "runtimeView.h"
#import "objc/runtime.h"

@interface ViewController ()

@property(strong, nonatomic) runtimeView *runView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadEvent];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(runtimeView *)runView
{
    if (!_runView) {
        _runView = [[runtimeView alloc] initFromSuperView:self.view];
        _runView.alpha = 0.8f;
    }
    
    return _runView;
}

-(void)loadEvent
{
    self.view.backgroundColor = [UIColor yellowColor];
    self.runView.backgroundColor = [UIColor grayColor];
    [_runView.btn1Command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"button1");
    }];
    
    [_runView.btn2Command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"button2");
    }];
}

#pragma mark 动态加载方法 / ResolveInstanceMethod
#if 0
// 当调用了一个未实现的方法会来到这里
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == NSSelectorFromString(@"run:")) {
        // 动态添加 run: 方法
        class_addMethod(self, @selector(run:), run, "v@:@");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

void run(id self, SEL _cmd, NSNumber *metre) {
    NSLog(@"跑了%@米",metre);
}
#endif

#pragma mark 对象归档、解档 / ObjectArchive
#if 0
- (void)tuc_initWithCoder:(NSCoder *)aDecoder {
    // 不光归档自身的属性，还要循环把所有父类的属性也找出来
    Class selfClass = self.class;
    while (selfClass &&selfClass != [NSObject class]) {
        unsigned int outCount = 0;
        Ivar *ivars = class_copyIvarList(selfClass, &outCount);
        for (int i = 0; i < outCount; i++) {
            Ivar ivar = ivars[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        free(ivars);
        selfClass = [selfClass superclass];
    }
}
- (void)tuc_encodeWithCoder:(NSCoder *)aCoder {
    Class selfClass = self.class;
    while (selfClass &&selfClass != [NSObject class]) {
        unsigned int outCount = 0;
        Ivar *ivars = class_copyIvarList([self class], &outCount);
        for (int i = 0; i < outCount; i++) {
            Ivar ivar = ivars[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            id value = [self valueForKeyPath:key];
            [aCoder encodeObject:value forKey:key];
        }
        free(ivars);
        selfClass = [selfClass superclass];
    }
}
#endif


@end
