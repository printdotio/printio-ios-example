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

- (IBAction)tapOnPrintSomething:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *panelView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UITextField *txtPayeeName;
@property (weak, nonatomic) IBOutlet UITextField *txtPromoCode;
@property (weak, nonatomic) IBOutlet UITextField *tfRecipeID;

@property (strong, nonatomic) IBOutletCollection(UISwitch) NSArray *switches;

@end
