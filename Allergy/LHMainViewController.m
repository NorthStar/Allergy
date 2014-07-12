//
//  LHMainViewController.m
//  Allergy
//
//  Created by Xinlei Xu on 7/11/14.
//  Copyright (c) 2014 LinkedIn Hackday. All rights reserved.
//

#import "LHMainViewController.h"

@interface LHMainViewController ()
@end

static void *setupCompleteContext = &setupCompleteContext;

@implementation LHMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //TODO: pull user allergen
    if (self.userAllergen) {
    //    self.userAllergen = @[@"Cereals", @"Shellfish"];//hard-coded user info
   
        LHScanViewController *cameraViewController = [[LHScanViewController alloc] init];
        //  cameraViewController.delegate = self;
        cameraViewController.usersAllergen = self.userAllergen;//we should pull from database
        [cameraViewController.tabBarItem setImage:[UIImage imageNamed:@"camera.png"]];
        [cameraViewController.tabBarItem setTitle:@"CAMERA"];
    
        LHTableViewController *listViewController = [[LHTableViewController alloc]init];
        [listViewController.tabBarItem setTitle:@"LIST"];
        listViewController.userAllergen = self.userAllergen;
        [self setViewControllers:@[cameraViewController, listViewController] animated:YES];
    } else {
        LHSetupViewController *setupViewController = [[LHSetupViewController alloc] init];

        [[UITabBar appearance] setSelectedImageTintColor:[UIColor colorWithRed:127.0/255.0 green:186.0/255.0 blue:235.0/255.0 alpha:0.5]];
        [setupViewController.tabBarItem setTitle:@"SETUP"];
        
        [setupViewController addObserver:self forKeyPath:@"done" options:NSKeyValueObservingOptionNew context:setupCompleteContext];

        /*
        LHScanViewController *cameraViewController = [[LHScanViewController alloc] init];
        //  cameraViewController.delegate = self;
        cameraViewController.usersAllergen = self.userAllergen;//we should pull from database
        [cameraViewController.tabBarItem setImage:[UIImage imageNamed:@"camera.png"]];
        [cameraViewController.tabBarItem setTitle:@"CAMERA"];
        
        LHTableViewController *listViewController = [[LHTableViewController alloc]init];
        [listViewController.tabBarItem setTitle:@"LIST"];
        
        listViewController.userAllergen = self.userAllergen;
        [self setViewControllers:@[cameraViewController, setupViewController,listViewController] animated:YES];*/
        
        [self setViewControllers:@[setupViewController]];
        

        
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context != setupCompleteContext) {
        return;
    }
    NSString *newValue = [change valueForKey:NSKeyValueChangeNewKey];
    if ([newValue boolValue] == YES) {
        LHScanViewController *cameraViewController = [[LHScanViewController alloc] init];
        //  cameraViewController.delegate = self;
        cameraViewController.usersAllergen = self.userAllergen;//we should pull from database
        [cameraViewController.tabBarItem setImage:[UIImage imageNamed:@"camera.png"]];
        [cameraViewController.tabBarItem setTitle:@"CAMERA"];
        
        LHTableViewController *listViewController = [[LHTableViewController alloc]init];
        [listViewController.tabBarItem setTitle:@"LIST"];
        listViewController.userAllergen = self.userAllergen;
        [self setViewControllers:@[cameraViewController, listViewController] animated:YES];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
