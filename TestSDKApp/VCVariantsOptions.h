//
//  VCVariantsOptions.h
//  PrintIOSDKSample
//
//  Created by Tengai on 5/8/14.
//  Copyright (c) 2014 TestSDKApp. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const NOTIF_VARIANTS_SELECTED = @"notification_variants_selected";

static NSString *const KEY_DEVICE_TYPE = @"key_device_type";
static NSString *const KEY_CASE_STYLE = @"key_case_style";
static NSString *const KEY_CASE_COLOR = @"key_case_color";
static NSString *const KEY_PRINT_SIZE = @"key_print_size";
static NSString *const KEY_PRINT_TYPE = @"key_print_type";
static NSString *const KEY_FRAME_COLOR = @"key_frame_color";

@interface VCVariantsOptions : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewOptions;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)onClickBtn:(id)sender;
- (IBAction)onClickClose:(id)sender;

@end
