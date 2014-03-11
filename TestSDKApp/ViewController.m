//
//  ViewController.m
//  TestSDKApp
//
//  Created by Tengai on 12/13/13.
//  Copyright (c) 2013 TestSDKApp. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) PrintIO *printIO;

@end

@implementation ViewController

- (IBAction)onClickTestSDK:(id)sender
{
    UIImage *image1 = [UIImage imageNamed:@"dream.jpg"];
    UIImage *image2 = [UIImage imageNamed:@"thunder.jpg"];
    
    NSArray *images = [NSArray arrayWithObjects:
                       image2, image1, nil];
    //@"http://res.cloudinary.com/demo/image/upload/sample.jpg",
    //@"http://photographylife.com/wp-content/uploads/2012/10/Nikon-D600-Sample-11.jpg",
    //@"http://www.digitaltrends.com/wp-content/uploads/2013/03/vertu-constellation-review-sample-image-flowers.jpg",
    
    // Path to XML customization file
    NSString *xmlPath = [[NSBundle mainBundle] pathForResource:@"customization"
                                                        ofType:@"xml"];
    NSData *xmlData = [NSData dataWithContentsOfFile:xmlPath];
    
    // Set customization file
    if (self.switchCustomization.isOn)
        [self.printIO customizationXML:xmlData];
    
    // Change title bar color
    if (self.switchTitleBarColor.isOn)
        [self.printIO titleBarColor:[UIColor magentaColor]
                            fontColor:[UIColor whiteColor]];
    
    // Set what
    if (self.switchPhotoSources.isOn){
        [self.printIO usePhotoSources:self.switchPhotoSources.isOn];
        
    } else {
        // Set images, UIImage object and/or NSString image urls
        [self.printIO images:images];
    }
    
    // Set country code
    if (self.switchCountryCode.isOn){
        [self.printIO countryCode:@"US"];
        [self.printIO currencyCode:@"USD"];
        [self.printIO languageCode:@"en"];
    }
    
    // Set custom icon
    [self.printIO iconWithFileName:@"icon1"];
    
    // Set custom fonts
    if (self.switchCustomFonts.isOn){
        NSArray *fonts = @[@"timess.ttf", @"timess.ttf",
                           @"aubrey.ttf", @"CaviarDreams_Bold.ttf"];
        
        [self.printIO customFonts:fonts];
    }
    
    // Set Payee name
    if (self.txtPayeeName.text){
        [self.printIO payeeName:self.txtPayeeName.text];
    }
    
    //    [self.helloPics availablePhotoSources:[NSArray arrayWithObjects:
    //                                            [NSNumber numberWithInt:PRINTIO_PS_FACEBOOK],
    //                                            [NSNumber numberWithInt:PRINTIO_PS_INSTAGRAM], nil]];
    
    // Jumps directly to product
    if (self.switchJumpToProduct.isOn)
        [self.printIO goToProductId:PRODUCT_PHONE_CASES()];
    
    // Jump To SKU
    if (self.switchJumpToSKU.isOn){
        [self.printIO goToProductId:PRODUCT_PHONE_CASES()
                              withSKU:@"PhoneCase-BlackberryZ10-Gloss"];
    }
    
    // Open widget
    [self.printIO open];
}

#pragma mark - HelloPics Delegate

- (void)PrintIOWidgetOnOpen
{
    NSLog(@"HelloPicsWidgetOnOpen");
}

- (void)PrintIOWidgetOnClose
{
    NSLog(@"HelloPicsWidgetOnClose");
    _printIO = nil;
}

#pragma mark - Init

- (PrintIO *)printIO
{
    if (!_printIO){
        
        // Init HelloPics widget
        BOOL isProduction = self.switchProduction.isOn;
        NSString *recipeId = isProduction ? @"f255af6f-9614-4fe2-aa8b-1b77b936d9d6"  : @"12345-12345-12345-12345-12345";
        
        _printIO = [[PrintIO alloc]initWithViewController:self
                                                  environment:isProduction ? PRINTIO_PRODUCTION : PRINTIO_STAGING
                                                     recipeId:recipeId];
        // Set Delegate
        [_printIO setDelegate:self];
    }
    return _printIO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

@end
