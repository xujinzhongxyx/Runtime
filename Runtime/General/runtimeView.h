//
//  runtimeView.h
//  Runtime
//
//  Created by jinzhong xu on 2017/7/4.
//  Copyright © 2017年 jinzhong xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface runtimeView : UIView

-(instancetype)initFromSuperView:(UIView *)superView;

@property(strong, nonatomic) RACCommand *btn1Command;
@property(strong, nonatomic) RACCommand *btn2Command;

@end
