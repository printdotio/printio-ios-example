//
//  VCVariantsOptions.m
//  PrintIOSDKSample
//
//  Created by Tengai on 5/8/14.
//  Copyright (c) 2014 TestSDKApp. All rights reserved.
//

#import "VCVariantsOptions.h"
#import <PrintIO/PIOVariantOption.h>
#import <PrintIO/PrintIO.h>
#import "VOHolder.h"

@interface VCVariantsOptions () <UIPickerViewDataSource, UIPickerViewDelegate>

// Tablet Cases
@property (nonatomic, strong) NSArray *arrTabletModels;
@property (nonatomic, strong) NSArray *arrCaseStyles;
@property (nonatomic, strong) NSArray *arrColors;

// Framed Prints
@property (nonatomic, strong) NSArray *arrPrintSize;
@property (nonatomic, strong) NSArray *arrFrameColor;
@property (nonatomic, strong) NSArray *arrPrintType;

@property (nonatomic, weak) NSArray *selectedArr;
@property (nonatomic, strong) NSMutableDictionary *userData;
@end

@implementation VCVariantsOptions

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.scrollView addSubview:self.viewOptions];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.viewOptions.frame.size.height);
    
    [self initArrays];
}

#pragma mark - Buttons action

- (IBAction)onClickBtn:(id)sender
{
    NSInteger tag = [(UIButton *)sender tag];
    
    switch (tag) {
        case 101:
            self.selectedArr = self.arrTabletModels;
            break;
            
        case 102:
            self.selectedArr = self.arrCaseStyles;
            break;
            
        case 103:
            self.selectedArr = self.arrColors;
            break;
            
        case 104:
            self.selectedArr = self.arrPrintSize;
            break;
            
        case 105:
            self.selectedArr = self.arrFrameColor;
            break;
            
        case 106:
            self.selectedArr = self.arrPrintType;
            break;
    }
    
    [self.pickerView reloadAllComponents];
}

- (IBAction)onClickClose:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTIF_VARIANTS_SELECTED
                                                           object:self
                                                         userInfo:self.userData];
    }];
}

- (void)initArrays
{
    // For Tablet Cases
    //
    // Galaxy Note 10.0
    PIOVariantOption *op1 = [[PIOVariantOption alloc]initWithProductId:PRODUCT_TABLET_CASES()
                                                              optionId:@"db7b1f755f10457cb2aef7ee9bf58177"
                                                               valueId:@"db0440e48e2c43d4851ed784af35263f"];
    // Galaxy Note 8.0
    PIOVariantOption *op2 = [[PIOVariantOption alloc]initWithProductId:PRODUCT_TABLET_CASES()
                                                              optionId:@"db7b1f755f10457cb2aef7ee9bf58177"
                                                               valueId:@"c66ccad831404655905ae68602aa10df"];
    // Galaxy Tab 7
    PIOVariantOption *op3 = [[PIOVariantOption alloc]initWithProductId:PRODUCT_TABLET_CASES()
                                                              optionId:@"db7b1f755f10457cb2aef7ee9bf58177"
                                                               valueId:@"ef8746f8b27040c49a7c8fabed264591"];
    
    // iPad 3/4
    PIOVariantOption *op4 = [[PIOVariantOption alloc]initWithProductId:PRODUCT_TABLET_CASES()
                                                              optionId:@"db7b1f755f10457cb2aef7ee9bf58177"
                                                               valueId:@"aa0387e5a58447fa8a53e1dd5dccce49"];
    
    // iPadMini
    PIOVariantOption *op5 = [[PIOVariantOption alloc]initWithProductId:PRODUCT_TABLET_CASES()
                                                              optionId:@"db7b1f755f10457cb2aef7ee9bf58177"
                                                               valueId:@"d4ac369b3b274a29b0fd18b40514eb52"];
    
    // Case Sytle Glossy
    PIOVariantOption *op6 = [[PIOVariantOption alloc]initWithProductId:PRODUCT_TABLET_CASES()
                                                              optionId:@"2729db9407ba441d9bd257cc158d8ce9"
                                                               valueId:@"0058706aaaa7482585a09ac5437f4009"];
    
    // Case Style Matte
    PIOVariantOption *op7 = [[PIOVariantOption alloc]initWithProductId:PRODUCT_TABLET_CASES()
                                                              optionId:@"2729db9407ba441d9bd257cc158d8ce9"
                                                               valueId:@"a415a1432dc741b0a2d5d3d95b47f315"];
    
    // Colors
    PIOVariantOption *op8 = [[PIOVariantOption alloc]initWithProductId:PRODUCT_TABLET_CASES()
                                                              optionId:@""
                                                               valueId:@""];
    op8.color = [UIColor redColor];
    
    PIOVariantOption *op9 = [[PIOVariantOption alloc]initWithProductId:PRODUCT_TABLET_CASES()
                                                              optionId:@""
                                                               valueId:@""];
    op9.color = [UIColor greenColor];
    
    PIOVariantOption *op10 = [[PIOVariantOption alloc]initWithProductId:PRODUCT_TABLET_CASES()
                                                              optionId:@""
                                                               valueId:@""];
    op10.color = [UIColor blueColor];
    
    // Framed Print
    PIOVariantOption *fp1 = [[PIOVariantOption alloc]initWithProductId:PRODUCT_FRAMED_PRINTS()
                                                              optionId:@"3e9da285a0a84ea59633207e0feff5fe"
                                                               valueId:@"9c7e40b9c4c3440b87c069dd482cc62f"];
    
    PIOVariantOption *fp2 = [[PIOVariantOption alloc]initWithProductId:PRODUCT_FRAMED_PRINTS()
                                                              optionId:@"3e9da285a0a84ea59633207e0feff5fe"
                                                               valueId:@"b29d0a48012142ba82b7f0cbf4a77754"];
    
    PIOVariantOption *fp3 = [[PIOVariantOption alloc]initWithProductId:PRODUCT_FRAMED_PRINTS()
                                                              optionId:@"3e9da285a0a84ea59633207e0feff5fe"
                                                               valueId:@"ae0fa7ee233d42a1bdfbe67c2b7d35ec"];
    
    PIOVariantOption *fp4 = [[PIOVariantOption alloc]initWithProductId:PRODUCT_FRAMED_PRINTS()
                                                              optionId:@"3e9da285a0a84ea59633207e0feff5fe"
                                                               valueId:@"acebf354e89846efadfa63c5fe395716"];
    
    PIOVariantOption *fp5 = [[PIOVariantOption alloc]initWithProductId:PRODUCT_FRAMED_PRINTS()
                                                              optionId:@"3e9da285a0a84ea59633207e0feff5fe"
                                                               valueId:@"caa3f6ec9b794674af426ddec96155ca"];
    
    PIOVariantOption *fp6 = [[PIOVariantOption alloc]initWithProductId:PRODUCT_FRAMED_PRINTS()
                                                              optionId:@"3e9da285a0a84ea59633207e0feff5fe"
                                                               valueId:@"abf6181afd7343cb9e863e689b379fef"];
    
    PIOVariantOption *fp7 = [[PIOVariantOption alloc]initWithProductId:PRODUCT_FRAMED_PRINTS()
                                                              optionId:@"3e9da285a0a84ea59633207e0feff5fe"
                                                               valueId:@"7077a839a6f8454790334a0953509980"];
    
    PIOVariantOption *fp8 = [[PIOVariantOption alloc]initWithProductId:PRODUCT_FRAMED_PRINTS()
                                                              optionId:@"3e9da285a0a84ea59633207e0feff5fe"
                                                               valueId:@"8480cd20ae254e118529097ed51fbae6"];
    
    PIOVariantOption *fp9 = [[PIOVariantOption alloc]initWithProductId:PRODUCT_FRAMED_PRINTS()
                                                              optionId:@"3e9da285a0a84ea59633207e0feff5fe"
                                                               valueId:@"a3202067c3df4c628f70c83e44e5e111"];
    
    PIOVariantOption *fp10 = [[PIOVariantOption alloc]initWithProductId:PRODUCT_FRAMED_PRINTS()
                                                              optionId:@"3e9da285a0a84ea59633207e0feff5fe"
                                                               valueId:@"b89a890459484dc4bc9d2c6b1bfdbacf"];
    
    PIOVariantOption *fp11 = [[PIOVariantOption alloc]initWithProductId:PRODUCT_FRAMED_PRINTS()
                                                               optionId:@"af66458cf1b844ad9daed9546a6e2216"
                                                                valueId:@"cb529a229b6a4636b0b1d0afcc494c4f"];
    
    PIOVariantOption *fp12 = [[PIOVariantOption alloc]initWithProductId:PRODUCT_FRAMED_PRINTS()
                                                               optionId:@"af66458cf1b844ad9daed9546a6e2216"
                                                                valueId:@"fd969827a82b4e2196b049ce905a2bf6"];
    
    PIOVariantOption *fp13 = [[PIOVariantOption alloc]initWithProductId:PRODUCT_FRAMED_PRINTS()
                                                               optionId:@"c02deea045fb4d47873985b333db9321"
                                                                valueId:@"284ec9da7e66449a859ac08bb9ce51b7"];
    
    PIOVariantOption *fp14 = [[PIOVariantOption alloc]initWithProductId:PRODUCT_FRAMED_PRINTS()
                                                               optionId:@"c02deea045fb4d47873985b333db9321"
                                                                valueId:@"a3b9cf393442430ab4966e454a6910b1"];
    
    PIOVariantOption *fp15 = [[PIOVariantOption alloc]initWithProductId:PRODUCT_FRAMED_PRINTS()
                                                               optionId:@"c02deea045fb4d47873985b333db9321"
                                                                valueId:@"34f66a3f03d0488c9d8f70ef775fad56"];
    
    self.arrPrintType = [NSArray arrayWithObjects:[[VOHolder alloc]initWithOption:fp13 name:@"Gloss"],
                         [[VOHolder alloc]initWithOption:fp14 name:@"Lustre"],
                         [[VOHolder alloc]initWithOption:fp15 name:@"Metallic"], nil];
    
    self.arrFrameColor = [NSArray arrayWithObjects:[[VOHolder alloc]initWithOption:fp11 name:@"Black"],
                          [[VOHolder alloc]initWithOption:fp12 name:@"White"], nil];

    self.arrPrintSize = [NSArray arrayWithObjects:[[VOHolder alloc]initWithOption:fp1 name:@"10x10 inch"],
                         [[VOHolder alloc]initWithOption:fp2 name:@"11x14 inch"],
                         [[VOHolder alloc]initWithOption:fp3 name:@"12x12 inch"],
                         [[VOHolder alloc]initWithOption:fp4 name:@"12x18 inch"],
                         [[VOHolder alloc]initWithOption:fp5 name:@"16x16 inch"],
                         [[VOHolder alloc]initWithOption:fp6 name:@"16x20 inch"],
                         [[VOHolder alloc]initWithOption:fp7 name:@"20x20 inch"],
                         [[VOHolder alloc]initWithOption:fp8 name:@"20x30 inch"],
                         [[VOHolder alloc]initWithOption:fp9 name:@"8x10 inch"],
                         [[VOHolder alloc]initWithOption:fp10 name:@"8x8 inch"], nil];
    
    
    self.arrTabletModels = [NSArray arrayWithObjects:[[VOHolder alloc]initWithOption:op1 name:@"Galaxy Note 10.0"],
                            [[VOHolder alloc]initWithOption:op2 name:@"Galaxy Note 8.0"],
                            [[VOHolder alloc]initWithOption:op3 name:@"Galaxy Tab 7"],
                            [[VOHolder alloc]initWithOption:op4 name:@"iPad 3/4"],
                            [[VOHolder alloc]initWithOption:op5 name:@"iPadMini"], nil];
    
    self.arrCaseStyles = [NSArray arrayWithObjects:[[VOHolder alloc]initWithOption:op6 name:@"Glossy"],
                          [[VOHolder alloc]initWithOption:op7 name:@"Matte"], nil];
    
    self.arrColors = [NSArray arrayWithObjects:[[VOHolder alloc]initWithOption:op8 name:@"Red"],
                      [[VOHolder alloc]initWithOption:op9 name:@"Green"],
                      [[VOHolder alloc]initWithOption:op10 name:@"Blue"], nil];
}

#pragma mark - Picker View

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.selectedArr.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    VOHolder *obj = [self.selectedArr objectAtIndex:row];
    return obj.name;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    VOHolder *obj = [self.selectedArr objectAtIndex:row];
    
    if (self.selectedArr == self.arrTabletModels){
        ((UILabel *)[self.viewOptions viewWithTag:1]).text = [NSString stringWithFormat:@"Device Type: %@", obj.name];
        [self.userData setValue:obj.vOption forKey:KEY_DEVICE_TYPE];
        
    } else if (self.selectedArr == self.arrCaseStyles){
        ((UILabel *)[self.viewOptions viewWithTag:2]).text = [NSString stringWithFormat:@"Case Style: %@", obj.name];
        [self.userData setValue:obj.vOption forKey:KEY_CASE_STYLE];
    
    } else if (self.selectedArr == self.arrColors){
        ((UILabel *)[self.viewOptions viewWithTag:3]).text = [NSString stringWithFormat:@"Case Color: %@", obj.name];
        [self.userData setValue:obj.vOption forKey:KEY_CASE_COLOR];
    
    } else if (self.selectedArr == self.arrPrintSize){
        ((UILabel *)[self.viewOptions viewWithTag:4]).text = [NSString stringWithFormat:@"Print Size: %@", obj.name];
        [self.userData setValue:obj.vOption forKey:KEY_PRINT_SIZE];
    
    } else if (self.selectedArr == self.arrFrameColor){
        ((UILabel *)[self.viewOptions viewWithTag:5]).text = [NSString stringWithFormat:@"Frame Color: %@", obj.name];
        [self.userData setValue:obj.vOption forKey:KEY_FRAME_COLOR];
    
    } else if (self.selectedArr == self.arrPrintType){
        ((UILabel *)[self.viewOptions viewWithTag:6]).text = [NSString stringWithFormat:@"Print Type: %@", obj.name];
        [self.userData setValue:obj.vOption forKey:KEY_PRINT_TYPE];
    }
}

#pragma mark - Inits

- (NSMutableDictionary *)userData
{
    if (!_userData){
        _userData = [[NSMutableDictionary alloc]init];
    }
    return _userData;
}

@end
