//
//  ViewController.h
//  TestSDKApp
//
//  Created by Tengai on 12/13/13.
//  Copyright (c) 2013 TestSDKApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PrintIO/PrintIO.h>

@interface ViewController : UIViewController <PrintIODelegate, UITextFieldDelegate>
{

}

- (IBAction)onClickTestSDK:(id)sender;
- (IBAction)onClickTestVariantsOptions:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *panelView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UITextField *txtPayeeName;
@property (weak, nonatomic) IBOutlet UITextField *txtPromoCode;

@property (weak, nonatomic) IBOutlet UISwitch *switchPhotoSources;
@property (weak, nonatomic) IBOutlet UISwitch *switchCountryCode;
@property (weak, nonatomic) IBOutlet UISwitch *switchCurrencyCode;
@property (weak, nonatomic) IBOutlet UISwitch *switchLanguageCode;
@property (weak, nonatomic) IBOutlet UISwitch *switchCustomization;
@property (weak, nonatomic) IBOutlet UISwitch *switchTitleBarColor;
@property (weak, nonatomic) IBOutlet UISwitch *switchJumpToProduct;
@property (weak, nonatomic) IBOutlet UISwitch *switchCustomFonts;
@property (weak, nonatomic) IBOutlet UISwitch *switchProduction;
@property (weak, nonatomic) IBOutlet UISwitch *switchJumpToSKU;
@property (weak, nonatomic) IBOutlet UISwitch *switchEnableSideMenu;

@property (weak, nonatomic) IBOutlet UISwitch *switchPSPhone;
@property (weak, nonatomic) IBOutlet UISwitch *switchPSFacebook;
@property (weak, nonatomic) IBOutlet UISwitch *switchPSInstagram;
@property (weak, nonatomic) IBOutlet UISwitch *switchPSPicasa;
@property (weak, nonatomic) IBOutlet UISwitch *switchPSFlickr;
@property (weak, nonatomic) IBOutlet UISwitch *switchPSDropbox;
@property (weak, nonatomic) IBOutlet UISwitch *switchPSPhotobucket;

@property (weak, nonatomic) IBOutlet UISwitch *switchCustomShareText;
@property (weak, nonatomic) IBOutlet UISwitch *switchBtnInNavBar;
@property (weak, nonatomic) IBOutlet UISwitch *switchCustomDoubleTapScreen;
@property (weak, nonatomic) IBOutlet UISwitch *switchShowTabBarInCustomizationScreen;
@property (weak, nonatomic) IBOutlet UISwitch *switchHideImagesListInCustomization;
@property (weak, nonatomic) IBOutlet UISwitch *switchPassPhotosInSDK;
@property (weak, nonatomic) IBOutlet UISwitch *switchDisablePSWhenPhotosArePassed;
@property (weak, nonatomic) IBOutlet UISwitch *switchUsePassedImageAsThumbForOnePhotoTemplate;
@property (weak, nonatomic) IBOutlet UISwitch *switchDisablePSWhenPhotoIsPassedForOnePhototemplate;
@property (weak, nonatomic) IBOutlet UISwitch *hideCategoriesView;
@property (weak, nonatomic) IBOutlet UISwitch *switchHideStatusBar;
@property (weak, nonatomic) IBOutlet UISwitch *switchSetCountryInFProducts;
@property (weak, nonatomic) IBOutlet UISwitch *switchCustomGIF;
@property (weak, nonatomic) IBOutlet UISwitch *switchPhotoArrangement;
@property (weak, nonatomic) IBOutlet UISwitch *switchPresentViewFromRight;

@property (weak, nonatomic) IBOutlet UISwitch *swSlideSideMenuFromRight;
@property (weak, nonatomic) IBOutlet UISwitch *swJumpToShopingCart;
@property (weak, nonatomic) IBOutlet UISwitch *swShowTermsOfService;
@property (weak, nonatomic) IBOutlet UISwitch *swSideMenuHideAccountsHeader;
@property (weak, nonatomic) IBOutlet UISwitch *swSideMenuHideInfoHeader;
@property (weak, nonatomic) IBOutlet UISwitch *swSideMenuHideOptionsHeader;
@property (weak, nonatomic) IBOutlet UISwitch *swSideMenuShowOptionsAsAList;
@property (weak, nonatomic) IBOutlet UISwitch *swHidePhotoSourcesInSideMenu;
@property (weak, nonatomic) IBOutlet UISwitch *swNegativeButtons;
@property (weak, nonatomic) IBOutlet UISwitch *swPositiveButtons;
@property (weak, nonatomic) IBOutlet UISwitch *swDisablePreviewScreen;

// Partners
@property (weak, nonatomic) IBOutlet UISwitch *switchMirrorgram;
@property (weak, nonatomic) IBOutlet UISwitch *SwitchMGPath2;
@property (weak, nonatomic) IBOutlet UISwitch *SwitchMGPath3;
@property (weak, nonatomic) IBOutlet UISwitch *switchPhotobucket;
@property (weak, nonatomic) IBOutlet UISwitch *switchYellowLab500px;
@property (weak, nonatomic) IBOutlet UISwitch *switchTestVariantsOptions;

@end
