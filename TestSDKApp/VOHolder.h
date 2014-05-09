//
//  VOHolder.h
//  PrintIOSDKSample
//
//  Created by Tengai on 5/8/14.
//  Copyright (c) 2014 TestSDKApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PrintIO/PIOVariantOption.h>
#import <PrintIO/PrintIO.h>

@interface VOHolder : NSObject

@property (nonatomic, strong) PIOVariantOption *vOption;
@property (nonatomic, strong) NSString *name;

- (id)initWithOption:(PIOVariantOption *)vOption name:(NSString *)name;

@end
