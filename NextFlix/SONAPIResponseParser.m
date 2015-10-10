//
//  SONAPIResponseParser.m
//  NextFlix
//
//  Created by Ronan on 19/04/2015.
//  Copyright (c) 2015 Sonomos Software S.L. All rights reserved.
//

#import "SONAPIResponseParser.h"
#import "SONMovieDetails.h"

static NSString *const kResultsKey = @"results";

@implementation SONAPIResponseParser

+ (NSArray*) parsePopulatMoviesResponse: (id) responseObject
{
    NSDictionary *response = (NSDictionary *) responseObject;
    NSArray *movieDictionaries = [response objectForKey:kResultsKey];
    NSMutableArray *movies = [[NSMutableArray alloc] initWithCapacity:[movieDictionaries count]];
    
    for (NSDictionary *movieDict in movieDictionaries) {
        SONMovieDetails *movieDetails = [[SONMovieDetails alloc] initWithDictionary:movieDict];
        [movies addObject:movieDetails];
    }

    return [NSArray arrayWithArray:movies];
}

@end
