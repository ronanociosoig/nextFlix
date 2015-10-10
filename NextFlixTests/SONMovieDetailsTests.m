//
//  SONMovieDetailsTests.m
//  NextFlix
//
//  Created by Ronan on 19/04/2015.
//  Copyright (c) 2015 Sonomos Software S.L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "SONMovieDetails.h"

@interface SONMovieDetailsTests : XCTestCase
{
    SONMovieDetails *movieDetails;
}
@end

@implementation SONMovieDetailsTests

- (void)setUp {
    [super setUp];

    NSDictionary *movieDataDictionary =
  @{@"adult":@NO,
    @"backdrop_path":@"/6K91kEQUYQQGPjRJFvsSDs1QIiU.jpg",
    @"id":@287587,
    @"original_title":@"Adult Beginners",
    @"release_date":@"2015-04-24",
    @"poster_path":@"/jm4gkItBRQYhTHIXPGYjuv7FjfP.jpg",
    @"popularity":@1.3305589155459,
    @"title":@"Adult Beginners",
    @"video":@NO,
    @"vote_average":@0.0,
    @"vote_count":@0
    };
    
    movieDetails = [[SONMovieDetails alloc] initWithDictionary:movieDataDictionary];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testObjectNotNil {
    // This is an example of a functional test case.
    XCTAssertNotNil(movieDetails,@"The movie object should not be nil.");
}

- (void)testThatTitleIsCorrect
{
    XCTAssert([movieDetails.title isEqualToString:@"Adult Beginners"], @"The title should be equal to: 'Adult Beginners' ");
}

- (void)testThatIdIsCorrect
{
    XCTAssert([movieDetails.identifier isEqualToNumber:@287587], @"Movie identifier should be equal to 287587");
}

- (void)testThatPopularityIsCorrect
{
    XCTAssert([movieDetails.popularity isEqualToNumber:@1.3305589155459],@"Movie popularity should be equal to 1.3305589155459");
}

- (void)testThatPosterPathIsCorrect
{
    XCTAssert([movieDetails.posterPath isEqualToString:@"/jm4gkItBRQYhTHIXPGYjuv7FjfP.jpg"], @"Poster path should be euqal to jm4gkItBRQYhTHIXPGYjuv7FjfP.jpg");
}

- (void)testThatReleaseDateIsCorrect
{
    NSString *releaseDateString = @"2015-04-24";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *releaseDate = [dateFormatter dateFromString:releaseDateString];
    XCTAssert([movieDetails.releaseDate compare:releaseDate] == NSOrderedSame, @"Release date should be equal to 2015-04-24");
}

- (void) testThatLoadedIsNotSetBeforeCallingAddDetails
{
    XCTAssertFalse(movieDetails.loaded, @"Loaded should be false before calling addDetails method");
}

- (void) testThatLoadedIsSetAfterCallingAddDetails
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *path = [bundle pathForResource:@"MovieDetails" ofType:@"json"];
    NSData *movieDetailsData = [NSData dataWithContentsOfFile:path];
    NSDictionary *jsonData = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:movieDetailsData options:NSJSONReadingAllowFragments error:nil];
    [movieDetails addDetailsFromDictionary:jsonData];
    
    XCTAssert(movieDetails.loaded, @"Loaded should be true after calling addDetails method");
}

- (void) testThatCategoriesAreLoaded
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *path = [bundle pathForResource:@"MovieDetails" ofType:@"json"];
    
    NSData *movieDetailsData = [NSData dataWithContentsOfFile:path];
    //NSLog(@"data length: %lu", (unsigned long)[movieDetailsData length]);
    NSDictionary *jsonData = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:movieDetailsData options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"DICT: \n%@", [jsonData description]);
    [movieDetails addDetailsFromDictionary:jsonData];
    
    XCTAssert([movieDetails.categories count] == 1, @"Should have loaded 3 categories from the movie details");
}
@end
