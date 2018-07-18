//
//  CYW_AlertView.h
//  01-封装弹窗视图
//
//  Created by 陈友文 on 2018/7/16.
//  Copyright © 2018年 陈友文. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DetailClickCompletion)(void);

typedef void(^ComfirClickCompletion)(void);

typedef NS_ENUM(NSInteger, AlertViewType) {
    AlertViewTypeDefault,
    AlertViewTypeDetail,
};

@interface CYW_AlertView : UIView

@property (nonatomic,copy)NSString *titleStr;

@property (nonatomic,copy)NSString *msgStr;

@property (nonatomic,strong)UIColor *backgroundColor;

@property (nonatomic,strong)UIColor *buttonColor;


//@property (nonatomic,assign)BOOL animation;

@property (nonatomic,copy)DetailClickCompletion detailCompletion;

@property (nonatomic,copy)ComfirClickCompletion comfirmCompletion;


+(instancetype)showAddView:(UIView *)view;

+(instancetype)showAddView:(UIView *)view withType:(AlertViewType)type;

//+(instancetype)showAddView:(UIView *)view withType:(AlertViewType)type withDetailBtnClick:(complection)completion;




@end
