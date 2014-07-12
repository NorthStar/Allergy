//
//  LHTableViewController.m
//  Allergy
//
//  Created by Xinlei Xu on 7/12/14.
//  Copyright (c) 2014 LinkedIn Hackday. All rights reserved.
//

#import "LHTableViewController.h"

@interface LHTableViewController ()

@end

@implementation LHTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.sadArray = @[@"Cereal", @"Corn", @"Egg", @"Fish", @"Gluten", @"Lactose", @"Milk", @"Peanut", @"Sesame Seed", @"Shellfish", @"Soybean", @"Sulfite", @"Tree Nut", @"Wheat"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  /*
    CGRect insetBounds = CGRectInset(self.view.bounds, 40, 40);
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(insetBounds.origin.x, insetBounds.origin.y, insetBounds.size.width, 25)];
    [title setText:@"Your Allergens"];
    [title setFont:[UIFont fontWithName:@"HelveticaNeueLight" size:30]];
    [title setTextAlignment:NSTextAlignmentRight];
    [self.view addSubview:title];
    insetBounds = UIEdgeInsetsInsetRect(insetBounds, UIEdgeInsetsMake(40 ,0 , 85, 0));
    [self.tableView setFrame: insetBounds];*/
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (NSInteger)numberOfUsers
{
    return 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return [self numberOfUsers];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.sadArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell.
    cell.textLabel.text = [self.sadArray objectAtIndex:indexPath.row];//[self.userAllergen objectAtIndex:indexPath.row];
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", cell.textLabel.text]];
    cell.imageView.image = [[UIImageView alloc] initWithImage:image].image;
    
    CGRect bounds = cell.backgroundView.bounds;
    
    if (cell.imageView.image) {
        UISwitch *aSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(bounds.origin.x + 240, bounds.origin.y + bounds.size.height + 20, 40, 20)];
        //add validation
        if ([self.userAllergen containsObject: cell.textLabel.text]) {
            [aSwitch setOn:YES animated:YES];
        } else {
            [aSwitch setOn:NO animated:YES];
        }
        [aSwitch setThumbTintColor:[UIColor whiteColor]];
        //[aSwitch setOnTintColor: [UIColor colorWithRed:230.0/255.0 green:140.0/255.0 blue:235.0/255.0 alpha:0.5]];
        [aSwitch setTintColor:[UIColor colorWithRed:230.0/255.0 green:140.0/255.0 blue:235.0/255.0 alpha:0.9]];
        
       // [aSwitch addTarget:self action:@selector([tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade]) forControlEvents:UIControlEventValueChanged];
        [cell addSubview:aSwitch];
    }
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    return 10;
}

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}*/
/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = NSLocalizedString(@"Your Allergens", @"mySectionName");
            break;
        case 1:
            sectionName = NSLocalizedString(@"His Allergens", @"myOtherSectionName");
            break;
            // ...
        default:
            sectionName = @"";
            break;
    }
    return sectionName;
}*/
/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
