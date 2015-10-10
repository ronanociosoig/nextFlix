//
//  SONMovieAPIWrapper.m
//  NextFlix
//
//  Created by Ronan on 18/04/2015.
//  Copyright (c) 2015 Sonomos Software S.L. All rights reserved.
//

#import "SONMovieAPIWrapper.h"
#import <AFNetworking/AFNetworking.h>
#import "SONAPIResponseParser.h"
#import "SONDefines.h"

@interface SONMovieAPIWrapper()
{
    AFHTTPRequestOperationManager *manager;
}

@property (nonatomic, copy) SONPopularMoviesCompletionHandler popularMoviesHandler;
@property (nonatomic, copy) SONMovieDetailsCompletionHandler movieDetailsHandler;
@property (nonatomic, copy) SONConfigurationDetailsCompletionHandler configDetailsHandler;

@end

@implementation SONMovieAPIWrapper

- (instancetype) initWithRootPath:(NSString *)rootPath_ andAPIKey:(NSString *)APIKey_
{
    self = [super init];
    if (self) {
        self.rootPath = rootPath_;
        self.APIKey = APIKey_;
        manager = [AFHTTPRequestOperationManager manager];
    }
    
    return self;
}

- (void) loadConfigurationWithConpletionHandler:(SONConfigurationDetailsCompletionHandler) handler
{
    self.configDetailsHandler = handler;
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.themoviedb.org/3/configuration?api_key=%@", self.APIKey];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDictionary = (NSDictionary*)responseObject;
        self.configDetailsHandler(responseDictionary, nil);
        self.configDetailsHandler = nil;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        self.configDetailsHandler(nil, error);
        self.configDetailsHandler = nil;
    }];
}

// http://api.themoviedb.org/3/movie/upcoming?api_key=8a27497ac7b4c9e728a8466536cbf7ca

- (void) findPopularMoviesWithCompletionHandler:(SONPopularMoviesCompletionHandler) completionHandler
{
    self.popularMoviesHandler = completionHandler;
    NSString *urlString = [NSString stringWithFormat:@"%@upcoming?api_key=%@", self.rootPath, self.APIKey];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.popularMoviesHandler([SONAPIResponseParser parsePopulatMoviesResponse:responseObject], nil);
        self.popularMoviesHandler = nil;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        self.popularMoviesHandler(nil, error);
        self.popularMoviesHandler = nil;
    }];
}

// https://api.themoviedb.org/3/movie/550?api_key=8a27497ac7b4c9e728a8466536cbf7ca

- (void) findDetailsForMovieWithIdentifier: (NSNumber*) identifier completionHandler: (SONMovieDetailsCompletionHandler) handler
{
    self.movieDetailsHandler = handler;
    NSString *urlString = [NSString stringWithFormat:@"%@%@?api_key=%@", self.rootPath,[identifier stringValue], self.APIKey];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDictionary = (NSDictionary*)responseObject;
        self.movieDetailsHandler(responseDictionary, nil);
        self.movieDetailsHandler = nil;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        self.movieDetailsHandler(nil, error);
        self.movieDetailsHandler = nil;
    }];
}

@end
