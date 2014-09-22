//
//  PBPrintService.h
//  Photobucket Next
//
//  Created by Brian Temple on 6/4/14.
//  Copyright (c) 2014 Photobucket. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface PBPrintService : NSObject

+ (PBPrintService *)printShop;

- (void)open;
- (void)openWithProduct:(NSInteger)productId;
- (void)openShoppingCart;
- (void)setPromotionCode:(NSString *)promotionCode;

- (NSInteger)numberOfItemsInShoppingCart;
- (UIImage *)badgedShoppingCartImage;

@end
