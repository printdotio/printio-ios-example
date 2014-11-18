//
//  ViewController.m
//  TestSDKApp
//
//  Created by PrintIO on 12/13/13.
//  Copyright (c) 2013 TestSDKApp. All rights reserved.
//

#import "ViewController.h"
#import <PrintIO/PrintIO.h>
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
    // Navigation bar
    [self.printIO navigationBarColor:self.switchTitleBarColor.isOn ? [UIColor colorWithRed:59.0/255.0 green:89.0/255.0 blue:152.0/255.0 alpha:1.0] : [UIColor whiteColor]
                          titleColor:self.switchTitleBarColor.isOn ? [UIColor whiteColor] : [UIColor blackColor]
           leftButtonBackgroundColor:nil
          rightButtonBackgroundColor:nil
                     titleButtonIcon:self.switchBtnInNavBar.isOn ? [[NSBundle mainBundle] pathForResource:@"icon1" ofType:@"png"] : nil];
    
    [self.printIO setIconForShoppingCart:[[NSBundle mainBundle]pathForResource:@"pb_icon_cart_black" ofType:@"png" ]
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
    
    [self.printIO setAvailablePhotoSources:photoSources];
    
    UIImage *image1 = [UIImage imageNamed:@"dream.jpg"];
    //UIImage *image2 = [UIImage imageNamed:@"thunder.jpg"];
    
    NSArray *images = [NSArray arrayWithObjects:image1, nil];
    
    //@"http://res.cloudinary.com/demo/image/upload/sample.jpg",
    //@"http://photographylife.com/wp-content/uploads/2012/10/Nikon-D600-Sample-11.jpg",
    //@"http://www.digitaltrends.com/wp-content/uploads/2013/03/vertu-constellation-review-sample-image-flowers.jpg",
    
    // Set customization file
    if (self.switchCustomization.isOn){
        // Path to XML customization file
        NSString *xmlPath = [[NSBundle mainBundle] pathForResource:@"customization"
                                                            ofType:@"xml"];
        NSData *xmlData = [NSData dataWithContentsOfFile:xmlPath];
        
        [self.printIO setCustomizationXML:xmlData];
        [self.printIO setLogoFileName:@"icon1"];
    }
    
    // Set country code
    if (self.switchCountryCode.isOn){
        [self.printIO setCountryCode:@"US"];
    }
    
    // Set currency code
    if (self.switchCurrencyCode.isOn){
        [self.printIO setCurrencyCode:@"USD"];
    }
    
    // Set language code
    if (self.switchLanguageCode.isOn){
        [self.printIO setLanguageCode:@"en"];
    }
    
    // Set custom fonts
    if (self.switchCustomFonts.isOn){
        NSArray *fonts = @[@"timess.ttf", @"timess.ttf",
                           @"aubrey.ttf", @"CaviarDreams_Bold.ttf"];
        [self.printIO setFonts:fonts];
    }
    
    // Set Payee name
    if (self.txtPayeeName.text){
        [self.printIO setPayeeName:self.txtPayeeName.text];
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
        
        PIOSideMenuButton *pioSmHelp =  [[PIOSideMenuButton alloc]initWithType:PIO_SM_HELP];
        pioSmHelp.dataHolder  = @"http://www.google.com";
        
        // Set options for Side Menu
        NSArray *buttons = [NSArray arrayWithObjects:
                            [[PIOSideMenuButton alloc]initWithType:PIO_SM_SEARCH_BAR],
                            [[PIOSideMenuButton alloc]initWithType:PIO_SM_EXIT_BUTTON],
                            [[PIOSideMenuButton alloc]initWithType:PIO_SM_PRODUCTS],
                            [[PIOSideMenuButton alloc]initWithType:PIO_SM_FEATURED_PRODUCTS],
                            [[PIOSideMenuButton alloc]initWithType:PIO_SM_VIEW_CART],
                            pioSmHelp, nil];
        
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
        [self.printIO setShareText:@"Example share app text with link http://www.google.com" additionalText:@"@PrintIO"];
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
        [self.printIO setImages:images];
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
        [self.printIO setStatusBarDark:NO hidden:YES];
    } else {
        [self.printIO setStatusBarDark:YES hidden:NO];
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
        //        [self.printIO goToProductId:PRODUCT_THROW_PILLOWS()];
        //        [self.printIO setSamePhotoOnFrontAndBackSideOfProduct:PRODUCT_THROW_PILLOWS()];
        //        [self.printIO autoSelectOnePhotoTemplateForProductID:PRODUCT_THROW_PILLOWS()];
        
        // Count = 36
        PIOVariantOption *p1 = [[PIOVariantOption alloc]initWithProductId:PRODUCT_THROW_PILLOWS()
                                                                 optionId:@"bf375e734bfc4b28b9a79b3511ec331a"
                                                                  valueId:@"5a12312691fd42788a7bdfe295447122"];
        //p1.color = [UIColor redColor];
        
        // 3x3 inch
        PIOVariantOption *p2 = [[PIOVariantOption alloc]initWithProductId:PRODUCT_THROW_PILLOWS()
                                                                 optionId:@"677d9d4c10a74e4d8f30b4d104b61681"
                                                                  valueId:@"46d2cdbfed6547e385ba9ff56b405c72"];
        
        [self.printIO setVariantsOptions:[NSArray arrayWithObjects:p1, p2, nil]];
        
    }

    // Show terms of service
    if (self.swShowTermsOfService.isOn){
        [self.printIO setTermsAndConditionsURL:[NSURL URLWithString:@"http://www.wikihow.com/images/sampledocs/9/Terms-and-Conditions.txt"]];
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
    
    if (self.swPositiveButtons.isOn){
        [self.printIO setPositiveButtonsBackgroundColor:[UIColor blueColor]
                                             titleColor:[UIColor whiteColor]];
    }
    
    if (self.swNegativeButtons.isOn){
        [self.printIO setNegativeButtonsBackgroundColor:[UIColor redColor]
                                             titleColor:[UIColor whiteColor]];
    }
    
    if (self.swDisablePreviewScreen.isOn){
        [self.printIO disablePreviewScreen:YES];
    }
    
    [self.printIO setNavigationBarSaveToCartBackgroundColor:nil
                                                 titleColor:[UIColor whiteColor] // 'Next' button title color
                                      buttonBackgroundColor:nil
                                           buttonTitleColor:[UIColor whiteColor]]; // 'Save to' button
    
    [self.printIO setIconForSaveButtonInCustomizeProduct:[[NSBundle mainBundle]pathForResource:@"icon_cart_white" ofType:@"png"]];
    
    if (self.txtPromoCode.text.length){
        [self.printIO setPromoCode:self.txtPromoCode.text];
    }
        
    // Open widget
    [self.printIO openWithOption:self.switchPresentViewFromRight.isOn ? PRINTIO_OPTION_PRESENT_VIEW_FROM_RIGHT : PRINTIO_OPTION_PRESENT_VIEW_FROM_BOTTOM];
    
    NSLog(@"widget starting");
}

- (IBAction)onClickTestVariantsOptions:(id)sender
{
    //VCVariantsOptions *vc = [[VCVariantsOptions alloc]init];
    //[self.navigationController presentViewController:vc animated:YES completion:nil];
    [self.printIO open];
}

- (void)onVariantsOptionsSelected:(NSNotification *)notification
{
    self.userData = [notification userInfo];
    NSLog(@"self.userData: %@", self.userData);
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

        //UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
        _printIO = [[PrintIO alloc]initWithViewController:self
                                              environment:isProduction ? PRINTIO_PRODUCTION : PRINTIO_STAGING
//                                                           productionRecipeId:@"46f999dd-814d-428f-b0ff-47954b4181b2"
//                                                              stagingRecipeId:@"7b4e12e3-c60f-47ed-bf75-ce848726cfcc"];
                                       productionRecipeId:@"f255af6f-9614-4fe2-aa8b-1b77b936d9d6"
                                       //productionRecipeId:@"07e3e00a-8e84-4e0b-bd6f-a80c877b8428"
                                          stagingRecipeId:@"00000000-0000-0000-0000-000000000000"];
        
        // Set Delegate
        [_printIO setDelegate:self];
    }
    return _printIO;
}

#pragma mark - View Lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(onVariantsOptionsSelected:)
                                                name:NOTIF_VARIANTS_SELECTED object:nil];
}

- (void)viewDidLayoutSubviews
{
    CGRect panelRect = self.panelView.frame;
    panelRect.size.width = self.scrollView.frame.size.width;
    self.panelView.frame = panelRect;
    
    [self.scrollView addSubview:self.panelView];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.panelView.frame.size.height);
    
    [super viewDidLayoutSubviews];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIF_VARIANTS_SELECTED object:nil];
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
