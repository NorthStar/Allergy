//
//  LHScanViewController.m
//  Allergy
//
//  Created by Xinlei Xu on 7/11/14.
//  Copyright (c) 2014 LinkedIn Hackday. All rights reserved.
//

#import "LHScanViewController.h"
#import "ZBarSDK.h"

@interface LHScanViewController ()

@end

@implementation LHScanViewController
@synthesize resultText;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //\TODO: If the user has no allergen, we remind them to set some (cuz otherwise nothing will happen)
    CGRect bounds = [self.view bounds];
    self.resultText = [[UITextView alloc] initWithFrame:CGRectMake(bounds.origin.x, bounds.origin.y + 90, 400, 120)];
    self.scanButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.scanButton setFrame:CGRectMake(bounds.origin.x + 40, bounds.origin.y + 40, 240, 40)];
    [self.scanButton setTitle:@"SCAN" forState:UIControlStateNormal];
    [self.scanButton addTarget:self action:@selector(onScanButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.resultText];
    [self.view addSubview:self.scanButton];
}
- (void) onScanButtonTapped
{
    NSLog(@"TBD: scan barcode here...");
    ZBarReaderViewController *reader = [[ZBarReaderViewController alloc] init];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    
    reader.readerView.zoom = 1.0;
   [reader.scanner setSymbology: ZBAR_UPCA config: ZBAR_CFG_MAX_LEN to: 12];
    // present
    [self presentViewController: reader animated: YES completion:nil];
}

- (void) dealloc
{
//    self.resultImage = nil;
    self.resultText = nil;
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation
{
    return(YES);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setBarcode:(NSString *)barcode
{
    if (_barcode) {
        //update barcode
    }
    _barcode = barcode;
}
- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    // ADD: get the decode results
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        // EXAMPLE: just grab the first barcode
        break;

    // EXAMPLE: do something useful with the barcode data
//    resultText.text = symbol.data;
    self.barcode = [symbol.data substringFromIndex:1];
    //[self.scanButton setTitle:[NSString stringWithFormat:@"Barcode is %@", self.barcode]forState:UIControlStateNormal];
    [self.resultText setText:self.barcode];
    
    
    
    //process barcode
    NSString *requestString = [NSString stringWithFormat:@"http://api.foodessentials.com/label?u=%@&sid=9f5fb3b2-365c-403a-9c7f-0146aa9ecdce&appid=tk6dj6qqzmeuw25gafbqk4as&f=json&long=38.6300&lat=90.2000&api_key=tk6dj6qqzmeuw25gafbqk4as", self.barcode];

    self.responseData = [NSMutableData data];
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString: requestString]];
   // [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    __block NSDictionary *json;
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               json = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:0
                                                                        error:nil];
                               NSLog(@"Async JSON: %@", json);
                               /*if ([json count] == 0) {
                                   [self rescan];
                               }*/
                               BOOL isOkay = YES;
                               NSMutableArray *allergens = [NSMutableArray array];
                               NSString *allergenName = nil;
                               for (NSDictionary *allergenDescription in [json objectForKey:@"allergens"]) {
                                   if ([[allergenDescription valueForKey:@"allergen_value"]integerValue] > 0) {
                                       allergenName = [allergenDescription objectForKey:@"allergen_name"];
                                   
                                       if ([self.usersAllergen containsObject: allergenName]) {
                                           
                                           [self.resultText setText:@"NOT OKAY TO EAT"];
                                           
                                           isOkay = NO;
                                           [reader dismissViewControllerAnimated: YES completion:nil];
                                       }
                                       [allergens addObject:allergenName];
                                   }
                               }
                               if (isOkay) {
                                   [self.resultText setText:@"OKAY TO EAT"];
                               }

                           }];
    [reader dismissViewControllerAnimated: YES completion:nil];
}

- (void)rescan
{
    return;
}
#pragma mark -connectionDelegate
/*
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"didReceiveResponse");
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    //handle errors
    NSLog(@"didFailWithError");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    NSLog(@"Succeeded! Received %ul bytes of data",[self.responseData length]);
    
    // convert to JSON
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    // show all values
    for(id key in res) {
        
        id value = [res objectForKey:key];
        
        NSString *keyAsString = (NSString *)key;
        NSString *valueAsString = (NSString *)value;
        
        NSLog(@"key: %@", keyAsString);
        NSLog(@"value: %@", valueAsString);
    }
    
    // extract specific value...
    NSArray *results = [res objectForKey:@"results"];
    
    for (NSDictionary *result in results) {
        NSString *icon = [result objectForKey:@"icon"];
        NSLog(@"icon: %@", icon);
    }
    
}*/

@end
