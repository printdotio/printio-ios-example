//
//  ViewController.m
//  Gooten Sample App
//
//  Created by Boro Perisic on 8/3/18.
//  Copyright (c) 2018 Gooten. All rights reserved.
//

#import "ViewController.h"
#import <PrintIO/PrintIO.h>
#import <PrintIO/PIOVariantOption.h>
#import <PrintIO/PIOPassedImage.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <PassKit/PassKit.h>
#import "MyPhotoSource.h"
//#import <PrintIO/GTPaymentOptions.h>

@interface ViewController () <GTAnalyticsDelegate, GTPhotoSelectionDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
//@interface ViewController () <GTAnalyticsDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) PrintIO *printIO;
@property (nonatomic) UIImagePickerController *imagePickerController;
@property (nonatomic, strong) GTImagesCompletionHandler handler;

@end

@implementation ViewController

#pragma mark - Photo Selection Delegate

- (void)gtPhotoSelection:(UIViewController *)viewController numberOfImages:(NSInteger)numberOfImages template:(PIOProductTemplate *)pTemplate completion:(GTImagesCompletionHandler)completionHandler {

    self.handler = completionHandler;
    [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary vc:viewController];
}

- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType vc:(UIViewController *)vc {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = sourceType;
    imagePickerController.delegate = self;
    imagePickerController.modalPresentationStyle =
    (sourceType == UIImagePickerControllerSourceTypeCamera) ? UIModalPresentationFullScreen : UIModalPresentationPopover;
    
    UIPopoverPresentationController *presentationController = imagePickerController.popoverPresentationController;
//    presentationController.barButtonItem = button;  // display popover from the UIBarButtonItem as an anchor
    presentationController.sourceView = self.view;
    presentationController.sourceRect = [self sourceRectForCenteredAlertController];

    presentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    
    _imagePickerController = imagePickerController; // we need this for later
    
    [vc presentViewController:self.imagePickerController animated:YES completion:^{
        //.. done presenting
    }];
}

- (CGRect)sourceRectForCenteredAlertController{
    CGRect sourceRect = CGRectZero;
    sourceRect.origin.x = CGRectGetMidX(self.view.bounds)-self.view.frame.origin.x/2.0;
    sourceRect.origin.y = CGRectGetMidY(self.view.bounds)-self.view.frame.origin.y/2.0;
    return sourceRect;
}

#pragma mark - UIImagePickerControllerDelegate

// This method is called when an image has been chosen from the library or taken from the camera.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
//    self.handler(@[image, [UIImage imageNamed:@"thunder.jpg"], [UIImage imageNamed:@"dream.jpg"], [UIImage imageNamed:@"sample_image.jpg"]]);
    self.handler(@[image]);
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - Anaytics delegate

-(void)gtAnalyticsOnEnterScreen:(GTAnalyticsScreen *)screen{
    //NSLog(@"ANALYTICS SCREEN: %@", screen.name);
}

-(void)gtAnalyticsOnEvent:(GTAnalyticsEvent *)event{
     NSLog(@"ANALYTICS EVENT: %@ : %@", event.name, event.value);
    
}

-(void)gtAnalyticsOnTimedEvent:(GTAnalyticsEvent *)event{
    //NSLog(@"ANALYTICS EVENT: %@ : %@", event.name, event.value);
}

-(void)gtAnalyticsOnEndTimedEvent:(GTAnalyticsEvent *)event{
    //NSLog(@"ANALYTICS STOP CAPTURING: %@", event.name);
}

#pragma mark - Initialization code

- (IBAction)tapOnPrintSomething:(id)sender{
    [self setupSDK];
    
    if (self.swCart.isOn){
        //[self.printIO openWithOption:GTPresentToCart];
    } else {
        [self.printIO open];
    }
}

- (void)setupSDK {
    [self.printIO setApplePayMerchantIdentifier:@"merchant.sampleapp"];
    
    if (self.swCustomNavBar.isOn) {
        //[self.printIO setNavigationBarBackgroundColor:UIColor.blueColor titleColor:UIColor.yellowColor];
    }
    
    if (self.swCustomPhotoSource.isOn) {
        MyPhotoSource *myPhotoSource = [[MyPhotoSource alloc]init];
        //[self.printIO setVisiblePhotoSources:@[@(GTPSCustom), @(GTPSInstagram)]];
        [self.printIO setCustomPhotoSources:@[myPhotoSource]];
    }

    if (self.swCustomFonts.isOn) {
        [self.printIO setFonts:@[@"Philosopher-Italic.ttf", @"Philosopher-BoldItalic.ttf", @"Philosopher-Regular.ttf", @"Philosopher-Bold.ttf"]];
    }
    
    if (self.swPassImages.isOn) {
        //[self.printIO setVisiblePhotoSources:@[@(GTPSFacebook), @(GTPSPassedPhotos)]];
        [self.printIO setImages:@[[UIImage imageNamed:@"thunder.jpg"], [UIImage imageNamed:@"dream.jpg"]]];
    }
}

#pragma mark - PrintIO Delegate

- (void)PrintIOWidgetOnOpen{
}

- (void)PrintIOWidgetOnCloseWithData:(NSDictionary *)data{
    _printIO = nil;
}

- (void)printIO:(PrintIO *)printIO didCompleteOrderWithData:(NSDictionary *)data{
}

#pragma mark - Init

- (PrintIO *)printIO{
    if (!_printIO){
        _printIO = [[PrintIO alloc]initWithViewController:self recipeId:@"f7d5c56d-51b0-4d80-9fd8-acd1a92f4f69" isInTestMode:[self.swTestMode isOn]];
        [_printIO setDelegate:self];
        [_printIO setPhotoSelectionDelegate:self];
        [_printIO setAnalyticsDelegate:self];
    }
    return _printIO;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.scrollView addSubview:self.panelView];
}

@end
