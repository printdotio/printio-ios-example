//
//  MyPhotoSource.m
//  PrintIOSDKSample
//
//  Created by Boro Perisic on 6/23/15.
//  Copyright (c) 2015 TestSDKApp. All rights reserved.
//

#import "MyPhotoSource.h"
#import "MyPhotoSourceItem.h"

@implementation MyPhotoSource

-(NSString *)title{
    return @"MyPhotoSource";
}

- (NSString *)buttonIconPath{
    return [[NSBundle mainBundle] pathForResource:@"icon1" ofType:@"png"];
}

- (BOOL)isAuthed{
    return YES;
}

-(void)fetchImageForItem:(id<PIOPhotoSourceItem>)item thumbnail:(BOOL)isThumbnail withCompletionHandler:(void(^)(UIImage*))imageFetchCompletionHandler{
    UIImage *image = [UIImage imageNamed:@"touch"];
    imageFetchCompletionHandler(image);
}

-(void)requestPhotoSourceItemsForItem:(id<PIOPhotoSourceItem>)item currentScope:(id<PIOPhotoSourceItem>)currentScope count:(NSUInteger)count page:(NSUInteger)page withCompletionHandler:(PIOItemsCompletionHandler)completionHandler errorHandler:(PIOPhotoSourceErrorHandler)errorHandler{
    
    NSMutableArray *array = [NSMutableArray new];
    for (int i=0; i<1; i++){
        MyPhotoSourceItem *item = [[MyPhotoSourceItem alloc]init];
        [array addObject:item];
    }
    
    completionHandler(array);
}

@end
