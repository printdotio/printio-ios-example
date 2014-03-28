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

@property (weak, nonatomic) IBOutlet UIView *panelView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

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
@property (weak, nonatomic) IBOutlet UITextField *txtPayeeName;

@property (weak, nonatomic) IBOutlet UISwitch *switchPSPhone;
@property (weak, nonatomic) IBOutlet UISwitch *switchPSFacebook;
@property (weak, nonatomic) IBOutlet UISwitch *switchPSInstagram;
@property (weak, nonatomic) IBOutlet UISwitch *switchPSPicasa;
@property (weak, nonatomic) IBOutlet UISwitch *switchPSFlickr;
@property (weak, nonatomic) IBOutlet UISwitch *switchPSDropbox;
@property (weak, nonatomic) IBOutlet UISwitch *switchPSPhotobucket;

@end
