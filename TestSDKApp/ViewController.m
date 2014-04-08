//
//  ViewController.m
//  TestSDKApp
//
//  Created by Tengai on 12/13/13.
//  Copyright (c) 2013 TestSDKApp. All rights reserved.
//

#import "ViewController.h"
#import <PrintIO/PIOSideMenuButton.h>

@interface ViewController ()

@property (nonatomic, strong) PrintIO *printIO;

@end

@implementation ViewController

- (IBAction)onClickTestSDK:(id)sender
{
    // MG Path 2
    if (self.SwitchMGPath2.isOn){
        [self testMGPath2];
        return;
    }
    
    // MG Path 1
    if (self.switchMirrorgram.isOn){
        [self testMirrorgram];
        return;
    }
    
    UIImage *image1 = [UIImage imageNamed:@"dream.jpg"];
    //UIImage *image2 = [UIImage imageNamed:@"thunder.jpg"];
    
    NSArray *images = [NSArray arrayWithObjects:image1, nil];
    
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
    }
    
    // Set country code
    if (self.switchCountryCode.isOn){
        [self.printIO countryCode:@"US"];
    }
    
    // Set currency code
    if (self.switchCurrencyCode.isOn){
        [self.printIO currencyCode:@"USD"];
    }
    
    // Set language code
    if (self.switchLanguageCode.isOn){
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
    
    // Set available photo sources
    NSMutableArray *photoSources = [[NSMutableArray alloc]init];
    
    if (self.switchPSPhone.isOn){
        [photoSources addObject:[[PIOSideMenuButton alloc]initWithType:PIO_SM_PHONE]];
    }
    
    if (self.switchPSFacebook.isOn){
        [photoSources addObject:[[PIOSideMenuButton alloc]initWithType:PIO_SM_FACEBOOK]];
    }
    
    if (self.switchPSInstagram.isOn){
        [photoSources addObject:[[PIOSideMenuButton alloc]initWithType:PIO_SM_INSTAGRAM]];
    }
    
    if (self.switchPSPicasa.isOn){
        [photoSources addObject:[[PIOSideMenuButton alloc]initWithType:PIO_SM_PICASA]];
    }
    
    if (self.switchPSFlickr.isOn){
        [photoSources addObject:[[PIOSideMenuButton alloc]initWithType:PIO_SM_FLICKR]];
    }
    
    if (self.switchPSDropbox.isOn){
        [photoSources addObject:[[PIOSideMenuButton alloc]initWithType:PIO_SM_DROPBOX]];
    }
    
    if (self.switchPSPhotobucket.isOn){
        [photoSources addObject:[[PIOSideMenuButton alloc]initWithType:PIO_SM_PHOTOBUCKET]];
    }
    
    [self.printIO availablePhotoSources:photoSources];
    
    
    // Jumps directly to product
    if (self.switchJumpToProduct.isOn)
        [self.printIO goToProductId:PRODUCT_PHONE_CASES()];
    
    // Jump To SKU
    if (self.switchJumpToSKU.isOn){
        [self.printIO goToProductId:PRODUCT_PHONE_CASES()
                            withSKU:@"PhoneCase-BlackberryZ10-Gloss"];
    }
    
    // Enable or disable Side Menu
    if (self.switchEnableSideMenu.isOn){
        [self.printIO enableSideMenu:YES];
        
        // Set options for Side Menu
        NSArray *buttons = [NSArray arrayWithObjects:[[PIOSideMenuButton alloc]initWithType:PIO_SM_SEARCH_BAR],[[PIOSideMenuButton alloc]initWithType:PIO_SM_EXIT_BUTTON], [[PIOSideMenuButton alloc]initWithType:PIO_SM_PRODUCTS], [[PIOSideMenuButton alloc]initWithType:PIO_SM_FEATURED_PRODUCTS], [[PIOSideMenuButton alloc]initWithType:PIO_SM_VIEW_CART], nil];
        
        NSArray *options = [NSArray arrayWithObjects:[[PIOSideMenuButton alloc]initWithType:PIO_SM_CHANGE_CURRENCY], [[PIOSideMenuButton alloc]initWithType:PIO_SM_CHANGE_COUNTRY], [[PIOSideMenuButton alloc]initWithType:PIO_SM_CHANGE_LANGUAGE], nil];
        
        NSArray *infos = [NSArray arrayWithObjects:[[PIOSideMenuButton alloc]initWithType:PIO_SM_PRICING_CHART],[[PIOSideMenuButton alloc]initWithType:PIO_SM_SHARE_APP], [[PIOSideMenuButton alloc]initWithType:PIO_SM_LIKE_US_FB], [[PIOSideMenuButton alloc]initWithType:PIO_SM_RATE_APP], [[PIOSideMenuButton alloc]initWithType:PIO_SM_ABOUT], [[PIOSideMenuButton alloc]initWithType:PIO_SM_HOW_IT_WORKS], [[PIOSideMenuButton alloc]initWithType:PIO_SM_PAST_ORDERS], nil];
        
        [self.printIO sideMenuAddButtons:buttons
                                 options:options
                            optionsTitle:@"Options"
                            optionsColor:[UIColor colorWithRed:34.0/255.0 green:160.0/255.0 blue:221.0/255.0 alpha:255.0/255.0]
                           accountsTitle:@"Accounts"
                           accountsColor:[UIColor colorWithRed:26.0/255.0 green:188.0/255.0 blue:156.0/255.0 alpha:255.0/255.0]
                                    info:infos
                               infoTitle:@"Info"
                               infoColor:[UIColor colorWithRed:100.0/255.0 green:106.0/255.0 blue:166.0/255.0 alpha:255.0/255.0]];
    }
    
    // Custom share text. Will be used form side menu button.
    if (self.switchCustomShareText.isOn){
        [self.printIO setApplicationShareText:@"Example share app text with link http://www.google.com"];
    }
    
    // Show custom double tap screen when customizing product
    if (self.switchCustomDoubleTapScreen.isOn){
        [self.printIO showCustomDoubleTapImage:[[NSBundle mainBundle] pathForResource:@"touch" ofType:@"png"]];
    }
    
    // Show button in navigation bar
    if (self.switchBtnInNavBar.isOn){
        [self.printIO showMenuButtonInNavigationBar:[[NSBundle mainBundle] pathForResource:@"icon1" ofType:@"png"]];
    }
    
    // Show/hide tab bar in Customization Screen
    [self.printIO showTabBarInCustomizeProduct:self.switchShowTabBarInCustomizationScreen.isOn];
    
    // Hide image list in Customize Product screen
    if (self.switchHideImagesListInCustomization.isOn){
        [self.printIO hideImagesListInCustomizationScreen:YES];
    }
    
    // Pass photos in SDK
    if (self.switchPassPhotosInSDK.isOn){
        [self.printIO images:images];
    }
    
    // Disable photo sources when photos are passed
    if (self.switchDisablePSWhenPhotosArePassed.isOn){
        [self.printIO disablePhotoSourcesWhenImagesArePassed:YES];
    }
    
    // Disable photo sources when photo is passed in SDK for one photo template
    if (self.switchDisablePSWhenPhotoIsPassedForOnePhototemplate.isOn){
        [self.printIO disablePhotoSourcesWhenImageIsPassedForOnePhotoTemplate:YES];
    }
    
    // Use passed image as thumbnail for one phtoo template
    if (self.switchUsePassedImageAsThumbForOnePhotoTemplate.isOn){
        [self.printIO setPassedImageAsThumbForOnePhotoTemplate:YES];
    }
    
    // Open widget
    [self.printIO open];
    
    NSLog(@"widget starting");
}

#pragma mark - Settings for partners

- (void)testMGPath2
{
    // Pass in one image
    UIImage *image1 = [UIImage imageNamed:@"dream.jpg"];
    NSArray *images = [NSArray arrayWithObjects:image1, nil];
    [self.printIO images:images];
    
    [self.printIO payeeName:@"Mirrorgram"];
    
    [self testMirrorgram];
}

- (void)testMirrorgram
{
    // TO-DO Production mode switch also
    
    [self.printIO enableSideMenu:YES];
    [self.printIO usePhotoSources:YES];
    
    // Available Photo sources
    [self.printIO availablePhotoSources:[NSArray arrayWithObjects:[[PIOSideMenuButton alloc]initWithType:PIO_SM_PHONE],[[PIOSideMenuButton alloc]initWithType:PIO_SM_INSTAGRAM], [[PIOSideMenuButton alloc]initWithType:PIO_SM_FACEBOOK], nil]];
    
    // Set main buttons for Side Menu
    PIOSideMenuButton *btnCamera = [[PIOSideMenuButton alloc]initWithTitle:@"CAMERA"
                                                                      type:PIO_SM_EXIT_BUTTON
                                                                  iconPath:nil];
    btnCamera.fontSize = 15.0;
    
    PIOSideMenuButton *btnProducts = [[PIOSideMenuButton alloc]initWithTitle:@"PRODUCTS"
                                                                        type:PIO_SM_PRODUCTS
                                                                    iconPath:nil];
    btnProducts.fontSize = 15.0;
    
    PIOSideMenuButton *btnViewCart = [[PIOSideMenuButton alloc]initWithTitle:@"VIEW CART"
                                                                        type:PIO_SM_VIEW_CART
                                                                    iconPath:nil];
    
    PIOSideMenuButton *btnPastOrders = [[PIOSideMenuButton alloc]initWithTitle:@"PAST ORDERS"
                                                                        type:PIO_SM_PAST_ORDERS
                                                                    iconPath:nil];
    btnViewCart.fontSize = 15.0;
    
    NSArray *buttons = [NSArray arrayWithObjects:btnCamera, btnProducts, btnViewCart, btnPastOrders, nil];
    
    // Options
    PIOSideMenuButton *btnChangeCurrency = [[PIOSideMenuButton alloc]initWithTitle:@"CHANGE CURRENCY"
                                                                              type:PIO_SM_CHANGE_CURRENCY
                                                                          iconPath:nil];
    btnChangeCurrency.fontSize = 14.0;
    
    PIOSideMenuButton *btnChangeCountry = [[PIOSideMenuButton alloc]initWithTitle:@"CHANGE COUNTRY"
                                                                             type:PIO_SM_CHANGE_COUNTRY
                                                                         iconPath:nil];
    btnChangeCountry.fontSize = 14.0;
    
    PIOSideMenuButton *btnChangeLanguage = [[PIOSideMenuButton alloc]initWithTitle:@"CHANGE LANGUAGE"
                                                                              type:PIO_SM_CHANGE_LANGUAGE
                                                                          iconPath:nil];
    btnChangeLanguage.fontSize = 14.0;
    
    NSArray *options = [NSArray arrayWithObjects:btnChangeCurrency, btnChangeCountry, btnChangeLanguage, nil];
    
    // Infos
    PIOSideMenuButton *btnHowItWorks = [[PIOSideMenuButton alloc]initWithTitle:@"HOW IT WORKS"
                                                                          type:PIO_SM_HOW_IT_WORKS
                                                                      iconPath:nil];
    btnHowItWorks.fontSize = 15.0;
    
    NSArray *infos = [NSArray arrayWithObjects:btnHowItWorks, nil];
    
    [self.printIO sideMenuAddButtons:buttons
                             options:options
                        optionsTitle:@"OPTIONS"
                        optionsColor:[UIColor colorWithRed:34.0/255.0 green:160.0/255.0 blue:221.0/255.0 alpha:255.0/255.0]
                       accountsTitle:@"SOCIAL ACCOUNTS"
                       accountsColor:[UIColor colorWithRed:26.0/255.0 green:188.0/255.0 blue:156.0/255.0 alpha:255.0/255.0]
                                info:infos
                           infoTitle:@"INFO"
                           infoColor:[UIColor colorWithRed:100.0/255.0 green:106.0/255.0 blue:166.0/255.0 alpha:255.0/255.0]];
    
    // Show custom double tap screen when customizing product
    [self.printIO showCustomDoubleTapImage:[[NSBundle mainBundle] pathForResource:@"touch" ofType:@"png"]];
    
    // Hide tab bar in Customize Product screen
    [self.printIO showTabBarInCustomizeProduct:NO];
    
    // Set visible buttons in Image Editor
    [self.printIO imageEditorShowButtons:[NSArray arrayWithObjects:[[PIOButton alloc]initWithType:PIO_BUTTON_IMAGE_EDITOR_INFO], nil]];
    
    // Show menu button in navigation bar
    [self.printIO showMenuButtonInNavigationBar:[[NSBundle mainBundle] pathForResource:@"mg" ofType:@"png"]];
    
    // Change title bar color
    [self.printIO titleBarColor:[UIColor darkGrayColor] fontColor:[UIColor whiteColor]];
    
    // Change shoping cart icon
    [self.printIO setShopingCartIcon:[[NSBundle mainBundle]pathForResource:@"icon_cart" ofType:@"png"]];
    
    [self.printIO setPartnerId:PARTNER_MIRRORGRAM];
    
    // START WIDGET
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
    
    [self.scrollView addSubview:self.panelView];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.panelView.frame.size.height);
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
