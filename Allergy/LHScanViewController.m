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
@synthesize resultImage, resultText;


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
    
    CGRect bounds = [self.view bounds];
    self.resultImage = [[UIImageView alloc]initWithFrame:bounds];
    self.resultText = [[UITextView alloc] initWithFrame:CGRectMake(bounds.origin.x, bounds.origin.y, 100, 120)];
    self.scanButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.scanButton setFrame:CGRectMake(bounds.origin.x + 40, bounds.origin.y + 40, 40, 40)];
    [self.scanButton setTitle:@"SCAN" forState:UIControlStateNormal];
    [self.scanButton addTarget:self action:@selector(onScanButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.resultImage];
    [self.view addSubview:self.resultText];
    [self.view addSubview:self.scanButton];
//    ScanditSDKOverlayController *picker  = [[ScanditSDKBarcodePicker alloc] initWithAppKey:@"VJVQ+AlqEeSXYL1blZ/wfS41T3I1V10lKStWPl0IR1E" cameraFacingPreference:CAMERA_FACING_BACK];
    
/*    [picker setPdf417Enabled:YES];
    
    //set delegate
    picker.overlayController.delegate = self;
    // start the scanning process:
    [picker startScanning];
    //Show the scanner. The easiest way to do so is by presenting it modally:
    [self presentViewController:picker animated:YES completion:nil];*/

}
- (void) onScanButtonTapped
{
    NSLog(@"TBD: scan barcode here...");
    ZBarReaderViewController *reader = [[ZBarReaderViewController alloc] init];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    
    reader.readerView.zoom = 1.0;
  //  ZBarImageScanner *scanner = reader.scanner;
    
    // TODO: (optional) additional reader configuration here
    
    // EXAMPLE: disable rarely used I2/5 to improve performance
   [reader.scanner setSymbology: ZBAR_UPCA config: ZBAR_CFG_ENABLE to: 0];
  /*  [reader.scanner setSymbology: ZBAR_UPCA
                        config: ZBAR_CFG_ENABLE
                              to: 0];
    */// present and release the controller
    [self presentViewController: reader animated: YES completion:nil];
}

- (void) dealloc
{
    self.resultImage = nil;
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
    resultText.text = symbol.data;

    // EXAMPLE: do something useful with the barcode image
    resultImage.image =
    [info objectForKey: UIImagePickerControllerOriginalImage];

    // ADD: dismiss the controller (NB dismiss from the *reader*!)
    [reader dismissViewControllerAnimated: YES completion:nil];
}

/*
#pragma mark - ScanditSDKOverlayControllerDelegate
- (void)scanditSDKOverlayController: (ScanditSDKOverlayController *)scanditSDKOverlayController
                     didScanBarcode:(NSDictionary *)barcodeResult {
    // add your own code to handle the barcode result e.g.
    NSString *symbology = [barcodeResult objectForKey:@"symbology"];
    NSString *barcode = [barcodeResult objectForKey:@"barcode"];
    NSLog(@"scanned %@ barcode: %@", symbology, barcode);
}
- (void)scanditSDKOverlayController: (ScanditSDKOverlayController *)scanditSDKOverlayController
                didCancelWithStatus:(NSDictionary *)status {
    // add your own code to handle the user canceling the barcode scan process
}
- (void)scanditSDKOverlayController: (ScanditSDKOverlayController *)scanditSDKOverlayController
                    didManualSearch:(NSString *)input {
    // add your own code to handle user input in the search bar
    // (only required if you use the search bar provided by the Scandit SDK
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
