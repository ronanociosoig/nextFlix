//
//  SONAppControllerTests.m
//  NextFlix
//
//  Created by Ronan on 19/04/2015.
//  Copyright (c) 2015 Sonomos Software S.L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "SONAppController.h"
#import "SONMovieAPIWrapper.h"

@interface SONAppControllerTests : XCTestCase
{
    SONAppController *appController;
}

@end

@implementation SONAppControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    appController = [SONAppController sharedAppController];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    
    appController = nil;
    
    [super tearDown];
}

- (void)testAppControllerIsSingleton {
    // This is an example of a functional test case.
    
    SONAppController *anotherAppController = [SONAppController sharedAppController];
    
    XCTAssertEqualObjects(appController, anotherAppController);
}

- (void)testThatAppControllerWillInitAPIWrapper
{
    XCTAssertNotNil(appController.apiWrapper, @"API wrapper should not be nil.");
}

- (void)testThatAppControllerWillInitPopularMovies
{
    XCTAssertNotNil(appController.popularMovies, @"Popular movies array should not be nil.");
}

@end
