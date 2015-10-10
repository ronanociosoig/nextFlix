//
//  SONAppController.h
//  NextFlix
//
//  Created by Ronan on 19/04/2015.
//  Copyright (c) 2015 Sonomos Software S.L. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SONMovieAPIWrapper;

@interface SONAppController : NSObject

@property (nonatomic, strong) NSMutableArray *popularMovies;
@property (nonatomic, strong) SONMovieAPIWrapper *apiWrapper;
@property (readonly) BOOL loading;
@property (readonly) BOOL loadingDetails;

@property (nonatomic, strong) NSString *imageRootPath;
@property (nonatomic, strong) NSArray *posterSizes;

@property (assign) NSInteger selectedIndex;

+(SONAppController*) sharedAppController;

- (void) reloadPopularMovies;
- (void) loadDetailsForMovieWithIdentifier: (NSNumber*) identifier;

@end
