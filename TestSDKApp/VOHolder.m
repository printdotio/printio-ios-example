//
//  VOHolder.m
//  PrintIOSDKSample
//
//  Created by Tengai on 5/8/14.
//  Copyright (c) 2014 TestSDKApp. All rights reserved.
//

#import "VOHolder.h"

@implementation VOHolder

- (id)initWithOption:(PIOVariantOption *)vOption name:(NSString *)name
{
    self = [super init];
    if (self){
        self.vOption = vOption;
        self.name = name;
    }
    return self;
}

@end
