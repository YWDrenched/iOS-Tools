

#import <UIKit/UIKit.h>

@protocol CustomDatePickerDelegate <NSObject>

@required
//点击确定获取的日期
- (void)returnDateStrWithDateStr:(NSString *)dateStr;

@optional
//视图已经隐藏
- (void)alreadyHiddtnDatePicker;

@end

@interface CustomDatePicker : UIView

//设置时间选择器当前时间
@property (nonatomic, strong)NSDate *customDate;
//设置时间选择器最大时间
@property (nonatomic, strong)NSDate *customMaxDate;
//设置时间选择器最小时间
@property (nonatomic, strong)NSDate *customMinDate;

//显示、显示
@property (nonatomic, assign)BOOL hiddenCustomPicker;


@property (nonatomic, strong)id<CustomDatePickerDelegate> delegate;

////显示
//- (void)customPickerShow;
////隐藏
//- (void)customPickerHidden;

//设置DatePicker类型
- (void)SetDatePickerMode:(UIDatePickerMode)customDatePickerMode withDateFormatterStr:(NSString *)dateFormatterStr;

@end
