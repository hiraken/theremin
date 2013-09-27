//
//  ViewController.h
//  theremin
//
//  Created by HIRAMATSU KENJIRO on 2013/09/28.
//  Copyright (c) 2013年 HIRAMATSU KENJIRO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RemoteOutput.h"

@interface AccelereminViewController : UIViewController <UIAccelerometerDelegate>{
    RemoteOutput *remoteOutput;
    IBOutlet UILabel *frequencyLabel;
    IBOutlet UISlider *bar;
    IBOutlet UIButton *c3;
    IBOutlet UIButton *d3;
    IBOutlet UIButton *e3;
    IBOutlet UIButton *f3;
    IBOutlet UIButton *g3;
    IBOutlet UIButton *a4;
    IBOutlet UIButton *b4;
    float syuha;
    float percen;
    int cnt;
    int col;
    float onkai;
}

- (IBAction)slide:(id)sender;

-(IBAction)c3:(id)sender;
-(IBAction)d3:(id)sender;
-(IBAction)e3:(id)sender;
-(IBAction)f3:(id)sender;
-(IBAction)g3:(id)sender;
-(IBAction)a4:(id)sender;
-(IBAction)b4:(id)sender;

@end
