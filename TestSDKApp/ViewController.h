//
//  ViewController.h
//  TestSDKApp
//
//  Created by Tengai on 12/13/13.
//  Copyright (c) 2013 TestSDKApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HelloPicsFramework/HelloPics.h>

@interface ViewController : UIViewController <HelloPicsDelegate, UITextFieldDelegate>
{

}

- (IBAction)onClickTestSDK:(id)sender;

@property (weak, nonatomic) IBOutlet UISwitch *switchPhotoSources;
@property (weak, nonatomic) IBOutlet UISwitch *switchCountryCode;
@property (weak, nonatomic) IBOutlet UISwitch *switchCustomization;
@property (weak, nonatomic) IBOutlet UISwitch *switchTitleBarColor;
@property (weak, nonatomic) IBOutlet UISwitch *switchJumpToProduct;
@property (weak, nonatomic) IBOutlet UISwitch *switchCustomFonts;
@property (weak, nonatomic) IBOutlet UISwitch *switchProduction;
@property (weak, nonatomic) IBOutlet UISwitch *switchJumpToSKU;
@property (weak, nonatomic) IBOutlet UITextField *txtPayeeName;

@end
