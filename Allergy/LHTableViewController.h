//
//  LHTableViewController.h
//  Allergy
//
//  Created by Xinlei Xu on 7/12/14.
//  Copyright (c) 2014 LinkedIn Hackday. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHTableViewController : UITableViewController

@property (nonatomic, retain) NSArray *userAllergen;
@property (nonatomic, retain) NSArray *sadArray;
//- (NSInteger)numberOfUsers;
@property (nonatomic, strong) NSString *currentAdd;
@property (nonatomic, strong) NSString *currentDelete;

@end