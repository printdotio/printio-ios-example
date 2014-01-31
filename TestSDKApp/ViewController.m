//
//  ViewController.m
//  TestSDKApp
//
//  Created by Tengai on 12/13/13.
//  Copyright (c) 2013 TestSDKApp. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) HelloPics *helloPics;

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
        [self.helloPics customizationXML:xmlData];
    
    // Change title bar color
    if (self.switchTitleBarColor.isOn)
        [self.helloPics titleBarColor:[UIColor magentaColor]
                            fontColor:[UIColor whiteColor]];
    
    // Set what
    if (self.switchPhotoSources.isOn)
        [self.helloPics usePhotoSources:self.switchPhotoSources.isOn];
    
    // Set images, UIImage object and/or NSString image urls
    [self.helloPics images:images];
    
    // Set country code
    if (self.switchCountryCode.isOn){
        [self.helloPics countryCode:@"US"];
        [self.helloPics currencyCode:@"USD"];
        [self.helloPics languageCode:@"en"];
    }
    
    // Set custom icon
    [self.helloPics iconWithFileName:@"icon1"];
    
    // Set custom fonts
    if (self.switchCustomFonts.isOn){
        NSArray *fonts = @[@"timess.ttf", @"timess.ttf",
                           @"aubrey.ttf", @"CaviarDreams_Bold.ttf"];
        
        [self.helloPics customFonts:fonts];
    }
    
    // Set Payee name
    if (self.txtPayeeName.text){
        [self.helloPics payeeName:self.txtPayeeName.text];
    }
    
    //    [self.helloPics availablePhotoSources:[NSArray arrayWithObjects:
    //                                            [NSNumber numberWithInt:HELLOPICS_PS_FACEBOOK],
    //                                            [NSNumber numberWithInt:HELLOPICS_PS_INSTAGRAM], nil]];
    
    // Jumps directly to product
    if (self.switchJumpToProduct.isOn)
        [self.helloPics goToProductId:PRODUCT_PHONE_CASES()];
    
    // Jump To SKU
    if (self.switchJumpToSKU.isOn){
        [self.helloPics goToProductId:PRODUCT_PHONE_CASES()
                              withSKU:@"PhoneCase-BlackberryZ10-Gloss"];
    }
    
    // Open widget
    [self.helloPics open];
}

#pragma mark - HelloPics Delegate

- (void)HelloPicsWidgetOnOpen
{
    NSLog(@"HelloPicsWidgetOnOpen");
}

- (void)HelloPicsWidgetOnClose
{
    NSLog(@"HelloPicsWidgetOnClose");
    _helloPics = nil;
}

#pragma mark - Init

- (HelloPics *)helloPics
{
    if (!_helloPics){
        
        // Init HelloPics widget
        BOOL isProduction = self.switchProduction.isOn;
        NSString *recipeId = isProduction ? @"f255af6f-9614-4fe2-aa8b-1b77b936d9d6"  : @"12345-12345-12345-12345-12345";
        
        _helloPics = [[HelloPics alloc]initWithViewController:self
                                                  environment:isProduction ? HELLOPICS_PRODUCTION : HELLOPICS_STAGING
                                                     recipeId:recipeId];
        // Set Delegate
        [_helloPics setDelegate:self];
    }
    return _helloPics;
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
