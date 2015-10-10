//
//  SONAppController.m
//  NextFlix
//
//  Created by Ronan on 19/04/2015.
//  Copyright (c) 2015 Sonomos Software S.L. All rights reserved.
//

#import "SONAppController.h"
#import "SONMovieAPIWrapper.h"
#import "SONDefines.h"
#import "SONMovieDetails.h"

#import <UIKit/UIKit.h>

@interface SONAppController()

@property (readwrite) BOOL loading;
@property (readwrite) BOOL loadingDetails;

@end

@implementation SONAppController

+ (SONAppController*) sharedAppController
{
    // Using GCD
    static dispatch_once_t once;
    static id sVINAppController;
    
    dispatch_once(&once, ^{
        sVINAppController = [[self alloc] init];
    });
    return sVINAppController;
}

- (instancetype) init
{
    self = [super init];
    
    if (self) {
        self.apiWrapper = [[SONMovieAPIWrapper alloc] initWithRootPath:SONApiRoot andAPIKey:SONApiKey];
        self.popularMovies = [NSMutableArray new];
        
        [self.apiWrapper loadConfigurationWithConpletionHandler:^(NSDictionary *movieData, NSError *error) {
            if (error) {
                [[[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
            } else {
                NSDictionary *imagesData = [movieData objectForKey:@"images"];
                self.imageRootPath = [imagesData objectForKey:@"base_url"];
                self.posterSizes = [imagesData objectForKey:@"poster_sizes"];
            }
        }];
    }
    
    return self;
}

- (void) reloadPopularMovies
{
    if (!self.loading) {
        self.loading = YES;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kPopularMoviesShowLoadingNotification object:nil];
        
        [self.apiWrapper findPopularMoviesWithCompletionHandler:^(NSArray *movies, NSError *error) {
            self.loading = NO;
            
            if (error) {
                [[[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
            } else {
                [self.popularMovies removeAllObjects];
                [self.popularMovies addObjectsFromArray:movies];
                [self.popularMovies sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"popularity" ascending:NO]]];
                
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kPopularMoviesUpdatedNotification object:nil];
            
        }];
    }
}

- (void) loadDetailsForMovieWithIdentifier: (NSNumber*) identifier
{
    if (!self.loadingDetails) {
        self.loadingDetails = YES;
        [self.apiWrapper findDetailsForMovieWithIdentifier:identifier completionHandler:^(NSDictionary *movieData, NSError *error) {
            self.loadingDetails = NO;
            SONMovieDetails *movieDetails = [self.popularMovies objectAtIndex:self.selectedIndex];
            [movieDetails addDetailsFromDictionary:movieData];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kMovieDetailsUpdatedNotification object:nil];
        }];
    }
}

@end
