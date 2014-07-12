//
//  LHMainViewController.h
//  Allergy
//
//  Created by Xinlei Xu on 7/11/14.
//  Copyright (c) 2014 LinkedIn Hackday. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHScanViewController.h"
#import "LHTableViewController.h"
#import "LHSetupViewController.h"

@interface LHMainViewController : UITabBarController

@property (nonatomic) BOOL hasSetUp;
@property (nonatomic, strong) NSArray *userAllergen;
@end
