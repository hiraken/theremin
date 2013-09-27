//
//  ViewController.m
//  theremin
//
//  Created by HIRAMATSU KENJIRO on 2013/09/28.
//  Copyright (c) 2013年 HIRAMATSU KENJIRO. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (void) handlePanGesture:(UIPanGestureRecognizer*) sender {
    UIPanGestureRecognizer* pan = (UIPanGestureRecognizer*) sender;
    CGPoint location = [pan translationInView:self.view];
    //syuha = sqrt(pow(location.x , 2.0) + pow(location.y , 2.0));
    // NSLog(@"pan x=%f, y=%f", location.x, location.y);
}

- (void)viewDidLoad {
    syuha = bar.value;
    
    UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [self.view addGestureRecognizer:panGesture];
    
    // ダブルタップ
    UITapGestureRecognizer* doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTapGesture:)];
    doubleTapGesture.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTapGesture];
    
    
    
    UIImage *img = [UIImage imageNamed:@"blue.png"];
    /*
     srand(time(nil));
     col = rand()%100;
     percen = (float)col;
     
     UIImageView *iv = [[UIImageView alloc] initWithImage:img];
     
     
     [self.view addSubview:iv];
     
     
     cnt = 3;
     */
    //加速度センサーを使う
    UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
    //更新(取得)頻度とデリゲートを設定する
    accelerometer.updateInterval = 1.0 / 50.0;
    accelerometer.delegate = self;
    
    remoteOutput = [[RemoteOutput alloc]init];
    [remoteOutput play];
}
/*
 - (AVCaptureSession *)session {
 NSError *error = nil;
 AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
 AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
 AVCaptureMovieFileOutput *movieFileOutput = [[[AVCaptureMovieFileOutput alloc] init] autorelease];
 
 [captureDevice lockForConfiguration:&error];
 captureDevice.torchMode = AVCaptureTorchModeOn;
 [captureDevice unlockForConfiguration];
 
 AVCaptureSession *captureSession_ = [[[AVCaptureSession alloc] init] autorelease];
 
 [captureSession_ beginConfiguration];
 if ([captureSession_ canAddInput:videoInput]) {
 [captureSession_ addInput:videoInput];
 }
 if ([captureSession_ canAddOutput:movieFileOutput]) {
 [captureSession_ addOutput:movieFileOutput];
 }
 captureSession_.sessionPreset = AVCaptureSessionPresetLow;
 [captureSession_ commitConfiguration];
 
 return captureSession_;
 }
 */

-(IBAction)c3:(id)sender{
    onkai = 261.6255653005986;
}
-(IBAction)d3:(id)sender{
    onkai = 293.6647679174076;
}
-(IBAction)e3:(id)sender{
    onkai = 329.6275569128699;
}
-(IBAction)f3:(id)sender{
    onkai = 349.2282314330039;
}
-(IBAction)g3:(id)sender{
    onkai = 391.99543598174927;
}
-(IBAction)a4:(id)sender{
    onkai = 440;
}
-(IBAction)b4:(id)sender{
    onkai = 493.8833012561241;
}
/*
 - (void) handleDoubleTapGesture:(UITapGestureRecognizer*)sender {
 
 switch(cnt){
 case 1:
 syuha = 1.0;
 cnt = 2;
 break;
 case 2:
 syuha = 11.0;
 cnt = 3;
 break;
 case 3:
 syuha = 22.0;
 cnt = 4;
 break;
 case 4:
 syuha = 33.0;
 cnt = 5;
 break;
 case 5:
 syuha = 44.0;
 cnt = 1;
 break;
 
 
 
 }
 
 NSLog(@"double tap");
 }
 
 - (IBAction)slide:(id)sender {
 syuha = bar.value;
 }
 */
//加速度センサーのy軸をノートナンバーにマッピング
- (void)accelerometer:(UIAccelerometer *)accelerometer
        didAccelerate:(UIAcceleration *)acceleration{
    //y軸の値を2.0〜0.0の範囲にする
    float value = (acceleration.y * -1.0) + 1.0;
    if(value > 2.0)value = 2.0;
    if(value < 0.0)value = 0.0;
    
    //ノートナンバーを127〜40の範囲にする
    float note_number = (127.0 - 40) * value * 0.5;
    note_number += 40;
    
    if(0){
        //ノートナンバーを72〜84（523.3のドからオクターブ上のドまで）の範囲にする
        note_number = 12 * value * 0.5;
        note_number += 72;
        //ノートナンバーを整数にして音階にする
        note_number = floor(note_number + 0.5);
        //ノートナンバーから周波数を計算
    }
    /*
     self.captureSession = [self session];
     [captureSession startRunning];
     */
    
    
    //float frequency = pow(2, (note_number - 69) / 12) * syuha;
    float frequency = onkai;
    remoteOutput.frequency = frequency;
    
    frequencyLabel.text = [NSString stringWithFormat:@"%.3f",frequency];
}

- (void)dealloc{
    UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
    accelerometer.delegate = nil;
    [remoteOutput release];
    [super dealloc];
}
@end

