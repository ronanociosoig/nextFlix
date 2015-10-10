//
//  SONAPIResponseParserTests.m
//  NextFlix
//
//  Created by Ronan on 19/04/2015.
//  Copyright (c) 2015 Sonomos Software S.L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "SONAPIResponseParserTests.m"
#import "SONAPIResponseParser.h"

@interface SONAPIResponseParserTests : XCTestCase
{
    NSArray *movies;
}

@end

@implementation SONAPIResponseParserTests

- (void)setUp {
    [super setUp];
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *path = [bundle pathForResource:@"PopularMovies" ofType:@"json"];
    NSData *popularMoviesData = [NSData dataWithContentsOfFile:path];
    NSDictionary *jsonData = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:popularMoviesData options:NSJSONReadingAllowFragments error:nil];
    movies = [SONAPIResponseParser parsePopulatMoviesResponse:jsonData];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAPIResponseParserReturnsAnArray {
    // This is an example of a functional test case.
    XCTAssertNotNil(movies, @"The movies array should not be nil");
}

- (void)testThatMovieCountIsCorrect {
    XCTAssert([movies count] == 20, @"The movies count should equal 20");
}

@end
