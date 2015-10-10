//
//  SONMovieDetails.h
//  NextFlix
//
//  Created by Ronan on 19/04/2015.
//  Copyright (c) 2015 Sonomos Software S.L. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SONMovieDetails : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *popularity;
@property (nonatomic, strong) NSString *posterPath;
@property (nonatomic, strong) NSNumber *identifier;
@property (nonatomic, strong) NSString *overView;
@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) NSDate *releaseDate;
@property (readwrite) BOOL loaded;

- (instancetype) initWithDictionary: (NSDictionary *) dictionary;

- (void) addDetailsFromDictionary: (NSDictionary *) dictionary;

@end
