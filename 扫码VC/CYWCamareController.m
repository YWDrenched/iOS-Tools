//
//  CYWCamareController.m
//  OperationsAssistant
//
//  Created by 陈友文 on 2018/10/31.
//  Copyright © 2018年 陈友文. All rights reserved.
//

#import "CYWCamareController.h"
#import <AVFoundation/AVFoundation.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCAN_IMG_WIDTH 250
#define IMG_SPEED 1



@interface CYWCamareController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer *preview;

@property (nonatomic,strong)UIImageView *img;
@property (nonatomic,strong)UIImageView *scanImg;
@property (nonatomic,strong)NSTimer *timer;

@end

@implementation CYWCamareController



-(void)viewWillAppear:(BOOL)animated
{
    
    [self setupTimer];
    [self.session startRunning];
 
    
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    if (self.timer != nil) {
        [self.timer invalidate];
    }
    [self.session stopRunning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setupUI];
}


-(void)setupTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(downForImg) userInfo:nil repeats:YES];
}


-(void)downForImg{
    CGRect frame = self.img.frame;
    frame.origin.y += IMG_SPEED;
    self.img.frame = frame;
    
    if (frame.origin.y == self.scanImg.frame.origin.y + SCAN_IMG_WIDTH) {
        self.img.frame = CGRectMake(self.scanImg.frame.origin.x, self.scanImg.frame.origin.y, SCAN_IMG_WIDTH, 2);
    }
}

-(void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    
    UIImageView *scanImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scanscanBg"]];
    scanImg.center = self.view.center;
    scanImg.bounds = CGRectMake(0, 0, SCAN_IMG_WIDTH, SCAN_IMG_WIDTH);
    [self.view addSubview:scanImg];
    self.scanImg = scanImg;
    
    
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"线@2x"]];
    img.frame = CGRectMake(scanImg.frame.origin.x, scanImg.frame.origin.y + 50, SCAN_IMG_WIDTH, 2);
    [self.view addSubview:img];
    self.img = img;
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied){
        //无权限 做一个友好的提示
        //            self.view.backgroundColor = RGBA(0, 0, 0, 0.6);
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在设置中打开相机权限" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * ok =[UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            /*打开定位设置*/
            NSURL * settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication]openURL:settingsURL];
        }];
        UIAlertAction * cacel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:ok];
        [alert addAction:cacel];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        //调用相机的代码写在这里
        [self setupCamera];
        
    }
    
}



-(void)setupCamera{
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    _output.rectOfInterest = self.view.frame;//CGRectMake(0.1, 0, 0.9, 1);//
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResize;
    _preview.frame =self.view.bounds;
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
//    [self.view bringSubviewToFront:imageView];
    [_session startRunning];
}





- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    NSString *stringValue;
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }else{
        NSLog(@"获取二维码信息失败");
        return;
    }
    
    NSLog(@"%@",stringValue);
    [self.session stopRunning];
    if (self.timer != nil) {
        [self.timer invalidate];
    }
    
}

-(void)dealloc{
    
    NSLog(@"%s",__func__);
}

@end
