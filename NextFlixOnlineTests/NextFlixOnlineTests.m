//
//  NextFlixOnlineTests.m
//  NextFlixOnlineTests
//
//  Created by Ronan on 19/04/2015.
//  Copyright (c) 2015 Sonomos Software S.L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "SONDefines.h"
#import "SONMovieAPIWrapper.h"
#import <AFNetworking/AFNetworking.h>

// Movie Details Example https://api.themoviedb.org/3/movie/550?api_key=API_KEY


@interface NextFlixOnlineTests : XCTestCase
{
    //SONMovieAPIWrapper *apiWrapper;
    AFHTTPRequestOperationManager *manager;
}
@end

@implementation NextFlixOnlineTests

- (void)setUp {
    [super setUp];
    manager = [AFHTTPRequestOperationManager manager];
}

- (void)tearDown {

    manager = nil;
    [super tearDown];
}

- (void)testAPITokenIsValid {
    // Given
    XCTestExpectation *validServerResponseExpectation = [self expectationWithDescription:@"valid response for API key"];
    
    NSString *movieId = @"175112";
    NSString *urlString = [NSString stringWithFormat:@"%@%@?api_key=%@", SONApiRoot,movieId, SONApiKey];

    // When
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSLog(@"JSON: %@", responseObject);
        NSHTTPURLResponse *response = operation.response;
        if (response.statusCode == 200) {
            XCTAssert(YES,@"HTTP response should be equal to 200");
            [validServerResponseExpectation fulfill];
        } else {
            XCTFail(@"Error loading the response. %d", (int) response.statusCode);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        XCTFail(@"Error loading the response. %@", error);
    }];
    
    // Then
    [self waitForExpectationsWithTimeout:2 handler:^(NSError *error) {
       // nothing to do here
    }];
}

// returns HTTP 401 unauthorised.
/*
 {
 "status_code": 7,
 "status_message": "Invalid API key: You must be granted a valid key."
 }
 
 */

- (void) testInvalidTokenReturnsError {
    // Given
    XCTestExpectation *invalidServerResponseExpectation = [self expectationWithDescription:@"response for API key error should be HTTP code 401"];
    
    NSString *movieId = @"175112";
    NSString *urlString = [NSString stringWithFormat:@"%@%@?api_key=", SONApiRoot,movieId];

    // When
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSLog(@"JSON: %@", responseObject);
        NSHTTPURLResponse *response = operation.response;
        if (response.statusCode == 401) {
            XCTAssert(YES,@"HTTP response should be equal to 401");
            [invalidServerResponseExpectation fulfill];
        } else {
            XCTFail(@"Error loading the response. %d", (int) response.statusCode);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSHTTPURLResponse *response = operation.response;
        if (response.statusCode == 401) {
            XCTAssert(YES,@"HTTP response should be equal to 401");
            [invalidServerResponseExpectation fulfill];
        }
        // NSLog(@"Error: %@", error);
        //XCTFail(@"Error loading the response. %@", error);
    }];
    
    // Then
    [self waitForExpectationsWithTimeout:2 handler:^(NSError *error) {
        // nothing to do here
    }];
    
    XCTAssert(YES, @"Pass");
}

- (void) testPopularMoviesRequestReturnsList
{
    // Given
    XCTestExpectation *validServerResponseExpectation = [self expectationWithDescription:@"valid response for API key"];
    
    NSString *movieId = @"175112";
    NSString *urlString = [NSString stringWithFormat:@"%@%@?api_key=%@", SONApiRoot,movieId, SONApiKey];
    
    // When
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSLog(@"JSON: %@", responseObject);
        NSHTTPURLResponse *response = operation.response;
        if (response.statusCode == 200) {
            XCTAssert(YES,@"HTTP response should be equal to 200");
            [validServerResponseExpectation fulfill];
        } else {
            XCTFail(@"Error loading the response. %d", (int) response.statusCode);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        XCTFail(@"Error loading the response. %@", error);
    }];
    
    // Then
    [self waitForExpectationsWithTimeout:2 handler:^(NSError *error) {
        // nothing to do here
    }];
}

- (void) testMovieDetailsRequestReturnsDetails
{
    // Given
    XCTestExpectation *validServerResponseExpectation = [self expectationWithDescription:@"valid response for API key"];
    
    NSString *movieId = @"175112";
    NSString *urlString = [NSString stringWithFormat:@"%@%@?api_key=%@", SONApiRoot,movieId, SONApiKey];
    NSLog(@"URL:%@", urlString);

    // When
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSDictionary *responseDictionary = (NSDictionary *) responseObject;
        NSString *title = (NSString*) [responseDictionary objectForKey:@"title"];
        NSString *posterPath = (NSString*) [responseDictionary objectForKey:@"poster_path"];

        if ([title isEqualToString:@"The Pirate Fairy"]
            && [posterPath isEqualToString: @"/tgninaaS0wn1qV3M57jX0Cfeils.jpg"]) {
            XCTAssert(YES,@"the values should be match");
            [validServerResponseExpectation fulfill];
        } else {
            NSLog(@"Title:%@", title);
            NSLog(@"PosterPath:%@", posterPath);
            XCTFail(@"Error loading the response.");
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        XCTFail(@"Error loading the response. %@", error);
    }];
    
    // Then
    [self waitForExpectationsWithTimeout:2 handler:^(NSError *error) {
        // nothing to do here
    }];
}

//- (void) testThatRepeatCallsToSameRequestReturnsNotModifiedHTTPErrorCode
//{
//    // Server can return HTTP error code 304: Not modified
//    XCTAssert(YES, @"Pass");
//}

@end