//
//  LHSetupViewController.h
//  Allergy
//
//  Created by Xinlei Xu on 7/12/14.
//  Copyright (c) 2014 LinkedIn Hackday. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHSetupViewController : UIViewController
@property (nonatomic, strong) NSMutableArray *photoTitles;
@property (nonatomic, strong) UIImageView *photo;
@property (nonatomic, strong) NSNumber *done;
@property (nonatomic, strong) NSString *updateAllergen;
@end
