//
//  SONMovieDetails.m
//  NextFlix
//
//  Created by Ronan on 19/04/2015.
//  Copyright (c) 2015 Sonomos Software S.L. All rights reserved.
//

#import "SONMovieDetails.h"
#import <Motis/Motis.h>
#import "SONDefines.h"

@implementation SONMovieDetails

- (instancetype) initWithDictionary: (NSDictionary *) dictionary
{
    self = [super init];
    if (self) {
        [self mts_setValuesForKeysWithDictionary:dictionary];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateString = [dictionary objectForKey:@"release_date"];
        self.releaseDate = [formatter dateFromString:dateString];
    }
    
    return self;
}

/*
 
 Response for popular movies
 
 {
 "adult":false,
 "backdrop_path":"/rFtsE7Lhlc2jRWF7SRAU0fvrveQ.jpg",
 "id":99861,
 "original_title":"Avengers: Age of Ultron",
 "release_date":"2015-05-01",
 "poster_path":"/16995J5R00I431Wzj0UfmgVqVPS.jpg",
 "popularity":7.26932327996537,
 "title":"Avengers: Age of Ultron",
 "video":false,
 "vote_average":7.9,
 "vote_count":9
 }
 
 @property (nonatomic, strong) NSString *title;
 @property (nonatomic, strong) NSNumber *popularity;
 @property (nonatomic, strong) NSString *posterPath;
 @property (nonatomic, strong) NSString *identifier;
 @property (nonatomic, strong) NSString *overView;  // this is in movieDetails
 @property (nonatomic, strong) NSArray *categories; // this is in movieDetails
 @property (nonatomic, strong) NSDate *releaseDate;
 
 */

- (void) addDetailsFromDictionary: (NSDictionary *) dictionary
{
    self.overView = [dictionary objectForKey:@"overview"];
    NSArray *genres = (NSArray*)[dictionary objectForKey:@"genres"];
    NSMutableArray *foundCategories = [NSMutableArray new];
    for (NSDictionary *dict in genres) {
        NSString *nameOfGenre = [dict objectForKey:@"name"];
        [foundCategories addObject:nameOfGenre];
    }
    
    self.categories = [NSArray arrayWithArray:foundCategories];
    self.loaded = YES;
}

+(NSDictionary*) mts_mapping
{
    return @{@"title": mts_key(title),
             @"popularity": mts_key(popularity),
             @"release_date": mts_key(releaseDate),
             @"poster_path": mts_key(posterPath),
             @"id": mts_key(identifier),
             @"genres": mts_key(categories),
             @"overview": mts_key(overView)
             };
}

@end