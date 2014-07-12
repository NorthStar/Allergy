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
static void *allergenAddedContext = &allergenAddedContext;

@implementation LHMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.userAllergen = [NSMutableArray array];
    //TODO: pull user allergen
    
    //[self.tabBar setTintColor:[UIColor greenColor]];
    if ([self.userAllergen count] > 0) {
   
        LHScanViewController *cameraViewController = [[LHScanViewController alloc] init];
        //  cameraViewController.delegate = self;
        cameraViewController.usersAllergen = self.userAllergen;//we should pull from database
        [cameraViewController.tabBarItem setImage:[UIImage imageNamed:@"camera.png"]];
        [cameraViewController.tabBarItem setTitle:@"CAMERA"];
    
        LHTableViewController *listViewController = [[LHTableViewController alloc]init];
        [listViewController.tabBarItem setImage:[UIImage imageNamed:@"list.png"]];
        [listViewController.tabBarItem setTitle:@"LIST"];
        listViewController.userAllergen = self.userAllergen;
        [self setViewControllers:@[listViewController, cameraViewController] animated:YES];
    } else {
        self.setupViewController = [[LHSetupViewController alloc] init];

        [[UITabBar appearance] setSelectedImageTintColor:[UIColor colorWithRed:230.0/255.0 green:140.0/255.0 blue:235.0/255.0 alpha:1.0]];
        [self.setupViewController.tabBarItem setTitle:@"SETUP"];
        
        [self.setupViewController addObserver:self forKeyPath:@"done" options:NSKeyValueObservingOptionNew context:setupCompleteContext];
        [self.setupViewController addObserver:self forKeyPath:@"updateAllergen" options:NSKeyValueObservingOptionNew context:allergenAddedContext];

        
        [self setViewControllers:@[self.setupViewController]]; 
    }
}


- (void)dealloc
{
    [self.setupViewController removeObserver:self forKeyPath:@"done"];
    [self.setupViewController removeObserver:self forKeyPath:@"updateAllergen"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == allergenAddedContext) {
        NSString *newValue = [change valueForKey:NSKeyValueChangeNewKey];
        if (newValue) {
            [self.userAllergen addObject:newValue];
        }
    }
    if (context != setupCompleteContext) {
        return;
    }
    
    NSString *newValue = [change valueForKey:NSKeyValueChangeNewKey];
    if ([newValue boolValue] == YES) {
        LHScanViewController *cameraViewController = [[LHScanViewController alloc] init];
        cameraViewController.usersAllergen = self.userAllergen;//we should pull from database
        [cameraViewController.tabBarItem setImage:[UIImage imageNamed:@"camera.png"]];
        [cameraViewController.tabBarItem setTitle:@"CAMERA"];
        
        LHTableViewController *listViewController = [[LHTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
        [listViewController.tabBarItem setTitle:@"LIST"];
        [listViewController.tabBarItem setImage:[UIImage imageNamed:@"list.png"]];
        
        listViewController.userAllergen = self.userAllergen;
        [self setViewControllers:@[listViewController, cameraViewController] animated:YES];
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
