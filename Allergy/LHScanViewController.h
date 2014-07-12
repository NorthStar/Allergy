//
//  LHScanViewController.h
//  Allergy
//
//  Created by Xinlei Xu on 7/11/14.
//  Copyright (c) 2014 LinkedIn Hackday. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"

@interface LHScanViewController : UIViewController <ZBarReaderDelegate>{
    UIImageView *resultImage;
    UITextView *resultText;
}

@property (nonatomic, retain) UIImageView *resultImage;
@property (nonatomic, retain) UITextView *resultText;
@property (nonatomic, strong) UIButton *scanButton;

@end
