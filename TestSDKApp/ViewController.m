//
//  ViewController.m
//  TestSDKApp
//
//  Created by PrintIO on 12/13/13.
//  Copyright (c) 2013 TestSDKApp. All rights reserved.
//

#import "ViewController.h"
#import <PrintIO/PIOSideMenuButton.h>
#import <PrintIO/PIOVariantOption.h>
#import "VCVariantsOptions.h"

@interface ViewController ()

@property (nonatomic, strong) PrintIO *printIO;

@property (nonatomic, strong) NSDictionary *userData;

@end

@implementation ViewController

- (IBAction)onClickTestSDK:(id)sender
{
    // Yellowlab-500px
    if (self.switchYellowLab500px.isOn){
        [self testYellowlab500px];
        return;
    }
    
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
        [self testMGPath2:2];
        return;
    }
    
    // MG Path 1
    if (self.switchMirrorgram.isOn){
        [self testMirrorgram:1];
        return;
    }
        
    // Navigation bar
    [self.printIO navigationBarColor:self.switchTitleBarColor.isOn ? [UIColor colorWithRed:59.0/255.0 green:89.0/255.0 blue:152.0/255.0 alpha:1.0] : [UIColor whiteColor]
                          titleColor:self.switchTitleBarColor.isOn ? [UIColor whiteColor] : [UIColor blackColor]
           leftButtonBackgroundColor:nil
          rightButtonBackgroundColor:nil
                     titleButtonIcon:self.switchBtnInNavBar.isOn ? [[NSBundle mainBundle] pathForResource:@"icon1" ofType:@"png"] : nil];
    [self.printIO iconForShoppingCart:[[NSBundle mainBundle]pathForResource:@"pb_icon_cart_black" ofType:@"png" ]
                 withNumberOfProducts:YES labelPosition:CGPointZero textColor:[UIColor whiteColor]];
    
    // Photo Sources
    NSMutableArray *photoSources = [[NSMutableArray alloc]init];
    
    if (self.switchPSPhone.isOn){
        [photoSources addObject:[[PIOSideMenuButton alloc]initWithType:PIO_SM_PHONE]];
    }
    
    if (self.switchPSInstagram.isOn){
        [photoSources addObject:[[PIOSideMenuButton alloc]initWithType:PIO_SM_INSTAGRAM]];
    }
    
    if (self.switchPSFacebook.isOn){
        [photoSources addObject:[[PIOSideMenuButton alloc]initWithType:PIO_SM_FACEBOOK]];
    }
    
    if (self.switchPSFlickr.isOn){
        [photoSources addObject:[[PIOSideMenuButton alloc]initWithType:PIO_SM_FLICKR]];
    }
    
    if (self.switchPSPicasa.isOn){
        [photoSources addObject:[[PIOSideMenuButton alloc]initWithType:PIO_SM_PICASA]];
    }

    if (self.switchPSDropbox.isOn){
        [photoSources addObject:[[PIOSideMenuButton alloc]initWithType:PIO_SM_DROPBOX]];
    }
    
    if (self.switchPSPhotobucket.isOn){
        [photoSources addObject:[[PIOSideMenuButton alloc]initWithType:PIO_SM_PHOTOBUCKET]];
    }
    
    [self.printIO availablePhotoSources:photoSources];
    
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
    if (self.switchCustomization.isOn){
        [self.printIO customizationXML:xmlData];
        [self.printIO changeLogo:@"icon1"];
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
        [self.printIO useSideMenuWithMenuIcon:[[NSBundle mainBundle]pathForResource:@"pb_menu" ofType:@"png"] background:nil];
        
        // Set options for Side Menu
        NSArray *buttons = [NSArray arrayWithObjects:
                            [[PIOSideMenuButton alloc]initWithType:PIO_SM_SEARCH_BAR],
                            [[PIOSideMenuButton alloc]initWithType:PIO_SM_EXIT_BUTTON],
                            [[PIOSideMenuButton alloc]initWithType:PIO_SM_PRODUCTS],
                            [[PIOSideMenuButton alloc]initWithType:PIO_SM_FEATURED_PRODUCTS],
                            [[PIOSideMenuButton alloc]initWithType:PIO_SM_VIEW_CART], nil];
        
        NSArray *options = [NSArray arrayWithObjects:
                            [[PIOSideMenuButton alloc]initWithType:PIO_SM_CHANGE_CURRENCY],
                            [[PIOSideMenuButton alloc]initWithType:PIO_SM_CHANGE_COUNTRY],
                            [[PIOSideMenuButton alloc]initWithType:PIO_SM_CHANGE_LANGUAGE], nil];
        
        NSArray *infos = [NSArray arrayWithObjects:
                          [[PIOSideMenuButton alloc]initWithType:PIO_SM_PRICING_CHART],
                          [[PIOSideMenuButton alloc]initWithType:PIO_SM_SHARE_APP],
                          [[PIOSideMenuButton alloc]initWithType:PIO_SM_LIKE_US_FB],
                          [[PIOSideMenuButton alloc]initWithType:PIO_SM_RATE_APP],
                          [[PIOSideMenuButton alloc]initWithType:PIO_SM_ABOUT],
                          [[PIOSideMenuButton alloc]initWithType:PIO_SM_HOW_IT_WORKS],
                          [[PIOSideMenuButton alloc]initWithType:PIO_SM_PAST_ORDERS], nil];
        
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
                               infoColor:[UIColor colorWithRed:100.0/255.0 green:106.0/255.0 blue:166.0/255.0 alpha:255.0/255.0]
               backgroundImageForButtons:nil];
    }
    
    // Slide Side Menu from right
    if (self.swSlideSideMenuFromRight.isOn){
        [self.printIO slideSideMenuFromRight:YES];
    }
    
    // Custom share text. Will be used form side menu button.
    if (self.switchCustomShareText.isOn){
        [self.printIO setShareText:@"Example share app text with link http://www.google.com"];
    }
    
    // Show custom double tap screen when customizing product
    if (self.switchCustomDoubleTapScreen.isOn){
        [self.printIO showHelpDialogWithImage:[[NSBundle mainBundle] pathForResource:@"touch" ofType:@"png"]];
    }
    
    // Show/hide tab bar in Customization Screen
    [self.printIO showToolbarInCustomizeProduct:self.switchShowTabBarInCustomizationScreen.isOn backgroundImage:nil];
    
    // Hide image list in Customize Product screen
    if (self.switchHideImagesListInCustomization.isOn){
        [self.printIO hideImagesListInCustomizeProduct:YES];
    }
    
    // Pass photos in SDK
    if (self.switchPassPhotosInSDK.isOn){
        [self.printIO images:images];
    }
    
    // Disable photo sources when photos are passed
    if (self.switchDisablePSWhenPhotosArePassed.isOn){
        [self.printIO disablePhotoSourcesWhenImagesArePassedIn:YES];
    }
    
    // Disable photo sources when photo is passed in SDK for one photo template
    if (self.switchDisablePSWhenPhotoIsPassedForOnePhototemplate.isOn){
        [self.printIO disablePhotoSourcesForOnePhotoTemplate:YES];
    }
    
    // Use passed image as thumbnail for one phtoo template
    if (self.switchUsePassedImageAsThumbForOnePhotoTemplate.isOn){
        [self.printIO setPassedImageAsThumbForOnePhotoTemplate:YES];
    }
    
    // Hide Category/Search view in Featured Products screen
    if (self.hideCategoriesView.isOn){
        [self.printIO hideCategoriesInFeaturedProducts:YES];
    }
    
    // Hide status bar
    if (self.switchHideStatusBar.isOn){
        [self.printIO statusBarDark:NO hidden:YES];
    } else {
        [self.printIO statusBarDark:YES hidden:NO];
    }
    
    // Set country in featured products
    if (self.switchSetCountryInFProducts.isOn){
        [self.printIO selectCountryInFeaturedProducts:YES backgroundColor:nil];
    }
    
    // Change loading GIF animation
    if (self.switchCustomGIF.isOn){
        [self.printIO setLoadingGIF:@"load"];
    }
    
    // Photo Arrangement option
    if (self.switchPhotoArrangement.isOn){
        [self.printIO setPhotoArrangement:PIO_PHOTO_ARRANGEMENT_AUTO];
    }
    
    [self.printIO removePlusFromAddMoreProductsButton:YES];
    
    // Variants options test
    if (self.switchTestVariantsOptions.isOn){
        NSLog(@"all_values: %@", [self.userData allValues]);
        [self.printIO setVariantsOptions:[NSArray arrayWithArray:[self.userData allValues]]];
        
        // TEST  !!!!!!!!!!!!!
        //[self.printIO goToProductId:PRODUCT_THROW_PILLOWS()];
        
        // Count = 36
        PIOVariantOption *p1 = [[PIOVariantOption alloc]initWithProductId:PRODUCT_THROW_PILLOWS()
                                                                 optionId:@"bf375e734bfc4b28b9a79b3511ec331a"
                                                                  valueId:@"5a12312691fd42788a7bdfe295447122"];
        //p1.color = [UIColor redColor];
        
        // 3x3 inch
        PIOVariantOption *p2 = [[PIOVariantOption alloc]initWithProductId:PRODUCT_THROW_PILLOWS()
                                                                 optionId:@"677d9d4c10a74e4d8f30b4d104b61681"
                                                                  valueId:@"46d2cdbfed6547e385ba9ff56b405c72"];
        
        //[self.printIO setVariantsOptions:[NSArray arrayWithObjects:p1, p2, nil]];
        
    }
    
    // Jump to shoping cart
    if (self.swJumpToShopingCart.isOn){
        [self.printIO goToScreen:PRINTIO_SCREEN_SHOPING_CART];
    }
    
    // Show terms of service
    if (self.swShowTermsOfService.isOn){
        [self.printIO termsAndConditionsURL:[NSURL URLWithString:@"http://www.wikihow.com/images/sampledocs/9/Terms-and-Conditions.txt"]];
    }
    
    // Side Menu Options
    if (self.swSideMenuShowOptionsAsAList.isOn){
        [self.printIO sideMenuShowOptionsAsList:YES];
    }
    
    if (self.swSideMenuHideAccountsHeader.isOn){
        [self.printIO sideMenuHideAccountsHeader:YES];
    }
    
    if (self.swSideMenuHideInfoHeader.isOn){
        [self.printIO sideMenuHideInfoHeader:YES];
    }
    
    if (self.swSideMenuHideOptionsHeader.isOn){
        [self.printIO sideMenuHideOptionsHeader:YES];
    }
    
    if (self.swHidePhotoSourcesInSideMenu.isOn){
        [self.printIO hidePhotoSourcesInSideMenu:YES];
    }
    
    // Open widget
    [self.printIO openWithOption:self.switchPresentViewFromRight.isOn ? PRINTIO_OPTION_PRESENT_VIEW_FROM_RIGHT : PRINTIO_OPTION_PRESENT_VIEW_FROM_BOTTOM];
    
    NSLog(@"widget starting");
}

- (IBAction)onClickTestVariantsOptions:(id)sender
{
    VCVariantsOptions *vc = [[VCVariantsOptions alloc]init];
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

- (void)onVariantsOptionsSelected:(NSNotification *)notification
{
    self.userData = [notification userInfo];
    NSLog(@"self.userData: %@", self.userData);
}

#pragma mark - Settings for partners

- (void)testYellowlab500px
{
    [self.printIO removeLogoFromPaymentScreen:YES];
    [self.printIO removePlusFromAddMoreProductsButton:YES];
    
    [self.printIO availablePhotoSources:[NSArray arrayWithObjects:[[PIOSideMenuButton alloc]initWithType:PIO_SM_PHONE],[[PIOSideMenuButton alloc]initWithType:PIO_SM_INSTAGRAM], [[PIOSideMenuButton alloc]initWithType:PIO_SM_FACEBOOK], nil]];
    
    
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
                           infoColor:[UIColor colorWithRed:100.0/255.0 green:106.0/255.0 blue:166.0/255.0 alpha:255.0/255.0]backgroundImageForButtons:nil];
    
    [self.printIO termsAndConditionsURL:[NSURL URLWithString:@"http://www.wikihow.com/images/sampledocs/9/Terms-and-Conditions.txt"]];
    
    [self.printIO open];
}

- (void)testMGPath3
{
    [self testMGPath2:3];
}

- (void)testMGPath2:(int)path
{
    // Pass in one image
    UIImage *image1 = [UIImage imageNamed:@"dream.jpg"];
    NSArray *images = [NSArray arrayWithObjects:image1, nil];
    [self.printIO images:images];
    
    [self testMirrorgram:path];
}

- (void)testMirrorgram:(int)path
{
    UIColor *mgOrange = [UIColor colorWithRed:240.0/255.0 green:94.0/255.0 blue:79.0/255.0 alpha:1.0];
    UIColor *mgGreen = [UIColor colorWithRed:0.0/255.0 green:197.0/255.0 blue:204.0/255.0 alpha:1.0];
    UIColor *mgGrey = [UIColor colorWithRed:136.0/255.0 green:136.0/255.0 blue:136.0/255.0 alpha:1.0];
    
    // TO-DO Production mode switch also
    
    [self.printIO useSideMenuWithMenuIcon:[[NSBundle mainBundle]pathForResource:@"mg_icon_menu" ofType:@"png"] background:nil];
    
    // Available Photo sources
    PIOSideMenuButton *btnSInstagram = [[PIOSideMenuButton alloc]initWithType:PIO_SM_INSTAGRAM];
    btnSInstagram.iconPath = [[NSBundle mainBundle]pathForResource:@"s_instagram" ofType:@"png"];
    btnSInstagram.iconPathSelected = [[NSBundle mainBundle]pathForResource:@"s_instagram" ofType:@"png"];
    btnSInstagram.textColor = [UIColor blackColor];
    btnSInstagram.useBoldFonts = YES;
    
    PIOSideMenuButton *btnSPhone = [[PIOSideMenuButton alloc]initWithType:PIO_SM_PHONE];
    
    PIOSideMenuButton *btnSFacebook = [[PIOSideMenuButton alloc]initWithType:PIO_SM_FACEBOOK];
    btnSFacebook.iconPath = [[NSBundle mainBundle]pathForResource:@"s_facebook" ofType:@"png"];
    btnSFacebook.iconPathSelected = [[NSBundle mainBundle]pathForResource:@"s_facebook" ofType:@"png"];
    btnSFacebook.textColor = [UIColor blackColor];
    btnSFacebook.useBoldFonts = YES;
    
    [self.printIO availablePhotoSources:[NSArray arrayWithObjects:btnSPhone, btnSInstagram, btnSFacebook, nil]];
    
    // Set main buttons for Side Menu
    PIOSideMenuButton *btnCamera = [[PIOSideMenuButton alloc]initWithTitle:@" GO TO IMAGE MODE"
                                                                      type:PIO_SM_EXIT_BUTTON
                                                                  iconPath:[[NSBundle mainBundle] pathForResource:@"s_btn_camera" ofType:@"png"]];
    btnCamera.fontSize = 15.0;
    btnCamera.textColor = [UIColor blackColor];
    btnCamera.useBoldFonts = YES;
    
    PIOSideMenuButton *btnProducts = [[PIOSideMenuButton alloc]initWithTitle:@"ALL PRODUCTS"
                                                                        type:PIO_SM_PRODUCTS
                                                                    iconPath:[[NSBundle mainBundle] pathForResource:@"s_btn_products" ofType:@"png"]];
    btnProducts.fontSize = 15.0;
    btnProducts.textColor = [UIColor blackColor];
    btnProducts.useBoldFonts = YES;
    
    PIOSideMenuButton *btnViewCart = [[PIOSideMenuButton alloc]initWithTitle:@"MY CART"
                                                                        type:PIO_SM_VIEW_CART
                                                                    iconPath:[[NSBundle mainBundle] pathForResource:@"s_btn_cart" ofType:@"png"]];
    btnViewCart.textColor = [UIColor blackColor];
    btnViewCart.fontSize = 15.0;
    btnViewCart.useBoldFonts = YES;
    
    PIOSideMenuButton *btnEmailSupport = [[PIOSideMenuButton alloc]initWithTitle:@"EMAIL ORDER SUPPORT"
                                                                            type:PIO_SM_EMAIL_SUPPORT
                                                                        iconPath:[[NSBundle mainBundle] pathForResource:@"s_btn_email_support" ofType:@"png"]];
    btnEmailSupport.dataHolder = @"orders@entersparkmode.com";
    btnEmailSupport.textColor = [UIColor blackColor];
    btnEmailSupport.fontSize = 15.0;
    btnEmailSupport.useBoldFonts = YES;
    
    NSArray *buttons;
    
    if (self.SwitchMGPath2.isOn){
        PIOSideMenuButton *btnShareWithImage = [[PIOSideMenuButton alloc]initWithTitle:@"             SHARE"
                                                                                  type:PIO_SM_SHARE_WITH_IMAGE
                                                                              iconPath:[[NSBundle mainBundle] pathForResource:@"s_share" ofType:@"png"]];
        btnShareWithImage.textColor = [UIColor blackColor];
        btnShareWithImage.fontSize = 15.0;
        btnShareWithImage.useBoldFonts = YES;
        
        buttons = [NSArray arrayWithObjects:btnCamera, btnShareWithImage, btnProducts, btnViewCart, btnEmailSupport, nil];
    } else {
        buttons = [NSArray arrayWithObjects:btnCamera, btnProducts, btnViewCart, btnEmailSupport, nil];
    }
    
    btnViewCart.textColor = [UIColor blackColor];
    btnViewCart.fontSize = 15.0;
    
    // Options
    PIOSideMenuButton *btnChangeCurrency = [[PIOSideMenuButton alloc]initWithTitle:@"CHANGE CURRENCY"
                                                                              type:PIO_SM_CHANGE_CURRENCY
                                                                          iconPath:nil];
    btnChangeCurrency.fontSize = 12.0;
    btnChangeCurrency.textColor = [UIColor blackColor];
    btnChangeCurrency.textSecondColor = mgGrey;
    btnChangeCurrency.useBoldFonts = YES;
    
    PIOSideMenuButton *btnChangeCountry = [[PIOSideMenuButton alloc]initWithTitle:@"CHANGE COUNTRY"
                                                                             type:PIO_SM_CHANGE_COUNTRY
                                                                         iconPath:nil];
    btnChangeCountry.fontSize = 12.0;
    btnChangeCountry.textColor = [UIColor blackColor];
    btnChangeCountry.useBoldFonts = YES;
    
    PIOSideMenuButton *btnChangeLanguage = [[PIOSideMenuButton alloc]initWithTitle:@"CHANGE LANGUAGE"
                                                                              type:PIO_SM_CHANGE_LANGUAGE
                                                                          iconPath:[[NSBundle mainBundle] pathForResource:@"s_icon_language" ofType:@"png"]];
    btnChangeLanguage.fontSize = 12.0;
    btnChangeLanguage.textColor = [UIColor blackColor];
    btnChangeLanguage.useBoldFonts = YES;
    
    NSArray *options = [NSArray arrayWithObjects:btnChangeCurrency, btnChangeCountry, btnChangeLanguage, nil];
    
    // Infos
    PIOSideMenuButton *btnHowItWorks = [[PIOSideMenuButton alloc]initWithTitle:@"HOW IT WORKS"
                                                                          type:PIO_SM_HOW_IT_WORKS
                                                                      iconPath:[[NSBundle mainBundle] pathForResource:@"s_btn_info" ofType:@"png"]];
    btnHowItWorks.textColor = [UIColor blackColor];
    btnHowItWorks.fontSize = 15.0;
    btnHowItWorks.useBoldFonts = YES;
    
    NSArray *infos = [NSArray arrayWithObjects:btnHowItWorks, nil];
    
    [self.printIO sideMenuAddButtons:buttons
     
                             options:options
                        optionsTitle:@"OPTIONS"
                   optionsTitleColor:[UIColor whiteColor]
                        optionsColor:mgGrey
     
                       accountsTitle:@"SOCIAL ACCOUNTS"
                  accountsTitleColor:[UIColor whiteColor]
                       accountsColor:mgGrey
     
                                info:infos
                           infoTitle:@"INFO"
                      infoTitleColor:[UIColor whiteColor]
                           infoColor:mgGrey
     
           backgroundImageForButtons:[[NSBundle mainBundle]pathForResource:@"s_bcg" ofType:@"png"]];
    
    // Hide tab bar in Customize Product screen
    [self.printIO showToolbarInCustomizeProduct:NO
                                backgroundImage:[[NSBundle mainBundle]pathForResource:@"mg_toolbar_bcg" ofType:@"png"]];
    
    // Set visible buttons in Image Editor
    [self.printIO imageEditorShowButtons:[NSArray arrayWithObjects:
                                          [[PIOButton alloc]initWithType:PIO_BUTTON_IMAGE_EDITOR_INFO], nil]];
    
    // Customize Navigation bar
    [self.printIO navigationBarColor:[UIColor colorWithRed:240.0/255.0 green:94.0/255.0 blue:79.0/255.0 alpha:1.0]
                          titleColor:[UIColor whiteColor]
           leftButtonBackgroundColor:[UIColor clearColor]
          rightButtonBackgroundColor:[UIColor colorWithRed:34.0/255.0 green:119.0/255.0 blue:212.0/255.0 alpha:1.0]
                     titleButtonIcon:nil];
    
    // Change shoping cart icon
    [self.printIO iconForShoppingCart:[[NSBundle mainBundle]pathForResource:@"mg_cart_new" ofType:@"png"] withNumberOfProducts:YES labelPosition:CGPointZero textColor:[UIColor whiteColor]];
    
    [self.printIO extraData:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithInt:1], ED_PARTNERS_ID,
                             [NSNumber numberWithInt:path], ED_MG_PATH_NUMBER, nil]];
    
    [self.printIO payeeName:@"Mirrorgram"];
    
    [self.printIO setPassedImageAsThumbForOnePhotoTemplate:YES];
    
    // Set custom icon
    [self.printIO changeLogo:@"mg_s_logo"];
    
    [self.printIO hideCategoriesInFeaturedProducts:YES];
    
    [self.printIO statusBarDark:NO hidden:YES];
    
    [self.printIO iconForHelpButtonInCustomizeProduct:[[NSBundle mainBundle]pathForResource:@"mg_icon_question_mark" ofType:@"png"]];
    [self.printIO iconForAddPhotosButton:[[NSBundle mainBundle]pathForResource:@"mg_add_photos" ofType:@"png"]];
    
    [self.printIO selectCountryInFeaturedProducts:YES backgroundColor:mgGreen];
    
    [self.printIO iconForBackButton:[[NSBundle mainBundle]pathForResource:@"mg_back_new_spark" ofType:@"png"]];
    
    // Path to XML customization file
    NSString *xmlPath = [[NSBundle mainBundle] pathForResource:@"customization_mg" ofType:@"xml"];
    NSData *xmlData = [NSData dataWithContentsOfFile:xmlPath];
    [self.printIO customizationXML:xmlData];
        
    [self.printIO setPopUpWithImage:[[NSBundle mainBundle]pathForResource:@"mg_double_tap_balloon" ofType:@"png"]
                               text:@"Double tap photo to edit"
                          textColor:[UIColor whiteColor]];
    
    [self.printIO removePlusFromAddMoreProductsButton:YES];
    
    [self.printIO termsAndConditionsURL:[NSURL URLWithString:@"http://www.wikihow.com/images/sampledocs/9/Terms-and-Conditions.txt"]];
    
    [self.printIO setTitleForFeaturedProductsScreen:@"ALL PRODUCTS"];
    [self.printIO setTitleForShoppingCart:@"MY SHOPPING CART"];
    [self.printIO setTitleForOrderCompletedScreen:@"ORDER COMPLETED"];
    [self.printIO setTitleForChooseOptionsScreen:@"CHOOSE OPTIONS"];
    [self.printIO setTitleForPhotoSourcesScreen:@"SELECT IMAGES"];
    [self.printIO setTitleForChooseCountryScreen:@"CHOOSE COUNTRY"];
    
    [self.printIO featuredProductsLeftLabelTextColor:nil rightLabelTextColor:mgOrange];
    [self.printIO navigationBarSaveToCartBackgroundColor:mgGrey
                                              titleColor:[UIColor whiteColor]
                                   buttonBackgroundColor:mgOrange
                                        buttonTitleColor:[UIColor whiteColor]];
    
    [self.printIO featuredProductsSetBackgroundImage:[[NSBundle mainBundle] pathForResource:@"mg_bcg" ofType:@"png"]];
    [self.printIO doubleTapBalloonVisibilityTime:-1];
    [self.printIO showPlusSignOnAddButton:YES];
    
    [self.printIO orderCompletedScreenCloseButtonShouldPerformBack:YES];
    [self.printIO setIconForOrderCompletedScreen:[[NSBundle mainBundle] pathForResource:@"mg_s_logo" ofType:@"png"]];
    
    // Set attributed company message
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc]initWithString:@"Thank you for creating in  "];
    
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = [UIImage imageNamed:@"mg_watermark"];
    
    NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [attrString replaceCharactersInRange:NSMakeRange(26, 1) withAttributedString:attrStringWithImage];
    
    [self.printIO setMessageForOrderCompletedScreen:attrString];
    [self.printIO productDetailsShowTitleBelowNavBar:YES];
    [self.printIO productDetailsShowMenuBtnInNavBar:YES];
    
    [self.printIO setLoadingGIF:@"mg_loader"];
    [self.printIO hideSearchIconInChooseCountryScreen:YES];
    [self.printIO customizeAddMoreProductButton:@"MAKE MORE PRODUCTS" icon:[[NSBundle mainBundle]pathForResource:@"mg_add_more_products" ofType:@"png"]];
    [self.printIO shoppingCartBackButtonIcon:[[NSBundle mainBundle]pathForResource:@"mg_all_products" ofType:@"png"]];
    
    [self.printIO setNavigationBarBackgroundColorForChooseCountryScreen:mgGreen];
    [self.printIO setPlaceholderTextForSearchBarInChooseCountryScreen:@"  " hideMagnifyingGlass:YES];
    
    // START WIDGET
    [self.printIO open];
}

- (void)testPhotobucket
{
    [self.printIO showToolbarInCustomizeProduct:YES backgroundImage:nil];
    [self.printIO navigationBarColor:[UIColor whiteColor]
                          titleColor:[UIColor blackColor]
           leftButtonBackgroundColor:nil
          rightButtonBackgroundColor:nil
                     titleButtonIcon:nil];
    [self.printIO payeeName:@"Photobucket"];
    [self.printIO selectCountryInFeaturedProducts:YES backgroundColor:nil];
    [self.printIO iconForShoppingCart:[[NSBundle mainBundle]pathForResource:@"pb_icon_cart_black" ofType:@"png"]
                 withNumberOfProducts:YES labelPosition:CGPointZero textColor:[UIColor whiteColor]];
    [self.printIO iconForBackButton:[[NSBundle mainBundle]pathForResource:@"pb_back" ofType:@"png"]];
    [self.printIO useSideMenuWithMenuIcon:[[NSBundle mainBundle]pathForResource:@"pb_menu_a" ofType:@"png"]
                               background:[UIColor colorWithRed:227.0/255.0 green:227.0/255.0 blue:225.0/255.0 alpha:1.0]];
    [self.printIO statusBarDark:YES hidden:YES];
    [self.printIO extraData:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithInt:2], ED_PARTNERS_ID, nil]];
    [self.printIO changeLogo:@""];
    [self.printIO removeLogoFromPaymentScreen:YES];
    [self.printIO removePlusFromAddMoreProductsButton:YES];
    
    // Available Photo sources
    NSMutableArray *photoSources = [[NSMutableArray alloc]init];
    [photoSources addObject:[[PIOSideMenuButton alloc]initWithType:PIO_SM_PHONE]];
    [photoSources addObject:[[PIOSideMenuButton alloc]initWithType:PIO_SM_INSTAGRAM]];
    [photoSources addObject:[[PIOSideMenuButton alloc]initWithType:PIO_SM_FACEBOOK]];
    [photoSources addObject:[[PIOSideMenuButton alloc]initWithType:PIO_SM_FLICKR]];
    [photoSources addObject:[[PIOSideMenuButton alloc]initWithType:PIO_SM_PHOTOBUCKET]];
    
    [self.printIO availablePhotoSources:photoSources];
    
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
                           infoColor:[UIColor colorWithRed:34.0/255.0 green:119.0/255.0 blue:212.0/255.0 alpha:255.0/255.0] backgroundImageForButtons:[[NSBundle mainBundle]pathForResource:@"pb_bcg" ofType:@"png"]];
    
    [self.printIO termsAndConditionsURL:[NSURL URLWithString:@"http://www.wikihow.com/images/sampledocs/9/Terms-and-Conditions.txt"]];
    
    [self.printIO slideSideMenuFromRight:YES];
    [self.printIO useThreeButtonsBarStyle:YES];
    
    [self.printIO open];
}

#pragma mark - PrintIO Delegate

- (void)PrintIOWidgetOnOpen
{
    NSLog(@"PrintIOWidgetOnOpen");
}

- (void)PrintIOWidgetOnCloseWithData:(NSDictionary *)data
{
    NSLog(@"data: %@", data);
    _printIO = nil;
}

#pragma mark - Init

- (void)dummyStart
{
    [self.printIO open];
}

- (PrintIO *)printIO
{
    if (!_printIO){
        
        // Init HelloPics widget
        BOOL isProduction = self.switchProduction.isOn;
        
        _printIO = [[PrintIO alloc]initWithViewController:self
                                              environment:isProduction ? PRINTIO_PRODUCTION : PRINTIO_STAGING
                                       productionRecipeId:@"f255af6f-9614-4fe2-aa8b-1b77b936d9d6"
                                          stagingRecipeId:@"00000000-0000-0000-0000-000000000000"];
        // Set Delegate
        [_printIO setDelegate:self];
    }
    return _printIO;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.scrollView addSubview:self.panelView];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.panelView.frame.size.height);
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(onVariantsOptionsSelected:)
                                                name:NOTIF_VARIANTS_SELECTED object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

@end
