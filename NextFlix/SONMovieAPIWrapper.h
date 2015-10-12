//
//  SONMovieAPIWrapper.h
//  NextFlix
//
//  Created by Ronan on 18/04/2015.
//  Copyright (c) 2015 Sonomos Software S.L. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SONPopularMoviesCompletionHandler)(NSArray *movies, NSError *error);
typedef void(^SONMovieDetailsCompletionHandler)(NSDictionary *movieData, NSError *error);
typedef void(^SONConfigurationDetailsCompletionHandler)(NSDictionary *movieData, NSError *error);

@interface SONMovieAPIWrapper : NSObject

@property (strong) NSString *APIKey;
@property (strong) NSString *rootPath;

- (instancetype) initWithRootPath: (NSString*) rootPath andAPIKey: (NSString*) APIKey;
- (void) loadConfigurationWithConpletionHandler:(SONConfigurationDetailsCompletionHandler) handler;
- (void) findPopularMoviesWithCompletionHandler:(SONPopularMoviesCompletionHandler) handler;
- (void) findDetailsForMovieWithIdentifier: (NSNumber*) identifier completionHandler: (SONMovieDetailsCompletionHandler) handler;

@end
