
#import "CustomDatePicker.h"

#define JTSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define JTSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define CUSTOMDATEPICKER_HEIGHT 300

#define BUTTON_HEIGHT 30

@interface CustomDatePicker () {

    //确定
    UIButton *_sureButton;
    //取消
    UIButton *_cancelButton;
    //时间选择器
    UIDatePicker *_datePicker;
    
}

//选择的时间
@property (nonatomic, copy)NSString *selectDateStr;
//传入的时间格式
@property (nonatomic, copy)NSString *dateType;

@end

@implementation CustomDatePicker

- (instancetype)init {
    
    if (self = [super init])
    {
        self.frame = CGRectMake(0, JTSCREEN_HEIGHT, JTSCREEN_WIDTH, CUSTOMDATEPICKER_HEIGHT);
        self.hidden = YES;
        
        //创建需要视图
        [self _createView];
    }
    return self;
}

- (void)_createView {

    //确定
    _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _sureButton.frame = CGRectMake(JTSCREEN_WIDTH-50, 0, 50, BUTTON_HEIGHT);
    _sureButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    _sureButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_sureButton setTitle:@"确认" forState:UIControlStateNormal];
    [_sureButton setTitleColor:RGB(69, 140, 210) forState:UIControlStateNormal];
    [_sureButton addTarget:self action:@selector(sureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_sureButton];
    
    //取消
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelButton.frame = CGRectMake(0, 0, 50, BUTTON_HEIGHT);
    _cancelButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    _cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cancelButton];
    
    //
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, BUTTON_HEIGHT, JTSCREEN_WIDTH, CUSTOMDATEPICKER_HEIGHT-BUTTON_HEIGHT)];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    [_datePicker addTarget:self action:@selector(datePickerChange:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_datePicker];
}

#pragma mark -- 确定、取消按钮点击事件
//确定
- (void)sureButtonAction:(UIButton *)button {

    NSString *dateStr;
    if (self.selectDateStr.length == 0)
    {
        NSDateFormatter *dateFormatter = [self dateFormatter:self.dateType];
        
        if (self.customDate != nil)
        {
            dateStr = [dateFormatter stringFromDate:self.customDate];
        }
        else
        {
            dateStr = [dateFormatter stringFromDate:[NSDate date]];
        }
    }
    else
    {
        dateStr = self.selectDateStr;
    }
    
    [self returnDateStrWithDateStr:dateStr];
    
    /**
     *  确定之后隐藏选择器
     */
    self.hiddenCustomPicker = YES;
}

//取消
- (void)cancelButtonAction:(UIButton *)button {
    self.hiddenCustomPicker = YES;
}

#pragma mark -- 时间选择器
- (void)datePickerChange:(UIDatePicker *)datePicker {
    
    NSDateFormatter *dateFormatter = [self dateFormatter:self.dateType];
    
    self.selectDateStr = [dateFormatter stringFromDate:datePicker.date];
    self.customDate = datePicker.date;
}

#pragma mark -- 设置时间选择器的类型
- (void)SetDatePickerMode:(UIDatePickerMode)customDatePickerMode withDateFormatterStr:(NSString *)dateFormatterStr {

    _datePicker.datePickerMode = customDatePickerMode;
    
    self.dateType = dateFormatterStr;
}

#pragma mark -- 显示、隐藏选择器


- (void)setHiddenCustomPicker:(BOOL)hiddenCustomPicker{
    _hiddenCustomPicker = hiddenCustomPicker;
    
    __weak typeof(self) weakSelf = self;
    if (_hiddenCustomPicker)
    {
        
        [UIView animateWithDuration:0.3 animations:^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            
            strongSelf.transform = CGAffineTransformIdentity;
        }completion:^(BOOL finished) {
            self.hidden = YES;
            
            [self alreadyHiddtnDatePicker];
        }];
    }
    else
    {
        self.hidden = NO;
        
        [UIView animateWithDuration:0.3 animations:^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            
            strongSelf.transform = CGAffineTransformMakeTranslation(0, -CUSTOMDATEPICKER_HEIGHT);
        }];
        
        self.selectDateStr = @"";
    }
}

#pragma mark -- dateFormatter 
- (NSDateFormatter *)dateFormatter:(NSString *)dateFormatterStr {

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if (dateFormatterStr.length == 0)
    {
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    else
    {
        [dateFormatter setDateFormat:self.dateType];
    }

    return dateFormatter;
}

#pragma mark -- CustomDatePicker delegate
//返回日期
- (void)returnDateStrWithDateStr:(NSString *)dateStr {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(returnDateStrWithDateStr:)])
    {
        [self.delegate returnDateStrWithDateStr:dateStr];
    }
}

//视图已经隐藏
- (void)alreadyHiddtnDatePicker {

    if (self.delegate && [self.delegate respondsToSelector:@selector(alreadyHiddtnDatePicker)]) {
        [self.delegate alreadyHiddtnDatePicker];
    }

}

#pragma mark --设置选择器最大和最小时间
-(void)setCustomMaxDate:(NSDate *)customMaxDate {
    _customMaxDate = customMaxDate;
    _datePicker.maximumDate = _customMaxDate;
}

-(void)setCustomMinDate:(NSDate *)customMinDate {
    _customMinDate = customMinDate;
    
    _datePicker.minimumDate = _customMinDate;
}



@end

