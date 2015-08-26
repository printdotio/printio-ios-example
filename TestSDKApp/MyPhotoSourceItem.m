//
//  MyPhotoSourceItem.m
//  PrintIOSDKSample
//
//  Created by Boro Perisic on 6/30/15.
//  Copyright (c) 2015 TestSDKApp. All rights reserved.
//

#import "MyPhotoSourceItem.h"

@implementation MyPhotoSourceItem

-(NSString*)uniqueIdentifier{
    return @"boor12345";
}

-(BOOL)isImageItem{
    return YES;
}

-(void)fetchImageInPhotoSource:(id<PIOPhotoSource>)photoSource isThumbnail:(BOOL)thumbnail withCompletionHandler:(void(^)(UIImage*))imageFetchCompletionHandler{
    
    UIImage *image = [UIImage imageNamed:@"touch"];
    imageFetchCompletionHandler(image);
}

//-(NSString *)publicURLPath{
//    return [[NSBundle mainBundle] pathForResource:@"icon1" ofType:@"png"];
//}

@end
