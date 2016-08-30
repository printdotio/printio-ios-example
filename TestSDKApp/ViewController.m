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
#import <AssetsLibrary/AssetsLibrary.h>
#import <PassKit/PassKit.h>
#import "MyPhotoSource.h"
#import <PrintIO/PaymentOptions.h>

@interface ViewController () <GTAnalyticsDelegate>

@property (nonatomic, strong) PrintIO *printIO;

@end

@implementation ViewController

#pragma mark - Anaytics delegate

-(void)gtAnalyticsOnEnterScreen:(GTAnalyticsScreen *)screen{
    //NSLog(@"ANALYTICS SCREEN: %@", screen.name);
}

-(void)gtAnalyticsOnEvent:(GTAnalyticsEvent *)event{
    //NSLog(@"ANALYTICS EVENT: %@ : %@", event.name, event.value);
}

-(void)gtAnalyticsOnTimedEvent:(GTAnalyticsEvent *)event{
    //NSLog(@"ANALYTICS EVENT: %@ : %@", event.name, event.value);
}

-(void)gtAnalyticsOnEndTimedEvent:(GTAnalyticsEvent *)event{
    //NSLog(@"ANALYTICS STOP CAPTURING: %@", event.name);
}

#pragma mark - Initialization code

- (IBAction)tapOnPrintSomething:(id)sender{
    
    if ([self isSwitchON:60]){
        [self.printIO useStagingModeWithRecipeID:@"00000000-0000-0000-0000-000000000000"];
    }
    
    if ([self isSwitchON:61]){
        [self.printIO open];
        return;
    }
    
    // Navigation bar
    [self.printIO navigationBarColor:[self isSwitchON:14] ? [UIColor colorWithRed:59.0/255.0 green:89.0/255.0 blue:152.0/255.0 alpha:1.0] : [UIColor whiteColor]
                          titleColor:[self isSwitchON:14] ? [UIColor whiteColor] : [UIColor blackColor]
           leftButtonBackgroundColor:nil
          rightButtonBackgroundColor:nil
                     titleButtonIcon:nil];
    
    [self.printIO setIconForShoppingCart:[[NSBundle mainBundle]pathForResource:@"pb_icon_cart_black" ofType:@"png" ]
                    withNumberOfProducts:YES labelPosition:CGPointZero textColor:[UIColor whiteColor]];
    
    // Payment options
    int paymentOpts = 0;
    if([self isSwitchON:46]){
        paymentOpts = paymentOpts | PaymentOptionCreditCard;
    }
    
    if([self isSwitchON:47]){
        paymentOpts = paymentOpts | PaymentOptionPayPal;
    }
    
    if ([self isSwitchON:48]){
        paymentOpts = paymentOpts | PaymentOptionApplePay;
        [self.printIO setApplePayMerchantIdentifier:@"merchant.sampleapp"];
    }
    
    [self.printIO setPaymentOptions:paymentOpts];
    
    if ([self isSwitchON:1]){
        [self.printIO setIsInTestMode:YES];
    }
    
    // Photo Sources
    NSMutableArray *photoSources = [[NSMutableArray alloc]init];
    
    if ([self isSwitchON:5]){
        [photoSources addObject:[[PIOSideMenuButton alloc]initWithType:PIO_SM_PHONE]];
    }
    
    if ([self isSwitchON:7]){
        [photoSources addObject:[[PIOSideMenuButton alloc]initWithType:PIO_SM_INSTAGRAM]];
    }
    
    if ([self isSwitchON:6]){
        [photoSources addObject:[[PIOSideMenuButton alloc]initWithType:PIO_SM_FACEBOOK]];
    }
    
    if ([self isSwitchON:9]){
        [photoSources addObject:[[PIOSideMenuButton alloc]initWithType:PIO_SM_FLICKR]];
    }
    
    if ([self isSwitchON:8]){
        [photoSources addObject:[[PIOSideMenuButton alloc]initWithType:PIO_SM_GOOGLE_PHOTOS]];
    }
    
    if ([self isSwitchON:10]){
        [photoSources addObject:[[PIOSideMenuButton alloc]initWithType:PIO_SM_DROPBOX]];
    }
    
    if ([self isSwitchON:11]){
        [photoSources addObject:[[PIOSideMenuButton alloc]initWithType:PIO_SM_PHOTOBUCKET]];
    }
    
    NSArray *images = [NSArray arrayWithObjects:[UIImage imageNamed:@"dream.jpg"], [UIImage imageNamed:@"thunder.jpg"], nil];
    //@"http://photographylife.com/wp-content/uploads/2012/10/Nikon-D600-Sample-11.jpg",
    //@"http://www.digitaltrends.com/wp-content/uploads/2013/03/vertu-constellation-review-sample-image-flowers.jpg",
    
    // Set customization file
    if ([self isSwitchON:13]){
        // Path to XML customization file
        NSString *xmlPath = [[NSBundle mainBundle] pathForResource:@"customization" ofType:@"xml"];
        NSData *xmlData = [NSData dataWithContentsOfFile:xmlPath];
        
        [self.printIO setCustomizationXML:xmlData];
        [self.printIO setLogoFileName:@"icon1"];
    }
    
    // Set country code
    if ([self isSwitchON:2]){
        [self.printIO setCountryCode:@"US"];
    }
    
    // Set currency code
    if ([self isSwitchON:4]){
        [self.printIO setCurrencyCode:@"USD"];
    }
    
    // Set language code
    if ([self isSwitchON:3]){
        [self.printIO setLanguageCode:@"en"];
    }
    
    // Set custom fonts
    if ([self isSwitchON:16]){
        NSArray *fonts = @[@"timess.ttf", @"timess.ttf", @"aubrey.ttf", @"CaviarDreams_Bold.ttf"];
        [self.printIO setFonts:fonts];
    }
    
    // Set Payee name
    if (self.txtPayeeName.text){
        [self.printIO setPayeeName:self.txtPayeeName.text];
    }
    
    // Jumps directly to product
    if ([self isSwitchON:15])
        [self.printIO goToProductId:PRODUCT_PHONE_CASES()];
    
    // Jump To SKU
    if ([self isSwitchON:17]){
        [self.printIO goToProductId:PRODUCT_PHONE_CASES() withSKU:@"PhoneCase-BlackberryZ10-Gloss"];
    }
    
    // Enable or disable Side Menu
    if ([self isSwitchON:18]){
        [self.printIO useSideMenuWithMenuIcon:[[NSBundle mainBundle]pathForResource:@"pb_menu" ofType:@"png"]];
        
        NSArray *defaultItems = [self.printIO defaultSideMenuItems];
        NSMutableArray *sideMenuItems = [[NSMutableArray alloc]initWithArray:defaultItems];
        NSArray *helpBtnArr = [sideMenuItems filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"SELF.type==%li", (long)PIOSMButtonTypeHelp]]];
        
        PIOSideMenuButton *helpButton = [helpBtnArr firstObject];
        helpButton.dataHolder = @"http://support.photobucket.com/hc/en-us/categories/200154330";
        [self.printIO setSideMenuItems:sideMenuItems];
    }
    
    // Custom share text. Will be used form side menu button.
    if ([self isSwitchON:19]){
        
    }
    
    // Show custom double tap screen when customizing product
    if ([self isSwitchON:30]){
        [self.printIO showHelpDialogWithImage:[[NSBundle mainBundle] pathForResource:@"touch" ofType:@"png"]];
    }
    
    // Show/hide tab bar in Customization Screen
    [self.printIO showToolbarInCustomizeProduct:[self isSwitchON:22] backgroundImage:nil];
    
    // Pass photos in SDK
    if ([self isSwitchON:24]){
        [self.printIO setImages:images];
        
        if([self isSwitchON:45]){
            // PIOSideMenuButton *passBtn = [[PIOSideMenuButton alloc]initWithTitle:@"Boo" type:PIO_SM_PASSED_PHOTOS iconPath:[[NSBundle mainBundle]pathForResource:@"icon1" ofType:@"png"]];
            [photoSources addObject:[[PIOSideMenuButton alloc]initWithType:PIO_SM_PASSED_PHOTOS]];
        }
    }
    
    [self.printIO setAvailablePhotoSources:photoSources]; // photo sources setter is moved here, so we can potentially add the passed images photo source
    
    [self.printIO slideSideMenuFromRight:[self isSwitchON:34]];
    [self.printIO hideImagesListInCustomizeProduct:[self isSwitchON:23]];
    [self.printIO disablePhotoSourcesWhenImagesArePassedIn:[self isSwitchON:25]];
    [self.printIO disablePhotoSourcesForOnePhotoTemplate:[self isSwitchON:26]];
    [self.printIO hideCategoriesInFeaturedProducts:[self isSwitchON:28]];
    
    // Hide status bar
    if ([self isSwitchON:29]){
        [self.printIO setStatusBarDark:NO hidden:YES];
    } else {
        [self.printIO setStatusBarDark:YES hidden:NO];
    }
    
    // Change loading GIF animation
    if ([self isSwitchON:31]){
        [self.printIO setLoadingGIF:@"load"];
    }
    
    // Photo Arrangement option
    if ([self isSwitchON:32]){
        [self.printIO setPhotoArrangement:PIO_PHOTO_ARRANGEMENT_AUTO];
    }
    
    // Show terms of service
    if ([self isSwitchON:36]){
        [self.printIO setTermsAndConditionsURL:[NSURL URLWithString:@"http://www.wikihow.com/images/sampledocs/9/Terms-and-Conditions.txt"]];
    }
    
    // Side Menu Options
    [self.printIO hidePhotoSourcesInSideMenu:[self isSwitchON:12]];
    
    if ([self isSwitchON:41]){
        [self.printIO setPositiveButtonsBackgroundColor:[UIColor blueColor]
                                             titleColor:[UIColor whiteColor]];
    }
    
    if ([self isSwitchON:42]){
        [self.printIO setNegativeButtonsBackgroundColor:[UIColor redColor]
                                             titleColor:[UIColor whiteColor]];
    }
    
    [self.printIO setNavigationBarSaveToCartBackgroundColor:nil
                                                 titleColor:[UIColor whiteColor] // 'Next' button title color
                                      buttonBackgroundColor:nil
                                           buttonTitleColor:[UIColor whiteColor]]; // 'Save to' button
    
    [self.printIO setIconForSaveButtonInCustomizeProduct:[[NSBundle mainBundle]pathForResource:@"icon_cart_white" ofType:@"png"]];
    
    if (self.txtPromoCode.text.length){
        [self.printIO setPromoCode:self.txtPromoCode.text];
    }
    
    if ([self isSwitchON:43]){
    }
    
    if ([self isSwitchON:44]){
        [self.printIO showCancelOptionsButton:YES];
    }
    
    if (self.tfRetailDiscount.text.length){
        float percent = [self.tfRetailDiscount.text floatValue];
        [self.printIO setRetailDiscountPercent:percent];
    }
    
    if ([self isSwitchON:51]){
        [self.printIO setWhatsNewDailogText:@"- bug fixes\n- new products added\n- new feature added"];
    }
    
    if ([self isSwitchON:52]){
        [self.printIO showBottomBarWithLikeUsURL:[NSURL URLWithString:@"fb://profile/642169949144369"] rateUsAppId:@"731593327" shareText:@"This is sample share text http://www.gooten.com"];
    }
    
    if ([self isSwitchON:53]){
        [self.printIO setProductsInHero:@[[NSNumber numberWithInt:PRODUCT_PHONE_CASES()], [NSNumber numberWithInt:PRODUCT_TABLET_CASES()]]];
    }
    
    if ([self isSwitchON:54]){
        [self.printIO setImageInHero:[UIImage imageNamed:@"sample_image.jpg"] url:[NSURL URLWithString:@"youtube://www.youtube.com/watch?v=pLrS1q242eE"]];
    }
    
    if ([self isSwitchON:55]){
        [self.printIO setThreeButtonsNavigationBarStyle:YES];
    }
    
    if ([self isSwitchON:56]){
        [self.printIO setProductsScreenVersion:PIOProductsScreenV3];
    }
    
    if ([self isSwitchON:58]){
        [self.printIO setUseDefaultProductSettings:YES];
    }
    
    if ([self isSwitchON:59]){
        self.tfRecipeID.text = @"1AB4E1F8-DBCB-4D6C-829F-EE0B2A60C0B3";
        [self.printIO setQAEnvironment:YES];
    }
    
    // Custom photo source
    //    MyPhotoSource *myPhotoSource = [[MyPhotoSource alloc]init];
    //    [self.printIO setAvailablePhotoSources:nil];
    //    [self.printIO hidePhotoSourcesInSideMenu:YES];
    //    [self.printIO setCustomPhotoSources:@[myPhotoSource]];
    //    [self.printIO turnOffLogs:YES];
    //    [self.printIO setDefaultPhotoSource:123 albumId:@""];
    
    
    // Passed in images
    //    NSMutableArray *photoSources1 = [[NSMutableArray alloc]init];
    //    [photoSources1 addObject:[[PIOSideMenuButton alloc]initWithType:PIO_SM_INSTAGRAM]];
    //    [photoSources1 addObject:[[PIOSideMenuButton alloc]initWithType:PIO_SM_PASSED_PHOTOS]];
    //    [self.printIO setAvailablePhotoSources:photoSources1];
    //    [self.printIO setImages:images];
    
    // Open widget
    if ([self isSwitchON:21]){
        [self.printIO openWithOption:PRINTIO_JUMP_TO_SCREEN_SHOPPING_CART];
    } else {
        [self.printIO openWithOption:[self isSwitchON:33] ? PRINTIO_OPTION_PRESENT_VIEW_FROM_RIGHT : PRINTIO_OPTION_PRESENT_VIEW_FROM_BOTTOM];
    }
}

#pragma mark - PrintIO Delegate

- (void)PrintIOWidgetOnOpen{
}

- (void)PrintIOWidgetOnCloseWithData:(NSDictionary *)data{
    NSLog(@"data: %@", data);
    _printIO = nil;
}

- (void)printIO:(PrintIO *)printIO didCompleteOrderWithData:(NSDictionary *)data{
    
}

#pragma mark - Init

- (PrintIO *)printIO{
    if (!_printIO){
        NSString *recipeId = self.tfRecipeID.text;
        _printIO = [[PrintIO alloc]initWithViewController:self recipeId:recipeId.length ? recipeId : @"f255af6f-9614-4fe2-aa8b-1b77b936d9d6" isInTestMode:[self isSwitchON:1]];
        [_printIO setDelegate:self];
        [_printIO setAnalyticsDelegate:self];
        [_printIO useStagingModeWithRecipeID:@""];
    }
    return _printIO;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad{
    [super viewDidLoad];
    
    CGRect sBounds = [[UIScreen mainScreen]bounds];
    CGRect panelRect = self.panelView.frame;
    panelRect.size.width = sBounds.size.width;
    self.panelView.frame = panelRect;
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.panelView.frame.size.height);
    [self.scrollView addSubview:self.panelView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark - Keyboard

- (void)keyboardWillShow{
    if (self.scrollView.contentOffset.y > [[UIScreen mainScreen]bounds].size.height){
        self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, self.scrollView.contentOffset.y + 216.0);
    }
}

- (void)keyboardWillHide{
    if (self.scrollView.contentOffset.y > [[UIScreen mainScreen]bounds].size.height){
        self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, self.scrollView.contentOffset.y - 216.0);
    }
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return NO;
}

#pragma mark - Get switch state

- (BOOL)isSwitchON:(NSInteger)tag{
    for (UISwitch *s in self.switches){
        if (s.tag == tag){
            return s.isOn;
        }
    }
    return NO;
}

#pragma mark - get all images for test

- (void)getAllPicturesFromPhone:(void(^)(NSArray *images, NSMutableArray *urls))completion{
    ALAssetsLibrary *library;
    NSMutableArray *mutableArray;
    __block NSInteger count = 0;
    
    mutableArray =[[NSMutableArray alloc]init];
    NSMutableArray* assetURLDictionaries = [[NSMutableArray alloc] init];
    
    library = [[ALAssetsLibrary alloc] init];
    
    void (^assetEnumerator)( ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if(result != nil) {
            if([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                //[assetURLDictionaries addObject:[result valueForProperty:ALAssetPropertyURLs]];
                
                NSURL *url= (NSURL*) [[result defaultRepresentation]url];
                [assetURLDictionaries addObject:result];

                [library assetForURL:url
                         resultBlock:^(ALAsset *asset) {
                             [mutableArray addObject:[UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]]];
                             
                             if ([mutableArray count]==count){
                                 completion([[NSArray alloc] initWithArray:mutableArray], assetURLDictionaries);
                             }
                         }
                        failureBlock:^(NSError *error){ NSLog(@"operation was not successfull!"); } ];
            }
        }
    };
    
    NSMutableArray *assetGroups = [[NSMutableArray alloc] init];
    
    void (^ assetGroupEnumerator) ( ALAssetsGroup *, BOOL *)= ^(ALAssetsGroup *group, BOOL *stop) {
        if(group != nil) {
            [group enumerateAssetsUsingBlock:assetEnumerator];
            [assetGroups addObject:group];
            count=[group numberOfAssets];
        }
    };
    
    assetGroups = [[NSMutableArray alloc] init];
    
    [library enumerateGroupsWithTypes:ALAssetsGroupAll
                           usingBlock:assetGroupEnumerator
                         failureBlock:^(NSError *error) {NSLog(@"There is an error");}];
}

@end
