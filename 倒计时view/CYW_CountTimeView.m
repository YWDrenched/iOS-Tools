//
//  CYW_CountTimeView.m
//  testForCharging
//
//  Created by 陈友文 on 2017/12/13.
//  Copyright © 2017年 陈友文. All rights reserved.
//

#import "CYW_CountTimeView.h"

@interface CYW_CountTimeView (){
    dispatch_source_t _timer;
}

@property (nonatomic,strong)UILabel *hoursLabel;

@property (nonatomic,strong)UILabel *minuteLabel;

@property (nonatomic,strong)UILabel *secondLabel;

@property (nonatomic,strong)NSLayoutConstraint *layoutConstraint;



@end

@implementation CYW_CountTimeView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
        
    }
    return self;
}
-(void)setupUI{
    self.secondLabel = [[UILabel alloc] init];
    self.secondLabel.text = @"秒";
    [self addSubview:self.secondLabel];
    
    self.minuteLabel = [[UILabel alloc] init];
    self.minuteLabel.text = @"分";
    [self addSubview:self.minuteLabel];
    
    self.hoursLabel = [[UILabel alloc] init];
    self.hoursLabel.text = @"时";
    [self addSubview:self.hoursLabel];
    
    for (UIView *v in self.subviews) {
        v.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.minuteLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.minuteLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:30]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.hoursLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.minuteLabel attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-30]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.hoursLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:30]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.secondLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.minuteLabel attribute:NSLayoutAttributeRight multiplier:1.0 constant:30]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.secondLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:30]];
}

-(void)setCountTime:(NSTimeInterval)countTime{
    _countTime = countTime;
    if (_timer == nil) {
        __weak typeof(self)weakSelf = self;
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));//获取队列
        dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(_timer, ^{//每秒执行
            __strong typeof(weakSelf)strongSelf = weakSelf;
            if (self.countTime <= 0) {
                //取消定时器
                dispatch_source_cancel(_timer);
                _timer = nil;
                if ([strongSelf.delegate respondsToSelector:@selector(CYW_CountTimeViewTimeUseup:)]) {
                    [strongSelf.delegate CYW_CountTimeViewTimeUseup:strongSelf];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    strongSelf.secondLabel.hidden = YES;
                    strongSelf.minuteLabel.hidden = YES;
                    strongSelf.hoursLabel.hidden = YES;
                });
            }else{
                int hours = (int)(self.countTime/3600);
                int minute = (int)(self.countTime -hours*3600)/60;
                int second = self.countTime-hours*3600-minute*60;
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (hours<10) {
                        strongSelf.hoursLabel.text = [NSString stringWithFormat:@"0%d时",hours];
                    }else{
                        strongSelf.hoursLabel.text = [NSString stringWithFormat:@"%d时",hours];
                    }
                    if (minute<10) {
                        strongSelf.minuteLabel.text = [NSString stringWithFormat:@"0%d分",minute];
                    }else{
                        strongSelf.minuteLabel.text = [NSString stringWithFormat:@"%d分",minute];
                    }
                    if (second<10) {
                        strongSelf.secondLabel.text = [NSString stringWithFormat:@"0%d秒",second];
                    }else{
                        strongSelf.secondLabel.text = [NSString stringWithFormat:@"%d秒",second];
                    }
                });
                strongSelf.countTime--;
            }
        });
        dispatch_resume(_timer);
    }
}




@end
