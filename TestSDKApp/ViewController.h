//
//  ViewController.h
//  Gooten Sample App
//
//  Created by Boro Perisic on 8/3/18.
//  Copyright (c) 2018 Gooten. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PrintIO/PrintIO.h>

@interface ViewController : UIViewController <PrintIODelegate>

- (IBAction)tapOnPrintSomething:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *panelView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UISwitch *swTestMode;
@property (weak, nonatomic) IBOutlet UISwitch *swPassImages;
@property (weak, nonatomic) IBOutlet UISwitch *swLocalization;
@property (weak, nonatomic) IBOutlet UISwitch *swCart;
@property (weak, nonatomic) IBOutlet UISwitch *swCustomFonts;
@property (weak, nonatomic) IBOutlet UISwitch *swCustomPhotoSource;
@property (weak, nonatomic) IBOutlet UISwitch *swCustomNavBar;

@end
