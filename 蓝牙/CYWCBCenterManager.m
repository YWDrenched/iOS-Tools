//
//  CYWCBCenterManager.m
//  蓝牙Manager
//
//  Created by 陈友文 on 2017/11/8.
//  Copyright © 2017年 陈友文. All rights reserved.
//

#import "CYWCBCenterManager.h"

#define TEST_MACADDRESS @"7C:EC:79:EC:7B:74"
#define TEXT_DEVICECODE @"C1000267"



@interface CYWCBCenterManager ()<CBCentralManagerDelegate,CBPeripheralDelegate>{
    
    //第一次请求的种子数据
    NSString *oneNS;
    
    NSString * ons;

    //mac地址
    NSString *mac;
    //四个种子HBYTE
    NSString *fiv;
    //校验
    NSString *six;
    
    
    NSData *macD1;
    NSData *macD2;
    NSData *macD3;
    NSData *macD4;
    NSData *macD5;
    NSData *macD6;
    
    NSData *stimeD7;
    
    NSMutableData* data;
    
    NSMutableArray *ay;
    //秘钥数组
    NSMutableArray  *muarray;
    
    NSData *zData1;
    NSData *zData2;
    NSData *zData3;
    NSData *zData4;
    
    NSString *str;
    
    NSData *data0;
    NSData *data1;
    NSData *data2;
    NSData *data3;
    NSData *data4;
    NSData *data5;
    NSData *data6;
    NSData *data7;
    NSData *data8;
    NSData *data9;
    NSData *data10;
    NSData *data11;
    NSData *data12;
    NSData *data13;
    NSData *data14;
}

// 当前用到的特征
@property (nonatomic, strong) CBCharacteristic *currentCharacteristic;

@end

@implementation CYWCBCenterManager

-(instancetype)init{
    if (self = [super init]) {
        self.mgr = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
        muarray =[[NSMutableArray alloc]init];
    }
    return self;
}

//+(instancetype)shareManager{
//    
//    static CYWCBCenterManager *instance = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        instance = [[self alloc] init];
//    });
//    return instance;
//}

-(void)centralManagerDidUpdateState:(CBCentralManager *)central{
    if (central.state == CBManagerStatePoweredOn) {
        [self scanDevice];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:connectDeviceFailNotification object:nil];
        NSLog(@"蓝牙不可用");
    }
}

-(void)scanDevice{
    [self.mgr scanForPeripheralsWithServices:nil options:nil];
}

-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI{
    if (![self.peripheralArr containsObject:peripheral]) {
        [self.peripheralArr addObject:peripheral];
    }
    if ([advertisementData[@"kCBAdvDataLocalName"] isEqualToString:self.deviceNum] ) {
        [self.mgr connectPeripheral:peripheral options:nil];
        
    
        
    }
    
//    NSLog(@"%@",advertisementData);
}

//连接到外设
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
//    NSLog(@"连接到外设 ===  %@",peripheral);
    [[NSNotificationCenter defaultCenter] postNotificationName:connectDeviceSuccessNotification object:self];
    
    self.currentPeripheral = peripheral;
    self.currentPeripheral.delegate = self;
    [self.currentPeripheral discoverServices:nil];
}

-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    [[NSNotificationCenter defaultCenter] postNotificationName:connectDeviceFailNotification object:nil];
}


- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error{
//     [[NSNotificationCenter defaultCenter] postNotificationName:connectDeviceFailNotification object:nil];
}





//  外设查找到服务
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    
    for (CBService *service in peripheral.services) {
        //  查找特征
        [self.currentPeripheral discoverCharacteristics:nil forService:service];
        
    }
}


- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    if (error)
    {
        return;
    }
    
    for (CBCharacteristic *characteristic in service.characteristics) {
        
        // 当前设备需要监听的characteristic的UUID
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FFF1"]])
        {
            _currentCharacteristic = characteristic;
        }
        [peripheral setNotifyValue:YES forCharacteristic:characteristic];
        
    }
}


-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    
    NSLog(@"characteristic.value == %@",characteristic.value);
    oneNS = [NSString stringWithFormat:@"%@",[self convertDataToHexStr:characteristic.value]];
    ons = oneNS;
    NSString *sucNS = [oneNS substringWithRange:NSMakeRange(16, 2)];
    if ([sucNS isEqualToString:@"67"] && ons.length > 27) {
        //成功
        [self one];
        
    }else if (ons.length < 27){
        
        NSLog(@"ons..... %@",ons);
        
    }else if (ons.length > 35){
        
        NSLog(@"ons..... %@",ons);
        
        
    }else if([sucNS isEqualToString:@"7f"]){
        
        
    }
        

}


-(void) send{
    
    if (self.macAddress != nil) {
        
        NSString *macs = [self rangeOfMacAddress:self.macAddress];
        
        //    NSLog(@"macs ==== %@",macs);
        
        //发送指令
        //        Byte a1 = 0xB;
        Byte a1 = 0xC;
        
        //MAC地址
        NSString *mac1 = [NSString stringWithFormat:@"0x%@",[macs substringToIndex:2]];
        [self dataForHexString:mac1];
        macD1 = data;
        Byte *macByte1 = (Byte*)[macD1 bytes];
        Byte m1 = (Byte)macByte1[1];
        
        NSString *mac2 = [NSString stringWithFormat:@"0x%@",[macs substringWithRange:NSMakeRange(2, 2)]];
        [self dataForHexString:mac2];
        macD2 = data;
        Byte *macByte2 = (Byte*)[macD2 bytes];
        Byte m2 = (Byte)macByte2[1];
        
        NSString *mac3 = [NSString stringWithFormat:@"0x%@",[macs substringWithRange:NSMakeRange(4, 2)]];
        [self dataForHexString:mac3];
        macD3 = data;
        Byte *macByte3 = (Byte*)[macD3 bytes];
        Byte m3 = (Byte)macByte3[1];
        
        NSString *mac4 = [NSString stringWithFormat:@"0x%@",[macs substringWithRange:NSMakeRange(6, 2)]];
        [self dataForHexString:mac4];
        macD4 = data;
        Byte *macByte4 = (Byte*)[macD4 bytes];
        Byte m4 = (Byte)macByte4[1];
        
        NSString *mac5 = [NSString stringWithFormat:@"0x%@",[macs substringWithRange:NSMakeRange(8, 2)]];
        [self dataForHexString:mac5];
        macD5 = data;
        Byte *macByte5 = (Byte*)[macD5 bytes];
        Byte m5 = (Byte)macByte5[1];
        
        NSString *mac6 = [NSString stringWithFormat:@"0x%@",[macs substringWithRange:NSMakeRange(10, 2)]];
        [self dataForHexString:mac6];
        macD6 = data;
        Byte *macByte6 = (Byte*)[macD6 bytes];
        Byte m6 = (Byte)macByte6[1];
        
        Byte a7 = 0xC1;
        Byte a8 = 0x27;
        Byte a9 = 0x01;
        
        //        添加的时间字节
        NSString *stime = [NSString stringWithFormat:@"%.0f",self.selectTime];
        NSLog(@"添加的时间字节 == %@",stime);
        
        if (stime.length > 1) {
            stime = [NSString stringWithFormat:@"0x%@",stime];
        }else{
            stime = [NSString stringWithFormat:@"0x0%@",stime];
        }
        
        [self dataForHexString:stime];
        stimeD7 = data;
        Byte *stimeByte = (Byte *)[stimeD7 bytes];
        Byte a10 = (Byte)stimeByte[1];
        
        
        //效验
        Byte yy = (Byte)((a1+m1 + m2 + m3 + m4 + m5 + m6 + a7 + a8 + a9 + a10)&0xFF);
        Byte xx = ~yy;
        
        Byte a11 = xx;
        
        Byte byte[] = {a1,m1,m2,m3,m4,m5,m6,a7,a8,a9,a10,a11};
        NSData *datas = [NSData dataWithBytes:&byte length:sizeof(byte)];
        NSLog(@"%@",datas);
        [self.currentPeripheral writeValue:datas forCharacteristic:self.currentCharacteristic type:CBCharacteristicWriteWithResponse];
        
    }else{
//        [SVProgressHUD showErrorWithStatus:@"获取设备MAC地址失败"];
//        
//        [SVProgressHUD dismissWithDelay:1.5];
    }
}



-(void)_openTime{
    [self realiZament:@"C1" instructions:@"02"];
}
-(void)realiZament:(NSString *)realiZament instructions:(NSString *)instructions{
    
    //设备类型标识符
    NSString *Zament = realiZament;
    
    //开锁指令标识符
    NSString *intions = instructions;
    
    [self messByte:fiv];
    ay = muarray;
    
    
    if (muarray.count == 0) {
        
        NSLog(@"蓝牙数据获取失败,请重新获取蓝牙数据!");
        
//        [SVProgressHUD showErrorWithStatus:@"蓝牙数据获取失败,请重新获取蓝牙数据!"];
        
//        [SVProgressHUD dismissWithDelay:1.5];
        //        [_view removeFromSuperview];
        //        _stopButton.hidden = YES;
        //        _removeBindingButton.hidden = NO;
        
    }else{
        //报文
        NSString *bw = @"10";
        NSString *bws = [NSString stringWithFormat:@"0x%@",bw];
        [self dataForHexString:bws];
        data0 = data;
        Byte *testByte0 = (Byte*)[data0 bytes];
        Byte a0 = (Byte)testByte0[1];
        
        NSString *macStr = [self rangeOfMacAddress:self.macAddress];
        
        //MAC地址
        NSString *str1 = [NSString stringWithFormat:@"0x%@",[macStr substringToIndex:2]];
        [self dataForHexString:str1];
        data1 = data;
        Byte *testByte1 = (Byte*)[data1 bytes];
        Byte a1 = (Byte)testByte1[1];
        
        NSString *str2 = [NSString stringWithFormat:@"0x%@",[macStr  substringWithRange:NSMakeRange(2, 2)]];
        [self dataForHexString:str2];
        data2 = data;
        Byte *testByte2 = (Byte*)[data2 bytes];
        Byte a2 = (Byte)testByte2[1];
        
        NSString *str3 = [NSString stringWithFormat:@"0x%@",[macStr  substringWithRange:NSMakeRange(4, 2)] ];
        [self dataForHexString:str3];
        data3 = data;
        Byte *testByte3 = (Byte*)[data3 bytes];
        Byte a3 = (Byte)testByte3[1];
        
        NSString *str4 = [NSString stringWithFormat:@"0x%@",[macStr  substringWithRange:NSMakeRange(6, 2)] ];
        [self dataForHexString:str4];
        data4 = data;
        Byte *testByte4 = (Byte*)[data4 bytes];
        Byte a4 = (Byte)testByte4[1];
        
        NSString *str5 = [NSString stringWithFormat:@"0x%@",[macStr  substringWithRange:NSMakeRange(8, 2)] ];
        [self dataForHexString:str5];
        data5 = data;
        Byte *testByte5 = (Byte*)[data5 bytes];
        Byte a5 = (Byte)testByte5[1];
        
        NSString *str6 = [NSString stringWithFormat:@"0x%@",[macStr  substringWithRange:NSMakeRange(10, 2)] ];
        [self dataForHexString:str6];
        data6 = data;
        Byte *testByte6 = (Byte*)[data6 bytes];
        Byte a6 = (Byte)testByte6[1];
        
        //设备类型标识符
        NSString *lment = [NSString stringWithFormat:@"0x%@",Zament];
        [self dataForHexString:lment];
        data7 = data;
        Byte *testByte7 = (Byte *)[data7 bytes];
        Byte a7 = (Byte)testByte7[1];
        
        //服务标识符
        NSString *ac = @"27";
        NSString *ab = [NSString stringWithFormat:@"0x%@",ac];
        [self dataForHexString:ab];
        data8 = data;
        Byte *testByte8 = (Byte*)[data8 bytes];
        Byte a8 = (Byte)testByte8[1];
        
        //秘钥验证解锁
        NSString *ac1 = @"02";
        NSString *ab1 = [NSString stringWithFormat:@"0x%@",ac1];
        [self dataForHexString:ab1];
        data9 = data;
        Byte *testByte9 = (Byte*)[data9 bytes];
        Byte a9 = (Byte)testByte9[1];
        
        //4个秘钥
        NSString *key1 = [NSString stringWithFormat:@"%@",ay[0]];
        if(key1.length == 1){
            
            NSString *str77 = [NSString stringWithFormat:@"0x0%@",ay[0]];
            [self dataForHexString:str77];
        }else{
            NSString *str88 = [NSString stringWithFormat:@"0x%@",ay[0]];
            [self dataForHexString:str88];
        }
        data10 = data;
        Byte *testByte10 = (Byte*)[data10 bytes];
        Byte a10 = (Byte)testByte10[1];
        
        NSString *key2 = [NSString stringWithFormat:@"%@",ay[1]];
        if(key2.length == 1){
            
            NSString *str77 = [NSString stringWithFormat:@"0x0%@",ay[1]];
            [self dataForHexString:str77];
        }else{
            NSString *str88 = [NSString stringWithFormat:@"0x%@",ay[1]];
            [self dataForHexString:str88];
        }
        data11 = data;
        Byte *testByte11 = (Byte*)[data11 bytes];
        Byte a11 = (Byte)testByte11[1];
        
        NSString *key3 = [NSString stringWithFormat:@"%@",ay[2]];
        if(key3.length == 1){
            
            NSString *str77 = [NSString stringWithFormat:@"0x0%@",ay[2]];
            [self dataForHexString:str77];
        }else{
            NSString *str88 = [NSString stringWithFormat:@"0x%@",ay[2]];
            [self dataForHexString:str88];
        }
        data12 = data;
        Byte *testByte12 = (Byte*)[data12 bytes];
        Byte a12 = (Byte)testByte12[1];
        
        NSString *key4 = [NSString stringWithFormat:@"%@",ay[3]];
        if(key4.length == 1){
            
            NSString *str77 = [NSString stringWithFormat:@"0x0%@",ay[3]];
            [self dataForHexString:str77];
        }else{
            NSString *str88 = [NSString stringWithFormat:@"0x%@",ay[3]];
            [self dataForHexString:str88];
        }
        data13 = data;
        Byte *testByte13 = (Byte*)[data13 bytes];
        Byte a13 = (Byte)testByte13[1];
        
        //开锁指令标识符
        NSString *lintions = [NSString stringWithFormat:@"0x%@",intions];
        [self dataForHexString:lintions];
        data14 = data;
        Byte *testByte14 = (Byte *)[data14 bytes];
        Byte a14 = (Byte)testByte14[1];
        
        //效验
        Byte yy = (Byte)((a0+a1 + a2 + a3 + a4 + a5 + a6 + a7 + a8 + a9+ a10+a11+a12+a13+a14)&0xFF);
        Byte xx = ~yy;
        
        Byte a15 = xx;
        
        Byte byte[] = {a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a13,a12,a11,a10,a14,a15};
        NSData *datas = [NSData dataWithBytes:&byte length:sizeof(byte)];
        NSLog(@"开门请求 ===  %@",datas);
        [self.currentPeripheral writeValue:datas forCharacteristic:self.currentCharacteristic type:CBCharacteristicWriteWithResponse];
        
        oneNS = nil;
        fiv = nil;
        mac = nil;
        six = nil;
        [muarray removeAllObjects];
        [self send];
        
        [self performSelector:@selector(_gOne) withObject:nil afterDelay:0.4];
    }
}

-(void)_gOne{
    
    // if (success == YES && changIndex == 0 && changsIndex == 0 && csIndex == 1) {
    NSString *sucNS = [oneNS substringWithRange:NSMakeRange(16, 2)];
    if ([sucNS isEqualToString:@"67"] && ons.length > 27) {
        //成功
        [self thr];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:contrlDeviceSuccessNotification object:nil];
//        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
         [[NSNotificationCenter defaultCenter] postNotificationName:contrlDeviceFailNotification object:nil];
    }
        
//    if (ons.length < 27){
//        
//        NSLog(@"ons..... %@",ons);
//        
//    }else if (ons.length > 35){
//        
//        NSLog(@"ons..... %@",ons);
////        [SVProgressHUD showErrorWithStatus:@"种子文件获取失败,请重新获取!"];
//        
//    }else if([sucNS isEqualToString:@"7f"]){
//        
//        //失败的原因
////        [self two];
//    }
    
}


-(void)ControllerDevice:(CGFloat)time{
    self.selectTime = time;
    
    [self send];
    
    [self performSelector:@selector(_openTime) withObject:nil afterDelay:0.2];

    
}

-(BOOL)messByte:(NSString *)bytes{
    
    //种子1
    NSString *seed1 = [bytes substringToIndex:2];
    NSString *one11 = [NSString stringWithFormat:@"0x%@",seed1];
    [self dataForHexString:one11];
    zData1 = data;
    Byte *oneByte = (Byte *)[zData1 bytes];
    Byte ones = (Byte)oneByte[1];
    
    //种子2
    NSString *seed2 = [bytes substringWithRange:NSMakeRange(2, 2)];
    NSString *two = [NSString stringWithFormat:@"0x%@",seed2];
    [self dataForHexString:two];
    zData2 = data;
    Byte *twoByte = (Byte *)[zData2 bytes];
    Byte twos = (Byte)twoByte[1];
    
    //种子3
    NSString *seed3 = [bytes substringWithRange:NSMakeRange(4, 2)];
    NSString *thr = [NSString stringWithFormat:@"0x%@",seed3];
    [self dataForHexString:thr];
    zData3 = data;
    Byte *thrByte = (Byte *)[zData3 bytes];
    Byte thrs = (Byte)thrByte[1];
    
    //种子4
    NSString *seed4 = [bytes substringWithRange:NSMakeRange(6, 2)];
    NSString *four = [NSString stringWithFormat:@"0x%@",seed4];
    [self dataForHexString:four];
    zData4 = data;
    Byte *fourByte = (Byte *)[zData4 bytes];
    Byte fours = (Byte)fourByte[1];
    
    unsigned char seed[] = {ones,twos,thrs,fours};
    
    int length = 4;
    //Byte key[4];
    unsigned char key[4];
    {
        int i;
        union{
            unsigned char byte[4];
            unsigned int wort;
        }seedlokal;
        
        
        const unsigned int mask = 0x56AFCA45;
        if (seed[0] == 0 && seed[1] == 0 && seed[2] == 0 && seed[3] == 0 ) {
            return 0;
        }else{
            
            seedlokal.wort = ((unsigned int)seed[0] << 24) + ((unsigned int)seed[1] << 16) +((unsigned int)seed[2] << 8) + (unsigned int)seed[3];
            for (i = 0; i<35; i++) {
                if (seedlokal.wort & 0x80000000) {
                    seedlokal.wort = seedlokal.wort << 1;
                    seedlokal.wort = seedlokal.wort^mask;
                }else{
                    
                    seedlokal.wort = seedlokal.wort << 1;
                }
            }
            
            for (i = 0; i<length; i++) {
                
                key[3-i] = seedlokal.byte[i];
                
                int a = key[3-i];
                NSLog(@"a的值为 ==== %d",a);
                [self ToHex:(long long)a];
            }
            
        }
        return 1;
    }
}

-(NSString *)ToHex:(long long int)tmpid
{
    
    NSString *nLetterValue;
    str =@"";
    long long int ttmpig;
    for (int i = 0; i<9; i++) {
        ttmpig=tmpid%16;
        tmpid=tmpid/16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:nLetterValue=[[NSString alloc]initWithFormat:@"%zi",ttmpig];
                
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }
    }
    NSString *st = [NSString stringWithFormat:@"%@",str];
    [muarray addObject:st];
    return str;
}


- (NSData*)dataForHexString:(NSString*)hexString
{
    if (hexString == nil) {
        return nil;
    }
    const char* ch = [[hexString lowercaseString] cStringUsingEncoding:NSUTF8StringEncoding];
    
    data = [NSMutableData data];
    
    while (*ch) {
        if (*ch == ' ') {
            continue;
        }
        char byte = 0;
        if ('0' <= *ch && *ch <= '9') {
            byte = *ch - '0';
        }
        else if ('a' <= *ch && *ch <= 'f') {
            byte = *ch - 'a' + 10;
        }
        else if ('A' <= *ch && *ch <= 'F') {
            byte = *ch - 'A' + 10;
        }
        ch++;
        byte = byte << 4;
        if (*ch) {
            if ('0' <= *ch && *ch <= '9') {
                byte += *ch - '0';
            } else if ('a' <= *ch && *ch <= 'f') {
                byte += *ch - 'a' + 10;
            }
            else if('A' <= *ch && *ch <= 'F')
            {
                byte += *ch - 'A' + 10;
            }
            ch++;
        }
        [data appendBytes:&byte length:1];
    }
    
    return data;
    
}



-(void)thr{
    NSString *mass = ons;
    
    //将字母换成大写
    NSString *CaseString = [mass uppercaseString];
    
    //MAC地址
    mac = [CaseString substringWithRange:NSMakeRange(2, 12)];
    //四个种子HBYTE
    fiv = [CaseString substringWithRange:NSMakeRange(20, 8)];
    
    //校验
    six = [CaseString substringWithRange:NSMakeRange(28, 2)];
}

//截取MAC地址
-(NSString *)rangeOfMacAddress:(NSString *)macString{
    NSString * mac1 = [macString substringWithRange:NSMakeRange(0, 2)];
    
    NSString * mac2 = [macString substringWithRange:NSMakeRange(3, 2)];
    
    NSString * mac3 = [macString substringWithRange:NSMakeRange(6, 2)];
    
    NSString * mac4 = [macString substringWithRange:NSMakeRange(9, 2)];
    
    NSString * mac5 = [macString substringWithRange:NSMakeRange(12, 2)];
    
    NSString * mac6 = [macString substringWithRange:NSMakeRange(15, 2)];
    
    return [NSString stringWithFormat:@"%@%@%@%@%@%@",mac6,mac5,mac4,mac3,mac2,mac1];
}

//将mac地址  四个字节的种子 检验 截取出来并转为大写
-(void)one{
    NSString *mass = ons;
    //将字母换成大写
    NSString *CaseString = [mass uppercaseString];
    
    //MAC地址
    mac = [CaseString substringWithRange:NSMakeRange(2, 12)];
    //四个种子HBYTE
    fiv = [CaseString substringWithRange:NSMakeRange(20, 8)];
    //校验
    six = [CaseString substringWithRange:NSMakeRange(28, 2)];
}



#pragma mark ---- 计算秘钥需要
- (NSString *)convertDataToHexStr:(NSData *)data01 {
    if (!data01 || [data01 length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data01 length]];
    
    [data01 enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return string;
}
-(NSMutableArray *)peripheralArr{
    if (_peripheralArr == nil) {
        _peripheralArr = [NSMutableArray array];
    }
    return _peripheralArr;
}

-(void)reConnectDevice{
    if (self.currentPeripheral) {
        [self.mgr connectPeripheral:self.currentPeripheral options:nil];
    }
    
}

-(void)regist{
    if (self.currentPeripheral) {
        [self.mgr cancelPeripheralConnection:self.currentPeripheral];
    }
    oneNS = nil;
    fiv = nil;
    mac = nil;
    six = nil;
    [muarray removeAllObjects];
    [self.peripheralArr removeAllObjects];
    [self.mgr stopScan];
    
}


@end
