//
//  runtimeView.m
//  Runtime
//
//  Created by jinzhong xu on 2017/7/4.
//  Copyright © 2017年 jinzhong xu. All rights reserved.
//

#import "runtimeView.h"

@interface runtimeView()

@property(strong, nonatomic) UITextField *textField;
@property(strong, nonatomic) UIButton  *buttonDone1;
@property(strong, nonatomic) UIButton  *buttonDone2;

@end

@implementation runtimeView


-(instancetype)initFromSuperView:(UIView *)superView
{
    if (self = [super init]) {
        [superView addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.offset(300);
            make.width.equalTo(superView);
            make.centerY.equalTo(superView);
        }];
        
        self.backgroundColor = [UIColor blueColor];
        self.buttonDone1.backgroundColor = [UIColor greenColor];
        self.buttonDone2.backgroundColor = [UIColor greenColor];
    }
    
    return self;
}

-(UIButton *)buttonDone1
{
    if (!_buttonDone1) {
        _buttonDone1 = [[UIButton alloc] init];
        _buttonDone1.layer.cornerRadius = 5.0f;
        _buttonDone1.layer.masksToBounds = YES;
        [_buttonDone1 setTitle:@"Done1" forState:UIControlStateNormal];
        [[_buttonDone1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [self.btn1Command execute:@1];
        }];
        [self addSubview:_buttonDone1];
        
        [_buttonDone1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_centerX).offset(-40);
            make.width.offset(80);
            make.height.offset(50);
            make.centerY.equalTo(self);
        }];
    }
    
    return _buttonDone1;
}

-(UIButton *)buttonDone2
{
    if (!_buttonDone2) {
        _buttonDone2 = [[UIButton alloc] init];
        _buttonDone2.layer.cornerRadius = 5.0f;
        _buttonDone2.layer.masksToBounds = YES;
        [_buttonDone2 setTitle:@"Done2" forState:UIControlStateNormal];
        [[_buttonDone2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [self.btn2Command execute:@2];
        }];
        [self addSubview:_buttonDone2];
        
        [_buttonDone2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_centerX).offset(40);
            make.width.offset(80);
            make.height.offset(50);
            make.centerY.equalTo(self);
        }];
    }
    
    return _buttonDone2;
}

-(RACCommand *)btn1Command
{
    if (!_btn1Command) {
        _btn1Command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    
    return _btn1Command;
}

-(RACCommand *)btn2Command
{
    if (!_btn2Command) {
        _btn2Command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    
    return _btn2Command;
}

@end
