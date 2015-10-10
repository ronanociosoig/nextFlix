//
//  SONMovieAPIWrapperTests.m
//  NextFlix
//
//  Created by Ronan on 19/04/2015.
//  Copyright (c) 2015 Sonomos Software S.L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "SONMovieAPIWrapper.h"
#import "SONDefines.h"

@interface SONMovieAPIWrapperTests : XCTestCase
{
    SONMovieAPIWrapper *apiWrapper;
}
@end

@implementation SONMovieAPIWrapperTests

- (void)setUp {
    [super setUp];
    
    apiWrapper = [[SONMovieAPIWrapper alloc] initWithRootPath: SONApiRoot andAPIKey: (NSString*) SONApiKey];
}

- (void)tearDown {
    apiWrapper = nil;
    
    [super tearDown];
}

- (void)testThatInitWithRootPathAndAPIKeyReturnsObject
{
    XCTAssert(apiWrapper != nil, @"Object should not be nil");
}

- (void)testThatInitWithRootPathAndAPIKeyValuesAndReturnsTheObjectWithRootPath
{
    XCTAssert([apiWrapper.rootPath isEqualToString:SONApiRoot], @"instance variable for rootPath should be equal to the value in defines.");
}

- (void)testThatInitWithRootPathAndAPIKeyValuesAndReturnsTheObjectWithApiKey
{
    XCTAssert([apiWrapper.APIKey isEqualToString:SONApiKey], @"instance variable for APIKey should be equal to the value in defines.");
}


@end