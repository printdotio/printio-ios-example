//
//  PBPrintService.m
//  Photobucket Next
//
//  Created by Brian Temple on 6/4/14.
//  Copyright (c) 2014 Photobucket. All rights reserved.
//
#import <PrintIO/PrintIO.h>
#import <PrintIO/PIOSideMenuButton.h>
#import "PBPrintService.h"
#import "AppDelegate.h"

static int const kPrintIOEnvironment = PRINTIO_PRODUCTION;

static NSString * const kPrintIOProductionSSOName = @"api.print.io";
static NSString * const kPrintIOStagingSSOName    = @"staging.print.io";
static NSString * const kPrintIOProductionRecipeId = @"46f999dd-814d-428f-b0ff-47954b4181b2";
static NSString * const kPrintIOStagingRecipeId    = @"7b4e12e3-c60f-47ed-bf75-ce848726cfcc";

static NSString * const kPrintIOPayeeName = @"Photobucket";
static NSString * const kPrintIOPaypalStagingClientId    = @"";
static NSString * const kPrintIOPaypalProductionClientId = @"";
static NSString * const kPrintIOBraintreeStagingEncryptionKey    = @"";
static NSString * const kPrintIOBraintreeProductionEncryptionKey = @"";

// Third party credentials
static NSString * const kPrintIOFacebookAppId = @"";

// Production
static NSString * const kPrintIODropboxAppKey = @"";
static NSString * const kPrintIODropboxAppSecret = @"";

static NSString * const kPrintIOInstagramClientId = @"";

static NSString * const kPrintIOFlickrConsumerKey = @"";
static NSString * const kPrintIOFlickrConsumerSecret = @"";

@interface PBPrintService () <PrintIODelegate>
@property (strong, nonatomic) PrintIO *printIO;
@property (strong, nonatomic) UIImage *badgedShoppingCartBackground;
@property (strong, nonatomic) UIImage *shoppingCart;
@end

@implementation PBPrintService

+ (PBPrintService *)printShop
{
    static PBPrintService *printShop;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        printShop = [[self alloc] init];
    });

    return printShop;
}

- (void)open
{
    [self openWithAlbum:nil];
}

- (void)openWithAlbum:(id)album
{
    [self.printIO setDefaultPhotoSource:PIO_PS_PHOTOBUCKET albumId:@""];
    [self.printIO openWithOption:PRINTIO_OPTION_PRESENT_VIEW_FROM_BOTTOM | PRINTIO_ENABLE_BACK_BUTTON];
}

- (void)openWithProduct:(NSInteger)productId
{
    [self.printIO showCountrySelectionOnScreen:PIO_SCREEN_PRODUCT_DETAILS backgroundColor:[UIColor blueColor]];
    [self.printIO goToProductId:productId];
    [self open];
}

- (void)openShoppingCart
{
    [self.printIO setDefaultPhotoSource:PIO_PS_PHOTOBUCKET albumId:nil];
    [self.printIO openWithOption:PRINTIO_OPTION_PRESENT_VIEW_FROM_BOTTOM | PRINTIO_JUMP_TO_SCREEN_SHOPPING_CART | PRINTIO_ENABLE_BACK_BUTTON];
}

- (void)setPromotionCode:(NSString *)promotionCode
{
    [self.printIO setPromoCode:promotionCode];
}

- (NSInteger)numberOfItemsInShoppingCart
{
    return [PrintIO numberOfItemsInShoppingCart];
}

- (UIImage *)badgedShoppingCartImage
{
    if (self.badgedShoppingCartBackground == nil) {
        self.badgedShoppingCartBackground = [UIImage imageNamed:@"pb_icon_cart_black"];
    }
    
    NSInteger numberOfItems = [PrintIO numberOfItemsInShoppingCart];

    UIImage *badgedImage;
    if (numberOfItems < 0 || numberOfItems > 99) {
        badgedImage = self.badgedShoppingCartBackground;
    } else {
        UIGraphicsBeginImageContext(self.badgedShoppingCartBackground.size);
        [self.badgedShoppingCartBackground drawInRect:CGRectMake(0, 0, self.badgedShoppingCartBackground.size.width, self.badgedShoppingCartBackground.size.height)];
        
        int xOffset = (numberOfItems > 9) ? self.badgedShoppingCartBackground.size.width - 40 : self.badgedShoppingCartBackground.size.width - 35;
        [[NSString stringWithFormat:@"%li", (long)numberOfItems] drawAtPoint:CGPointMake(xOffset, 12.5)
                                                              withAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                               NSFontAttributeName:[UIFont systemFontOfSize:14.0]}];
        badgedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    return badgedImage;
}

- (void)configurePrintIO
{
    // Basic setup
    NSArray *fonts = @[ @"MuseoSans_300.otf", @"MuseoSans_500.otf", @"MuseoSans_500.otf", @"MuseoSans_700.otf" ];
    [self.printIO setFonts:fonts];
    [self.printIO showCountrySelectionOnScreen:PIO_SCREEN_FEATURED_PRODUCTS backgroundColor:[UIColor blueColor]];
    [self.printIO hideCategoriesInFeaturedProducts:NO];
    //[self.printIO setPassedImageAsThumbForOnePhotoTemplate:YES];
    //[self.printIO setPhotoArrangement:PIO_PHOTO_ARRANGEMENT_AUTO];

    [self.printIO setLoadingGIF:@"greyspinner"];
    [self.printIO setLoadingText:@"Loading..."];

    // Paypal setup
    [self.printIO setPayeeName:kPrintIOPayeeName];
    [self.printIO setPayPalStagingClientId:kPrintIOPaypalStagingClientId
                    productionClientId:kPrintIOPaypalProductionClientId];

    // Braintree setup
    [self.printIO setBraintreeStagingEncryptionKey:kPrintIOBraintreeStagingEncryptionKey
                       productionEncryptionKey:kPrintIOBraintreeProductionEncryptionKey];

    // Third party image source setup
    // TODO: Uncomment with web update to use fully qualified redirect urls
    [self.printIO setFacebookAppId:kPrintIOFacebookAppId redirectUrl:@"https://printio.auth"];
    
    [self.printIO setDropboxKey:kPrintIODropboxAppKey redirectUrl:@"printio://auth"];
    [self.printIO setInstagramClientID:kPrintIOInstagramClientId redirectUrl:@"printio://auth"];
    [self.printIO setFlickrKey:kPrintIOFlickrConsumerKey secretKey:kPrintIOFlickrConsumerSecret redirectUrl:@"printio://auth"];

    // Color customization
    NSData *xmlData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"printio" ofType:@"xml"]];
    [self.printIO setCustomizationXML:xmlData];

    // Photo sources setup
    PIOSideMenuButton *phoneSource = [[PIOSideMenuButton alloc] initWithType:PIO_SM_PHONE];
    phoneSource.fontSizeOfTitle = 10.0;
    PIOSideMenuButton *pbSource = [[PIOSideMenuButton alloc] initWithType:PIO_SM_PHOTOBUCKET];
    pbSource.fontSizeOfTitle = 10.0;
    PIOSideMenuButton *fbSource = [[PIOSideMenuButton alloc] initWithType:PIO_SM_FACEBOOK];
    fbSource.fontSizeOfTitle = 10.0;
    PIOSideMenuButton *igSource = [[PIOSideMenuButton alloc] initWithType:PIO_SM_INSTAGRAM];
    igSource.fontSizeOfTitle = 10.0;
    PIOSideMenuButton *dbSource = [[PIOSideMenuButton alloc] initWithType:PIO_SM_DROPBOX];
    dbSource.fontSizeOfTitle = 10.0;
    PIOSideMenuButton *flSource = [[PIOSideMenuButton alloc] initWithType:PIO_SM_FLICKR];
    flSource.fontSizeOfTitle = 10.0;
    [self.printIO setAvailablePhotoSources:@[phoneSource, pbSource, fbSource, igSource, dbSource, flSource]];
    [self.printIO hidePhotoSourcesInSideMenu:YES];
    //[self.printIO disablePhotoSourcesWhenImagesArePassedIn:NO];
    //[self.printIO disablePhotoSourcesForOnePhotoTemplate:YES];

    // Navbar setup
    [self.printIO setStatusBarDark:YES hidden:YES];
    [self.printIO navigationBarColor:[UIColor whiteColor]
                      titleColor:[UIColor blackColor]
       leftButtonBackgroundColor:[UIColor whiteColor]
      rightButtonBackgroundColor:[UIColor whiteColor]
                 titleButtonIcon:nil];
    [self.printIO setThreeButtonsNavigationBarSytle:YES];

    [self.printIO setIconForShoppingCart:[[NSBundle mainBundle]pathForResource:@"pb_icon_cart_black" ofType:@"png"]
                 withNumberOfProducts:YES labelPosition:CGPointMake(15, 6.5) textColor:[UIColor whiteColor]];
    [self.printIO setIconForBackButton:[[NSBundle mainBundle]pathForResource:@"pb_back" ofType:@"png"]];
    [self.printIO useSideMenuWithMenuIcon:[[NSBundle mainBundle]pathForResource:@"pb_menu_a" ofType:@"png"]
                           background:[UIColor colorWithRed:227.0/255.0 green:227.0/255.0 blue:225.0/255.0 alpha:1.0]];

    // Sidebar menu setup
    [self.printIO slideSideMenuFromRight:YES];
    PIOSideMenuButton *cartButton = [[PIOSideMenuButton alloc]initWithTitle:@"VIEW CART"
                                                                       type:PIO_SM_VIEW_CART
                                                                   iconPath:[[NSBundle mainBundle] pathForResource:@"pb_btn_cart" ofType:@"png"]];
    cartButton.fontSize = 15.0;
    cartButton.textColor = [UIColor blackColor];
    PIOSideMenuButton *helpButton   = [[PIOSideMenuButton alloc]initWithTitle:@"HELP"
                                                                         type:PIO_SM_HELP
                                                                     iconPath:[[NSBundle mainBundle] pathForResource:@"pb_btn_help" ofType:@"png"]];
    helpButton.fontSize = 15.0;
    helpButton.textColor = [UIColor blackColor];
    helpButton.dataHolder = @"http://support.photobucket.com/hc/en-us/categories/200154330";

    PIOSideMenuButton *currencyButton = [[PIOSideMenuButton alloc]initWithTitle:@"Change Currency"
                                                                           type:PIO_SM_CHANGE_CURRENCY
                                                                       iconPath:nil];
    currencyButton.fontSize = 14.0;
    currencyButton.textColor = [UIColor blackColor];
    currencyButton.textSecondColor = [UIColor blackColor];
    
    PIOSideMenuButton *countryButton  = [[PIOSideMenuButton alloc] initWithType:PIO_SM_CHANGE_COUNTRY];
    countryButton.fontSize = 14.0;
    countryButton.textColor = [UIColor blackColor];
    PIOSideMenuButton *langButton     = [[PIOSideMenuButton alloc]initWithTitle:@"Change Language"
                                                                           type:PIO_SM_CHANGE_LANGUAGE
                                                                       iconPath:[[NSBundle mainBundle] pathForResource:@"pb_btn_language" ofType:@"png"]];
    langButton.fontSize = 14.0;
    langButton.textColor = [UIColor blackColor];

    PIOSideMenuButton *howButton   = [[PIOSideMenuButton alloc]initWithTitle:@"HOW IT WORKS"
                                                                         type:PIO_SM_HOW_IT_WORKS
                                                                     iconPath:[[NSBundle mainBundle] pathForResource:@"pb_btn_info" ofType:@"png"]];
    howButton.fontSize = 15.0;
    howButton.textColor = [UIColor blackColor];

    [self.printIO sideMenuAddButtons:@[cartButton, helpButton]
                         options:@[currencyButton, countryButton, langButton]
                    optionsTitle:@"Options"
               optionsTitleColor:[UIColor blackColor]
                    optionsColor:[UIColor grayColor]
                   accountsTitle:@"Accounts"
              accountsTitleColor:[UIColor blackColor]
                   accountsColor:[UIColor grayColor]
                            info:@[howButton]
                       infoTitle:@"Info"
                  infoTitleColor:[UIColor blackColor]
                       infoColor:[UIColor grayColor]
       backgroundImageForButtons:[[NSBundle mainBundle]pathForResource:@"pb_bcg" ofType:@"png"]];

    // Products screen customization
    [self.printIO showToolbarInCustomizeProduct:NO backgroundImage:nil];
    //[self.printIO hideImagesListInCustomizeProduct:NO];
    [self.printIO removePlusFromAddMoreProductsButton:YES];
    [self.printIO setLogoFileName:@""];
    [self.printIO removeLogoFromPaymentScreen:YES];
    
    // Edit screen customization
    NSArray *editButtons = @[[[PIOButton alloc]initWithType:PIO_BUTTON_IMAGE_EDITOR_INFO],
                             [[PIOButton alloc]initWithType:PIO_BUTTON_IMAGE_EDITOR_ROTATE],
                             [[PIOButton alloc]initWithType:PIO_BUTTON_IMAGE_EDITOR_EDIT_TEXT],
                             [[PIOButton alloc]initWithType:PIO_BUTTON_IMAGE_EDITOR_EFFECTS]];
    for (PIOButton *button in editButtons) {
        button.titleColor = [UIColor blueColor];
        button.iconColor = [UIColor blueColor];
    }
    
    [self.printIO imageEditorShowButtons:editButtons];
    [self.printIO hideWatchVideoButton:NO];

}

#pragma mark - PrintIO delegate

- (void)PrintIOWidgetOnOpen {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)PrintIOWidgetOnCloseWithData:(NSDictionary *)data {
    NSLog(@"%s %@", __PRETTY_FUNCTION__, data);
    NSDictionary *orderData = data[@"order_data"];
    if (!orderData) {
        if (!orderData[@"overall"]) {
            // Convert $NN.NN to a float
            NSNumberFormatter *nf = [NSNumberFormatter new];
            [nf setNumberStyle:NSNumberFormatterCurrencyStyle];
            float orderCost = [[nf numberFromString:orderData[@"overall"]] floatValue];

            NSString *label;
            if (orderCost <= 50.00)
                label = @"cost_under_50";
            else if (orderCost <= 100.00)
                label = @"cost_under_100";
            else
                label = @"cost_over_100";
        }
    }
}

#pragma mark - Custom accessors

- (PrintIO *)printIO
{
    if (!_printIO) {
        UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
        _printIO = [[PrintIO alloc] initWithViewController:viewController
                                               environment:kPrintIOEnvironment
                                        productionRecipeId:kPrintIOProductionRecipeId
                                           stagingRecipeId:kPrintIOStagingRecipeId];
        _printIO.delegate = self;
        [self configurePrintIO];
    }

    return _printIO;
}

@end
