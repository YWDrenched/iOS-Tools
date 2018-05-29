//
//  CYW_CountTimeView.h
//  testForCharging
//
//  Created by 陈友文 on 2017/12/13.
//  Copyright © 2017年 陈友文. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CYW_CountTimeView;

@protocol CYW_CountTimeViewDelegate <NSObject>

@optional

-(void)CYW_CountTimeViewTimeUseup:(CYW_CountTimeView *)timeView;

@end

@interface CYW_CountTimeView : UIView


/**
 倒计时总时长
 */
@property(nonatomic,assign)CGFloat countTime;

@property (nonatomic,weak)id<CYW_CountTimeViewDelegate> delegate;

@end
