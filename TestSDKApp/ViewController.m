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
    // Photobucket
    if (self.switchPhotobucket.isOn){
        [self testPhotobucket];
        return;
    }
    
    // MG Path 3
    if (self.SwitchMGPath3.isOn){
        [self testMGPath3];
        return;
    }
    
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
                       optionsTitleColor:[UIColor whiteColor]
                            optionsColor:[UIColor colorWithRed:34.0/255.0 green:160.0/255.0 blue:221.0/255.0 alpha:255.0/255.0]
                           accountsTitle:@"Accounts"
                      accountsTitleColor:[UIColor whiteColor]
                           accountsColor:[UIColor colorWithRed:26.0/255.0 green:188.0/255.0 blue:156.0/255.0 alpha:255.0/255.0]
                                    info:infos
                               infoTitle:@"Info"
                          infoTitleColor:[UIColor whiteColor]
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
    
    // Hide Category/Search view in Featured Products screen
    if (self.hideCategoriesView.isOn){
        [self.printIO hideCategoryViewInFeaturedProducts:YES];
    }
    
    // Hide status bar
    if (self.switchHideStatusBar.isOn){
        [self.printIO hideStatusBar:YES];
    }
    
    // Set country in featured products
    if (self.switchSetCountryInFProducts.isOn){
        [self.printIO setCountryInFeaturedProducts:YES];
    }
    
    // Change loading GIF animation
    if (self.switchCustomGIF.isOn){
        [self.printIO setLoadingGIF:@"load"];
    }
    
    // Open widget
    [self.printIO open];
    
    NSLog(@"widget starting");
}

#pragma mark - Settings for partners

- (void)testMGPath3
{
    [self.printIO setMGPathNumber:3];
    
    [self testMGPath2];
}

- (void)testMGPath2
{
    // Pass in one image
    UIImage *image1 = [UIImage imageNamed:@"dream.jpg"];
    NSArray *images = [NSArray arrayWithObjects:image1, nil];
    [self.printIO images:images];
    
    
    
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
                                                                  iconPath:[[NSBundle mainBundle] pathForResource:@"btn_camera" ofType:@"png"]];
    btnCamera.fontSize = 15.0;
    
    PIOSideMenuButton *btnProducts = [[PIOSideMenuButton alloc]initWithTitle:@"PRODUCTS"
                                                                        type:PIO_SM_PRODUCTS
                                                                    iconPath:[[NSBundle mainBundle] pathForResource:@"btn_products" ofType:@"png"]];
    btnProducts.fontSize = 15.0;
    
    PIOSideMenuButton *btnViewCart = [[PIOSideMenuButton alloc]initWithTitle:@"VIEW CART"
                                                                        type:PIO_SM_VIEW_CART
                                                                    iconPath:[[NSBundle mainBundle] pathForResource:@"btn_cart" ofType:@"png"]];
    
    PIOSideMenuButton *btnEmailSupport = [[PIOSideMenuButton alloc]initWithTitle:@"EMAIL SUPPORT"
                                                                            type:PIO_SM_EMAIL_SUPPORT
                                                                        iconPath:[[NSBundle mainBundle] pathForResource:@"btn_email_support" ofType:@"png"]];
    btnEmailSupport.dataHolder = @"support@mirrorgram.com";
    
    NSArray *buttons;
    
    if (self.SwitchMGPath2.isOn){
        PIOSideMenuButton *btnShareWithImage = [[PIOSideMenuButton alloc]initWithTitle:@"   SHARE"
                                                                                  type:PIO_SM_SHARE_WITH_IMAGE
                                                                              iconPath:nil];
        buttons = [NSArray arrayWithObjects:btnCamera, btnShareWithImage, btnProducts, btnViewCart, btnEmailSupport, nil];
    } else {
        buttons = [NSArray arrayWithObjects:btnCamera, btnProducts, btnViewCart, btnEmailSupport, nil];
    }
    
    btnViewCart.fontSize = 15.0;
    
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
                                                                      iconPath:[[NSBundle mainBundle] pathForResource:@"btn_info" ofType:@"png"]];
    btnHowItWorks.fontSize = 15.0;
    
    NSArray *infos = [NSArray arrayWithObjects:btnHowItWorks, nil];
    
    [self.printIO sideMenuAddButtons:buttons
                             options:options
                        optionsTitle:@"OPTIONS"
                   optionsTitleColor:[UIColor blackColor]
                        optionsColor:[UIColor colorWithRed:190.0/255.0 green:190.0/255.0 blue:190.0/255.0 alpha:255.0/255.0]
     
                       accountsTitle:@"SOCIAL ACCOUNTS"
                  accountsTitleColor:[UIColor blackColor]
                       accountsColor:[UIColor colorWithRed:190.0/255.0 green:190.0/255.0 blue:190.0/255.0 alpha:255.0/255.0]
                                info:infos
                           infoTitle:@"INFO"
                      infoTitleColor:[UIColor blackColor]
                           infoColor:[UIColor colorWithRed:190.0/255.0 green:190.0/255.0 blue:190.0/255.0 alpha:255.0/255.0]];
    
    // Show custom double tap screen when customizing product
    [self.printIO showCustomDoubleTapImage:@""];
    
    // Hide tab bar in Customize Product screen
    [self.printIO showTabBarInCustomizeProduct:NO];
    
    // Set visible buttons in Image Editor
    [self.printIO imageEditorShowButtons:[NSArray arrayWithObjects:[[PIOButton alloc]initWithType:PIO_BUTTON_IMAGE_EDITOR_INFO], nil]];
    
    // Show menu button in navigation bar
    [self.printIO showMenuButtonInNavigationBar:[[NSBundle mainBundle] pathForResource:@"mg_menu" ofType:@"png"]];
    
    // Change title bar color
    [self.printIO titleBarColor:[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0]
                      fontColor:[UIColor whiteColor]];
    
    // Change shoping cart icon
    [self.printIO setShopingCartIcon:[[NSBundle mainBundle]pathForResource:@"mg_cart" ofType:@"png"]];
    [self.printIO setShopingCartIconWithCircle:[[NSBundle mainBundle]pathForResource:@"mg_cart_new" ofType:@"png"]];
    
    [self.printIO setPartnerId:PARTNER_MIRRORGRAM];
    
    [self.printIO setBackgoundImageForSideMenuItems:[[NSBundle mainBundle]pathForResource:@"bcg" ofType:@"png"]];
    
    [self.printIO payeeName:@"Mirrorgram"];
    
    [self.printIO setPassedImageAsThumbForOnePhotoTemplate:YES];
    
    // Set custom icon
    [self.printIO iconWithFileName:@"mg_menu"];
    
    [self.printIO hideCategoryViewInFeaturedProducts:YES];
    [self.printIO hideStatusBar:YES];
    
    [self.printIO setBackgoundImageForToolbarInCustomizeProduct:[[NSBundle mainBundle]pathForResource:@"mg_toolbar_bcg" ofType:@"png"]];
    [self.printIO setIconForHelpButtonInCustomizeProduct:[[NSBundle mainBundle]pathForResource:@"mg_icon_question_mark" ofType:@"png"]];
    [self.printIO setImageForAddPhotosButton:[[NSBundle mainBundle]pathForResource:@"mg_add_photos" ofType:@"png"]];
    
    [self.printIO setCountryInFeaturedProducts:YES];
    
    [self.printIO setIconForBackButton:[[NSBundle mainBundle]pathForResource:@"mg_back_new" ofType:@"png"]];
    
    // Path to XML customization file
    NSString *xmlPath = [[NSBundle mainBundle] pathForResource:@"customization_mg" ofType:@"xml"];
    NSData *xmlData = [NSData dataWithContentsOfFile:xmlPath];
    [self.printIO customizationXML:xmlData];
    
    [self.printIO hideIconForUplaodInstructions:YES];
    
    [self.printIO setDoubleTapBaloonImage:[[NSBundle mainBundle]pathForResource:@"mg_double_tap_balloon" ofType:@"png"]
                                     text:@"Double tap photo to edit"
                                textColor:[UIColor whiteColor]];
    
    [self.printIO removePlusFromAddMoreProductsButton:YES];
    
    [self.printIO setBackgroundColorForNavBarButtonLeft:[UIColor clearColor]
                                                  right:[UIColor colorWithRed:34.0/255.0 green:119.0/255.0 blue:212.0/255.0 alpha:1.0]];
    
    [self.printIO removeLogoFromPaymentScreen:YES];
    
    // START WIDGET
    [self.printIO open];
}

- (void)testPhotobucket
{
    [self.printIO enableSideMenu:YES];
    [self.printIO usePhotoSources:YES];
    [self.printIO showTabBarInCustomizeProduct:YES];
    [self.printIO titleBarColor:[UIColor whiteColor] fontColor:[UIColor blackColor]];
    [self.printIO payeeName:@"Photobucket"];
    [self.printIO setCountryInFeaturedProducts:YES];
    [self.printIO setStatusBarDark:YES];
    [self.printIO setShopingCartIconWithCircle:[[NSBundle mainBundle]pathForResource:@"pb_cart" ofType:@"png"]];
    [self.printIO setIconForBackButton:[[NSBundle mainBundle]pathForResource:@"pb_back" ofType:@"png"]];
    [self.printIO setIconForSideMenu:[[NSBundle mainBundle]pathForResource:@"pb_menu" ofType:@"png"]];
    [self.printIO setBackgoundImageForSideMenuItems:[[NSBundle mainBundle]pathForResource:@"pb_bcg" ofType:@"png"]];
    [self.printIO setBackgroundColorForSideMenu:[UIColor colorWithRed:227.0/255.0 green:227.0/255.0 blue:225.0/255.0 alpha:1.0]];
    [self.printIO hideStatusBar:YES];
    [self.printIO setPartnerId:PARTNER_PHOTOBUCKET];
    [self.printIO iconWithFileName:@""];
    [self.printIO removeLogoFromPaymentScreen:YES];
    
    // Available Photo sources
    PIOSideMenuButton *btnPhone = [[PIOSideMenuButton alloc]initWithType:PIO_SM_PHONE];
    
    PIOSideMenuButton *btnInstagram = [[PIOSideMenuButton alloc]initWithType:PIO_SM_INSTAGRAM];
    btnInstagram.iconPath = [[NSBundle mainBundle] pathForResource:@"pb_btn_side_menu_instagram_transparent" ofType:@"png"];
    btnInstagram.iconPathSelected = [[NSBundle mainBundle] pathForResource:@"pb_btn_side_menu_instagram_transparent" ofType:@"png"];
    btnInstagram.textColor = [UIColor blackColor];
    
    PIOSideMenuButton *btnFb = [[PIOSideMenuButton alloc]initWithType:PIO_SM_FACEBOOK];
    btnFb.iconPath = [[NSBundle mainBundle] pathForResource:@"pb_btn_side_menu_fb_transparent" ofType:@"png"];
    btnFb.iconPathSelected = [[NSBundle mainBundle] pathForResource:@"pb_btn_side_menu_fb_transparent" ofType:@"png"];
    btnFb.textColor = [UIColor blackColor];
    
    [self.printIO availablePhotoSources:[NSArray arrayWithObjects:btnPhone,btnInstagram,btnFb, nil]];
    
    // Set main buttons for Side Menu
    PIOSideMenuButton *btnCamera = [[PIOSideMenuButton alloc]initWithTitle:@"EXIT"
                                                                      type:PIO_SM_EXIT_BUTTON
                                                                  iconPath:[[NSBundle mainBundle] pathForResource:@"pb_btn_camera" ofType:@"png"]];
    btnCamera.fontSize = 15.0;
    btnCamera.textColor = [UIColor blackColor];
    
    PIOSideMenuButton *btnProducts = [[PIOSideMenuButton alloc]initWithTitle:@"PRODUCTS"
                                                                        type:PIO_SM_PRODUCTS
                                                                    iconPath:[[NSBundle mainBundle] pathForResource:@"pb_btn_products" ofType:@"png"]];
    btnProducts.fontSize = 15.0;
    btnProducts.textColor = [UIColor blackColor];
    
    PIOSideMenuButton *btnViewCart = [[PIOSideMenuButton alloc]initWithTitle:@"VIEW CART"
                                                                        type:PIO_SM_VIEW_CART
                                                                    iconPath:[[NSBundle mainBundle] pathForResource:@"pb_btn_cart" ofType:@"png"]];
    btnViewCart.textColor = [UIColor blackColor];
    
    PIOSideMenuButton *btnEmailSupport = [[PIOSideMenuButton alloc]initWithTitle:@"EMAIL SUPPORT"
                                                                            type:PIO_SM_EMAIL_SUPPORT
                                                                        iconPath:[[NSBundle mainBundle] pathForResource:@"pb_btn_email_support" ofType:@"png"]];
    btnEmailSupport.dataHolder = @"support@photobucket.com";
    btnEmailSupport.textColor = [UIColor blackColor];
    NSArray *buttons;
    
    if (self.SwitchMGPath2.isOn){
        PIOSideMenuButton *btnShareWithImage = [[PIOSideMenuButton alloc]initWithTitle:@"   SHARE"
                                                                                  type:PIO_SM_SHARE_WITH_IMAGE
                                                                              iconPath:nil];
        buttons = [NSArray arrayWithObjects:btnCamera, btnShareWithImage, btnProducts, btnViewCart, btnEmailSupport, nil];
    } else {
        buttons = [NSArray arrayWithObjects:btnCamera, btnProducts, btnViewCart, btnEmailSupport, nil];
    }
    
    btnViewCart.fontSize = 15.0;
    
    // Options
    PIOSideMenuButton *btnChangeCurrency = [[PIOSideMenuButton alloc]initWithTitle:@"CHANGE CURRENCY"
                                                                              type:PIO_SM_CHANGE_CURRENCY
                                                                          iconPath:nil];
    btnChangeCurrency.fontSize = 14.0;
    btnChangeCurrency.textColor = [UIColor blackColor];
    
    PIOSideMenuButton *btnChangeCountry = [[PIOSideMenuButton alloc]initWithTitle:@"CHANGE COUNTRY"
                                                                             type:PIO_SM_CHANGE_COUNTRY
                                                                         iconPath:nil];
    btnChangeCountry.fontSize = 14.0;
    btnChangeCountry.textColor = [UIColor blackColor];
    
    PIOSideMenuButton *btnChangeLanguage = [[PIOSideMenuButton alloc]initWithTitle:@"CHANGE LANGUAGE"
                                                                              type:PIO_SM_CHANGE_LANGUAGE
                                                                          iconPath:nil];
    btnChangeLanguage.fontSize = 14.0;
    btnChangeLanguage.textColor = [UIColor blackColor];
    
    NSArray *options = [NSArray arrayWithObjects:btnChangeCurrency, btnChangeCountry, btnChangeLanguage, nil];
    
    // Infos
    PIOSideMenuButton *btnHowItWorks = [[PIOSideMenuButton alloc]initWithTitle:@"HOW IT WORKS"
                                                                          type:PIO_SM_HOW_IT_WORKS
                                                                      iconPath:[[NSBundle mainBundle] pathForResource:@"pb_btn_info" ofType:@"png"]];
    btnHowItWorks.fontSize = 15.0;
    btnHowItWorks.textColor = [UIColor blackColor];
    
    NSArray *infos = [NSArray arrayWithObjects:btnHowItWorks, nil];
    
    [self.printIO sideMenuAddButtons:buttons
                             options:options
                        optionsTitle:@"OPTIONS"
                   optionsTitleColor:[UIColor whiteColor]
                        optionsColor:[UIColor colorWithRed:34.0/255.0 green:119.0/255.0 blue:212.0/255.0 alpha:255.0/255.0]
     
                       accountsTitle:@"SOCIAL ACCOUNTS"
                  accountsTitleColor:[UIColor whiteColor]
                       accountsColor:[UIColor colorWithRed:34.0/255.0 green:119.0/255.0 blue:212.0/255.0 alpha:255.0/255.0]
                                info:infos
                           infoTitle:@"INFO"
                      infoTitleColor:[UIColor whiteColor]
                           infoColor:[UIColor colorWithRed:34.0/255.0 green:119.0/255.0 blue:212.0/255.0 alpha:255.0/255.0]];
    
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

- (void)viewDidAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO
                                            withAnimation:UIStatusBarAnimationSlide];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

#pragma mark - FOR TEST



@end
