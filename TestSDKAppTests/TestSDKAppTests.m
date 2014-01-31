//
//  TestSDKAppTests.m
//  TestSDKAppTests
//
//  Created by Tengai on 12/13/13.
//  Copyright (c) 2013 TestSDKApp. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <HelloPicsFramework/HelloPics.h>

@interface TestSDKAppTests : XCTestCase
{
    HelloPics *hellopics;
}
@end

@implementation TestSDKAppTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    hellopics = [[HelloPics alloc]initWithViewController:nil];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSDK
{
    //XCTAssertNoThrow([hellopics goTest_SQLDao_numOfItemsInCart], @"ooops sqlite framework exception");
}

@end
