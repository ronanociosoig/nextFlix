//
//  SONAPIResponseParser.h
//  NextFlix
//
//  Created by Ronan on 19/04/2015.
//  Copyright (c) 2015 Sonomos Software S.L. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SONAPIResponseParser : NSObject

+ (NSArray*) parsePopulatMoviesResponse: (id) responseObject;

@end
