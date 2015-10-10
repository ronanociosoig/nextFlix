//
//  SONDefines.h
//  NextFlix
//
//  Created by Ronan on 18/04/2015.
//  Copyright (c) 2015 Sonomos Software S.L. All rights reserved.
//

#ifndef NextFlix_SONDefines_h
#define NextFlix_SONDefines_h

#define SONLog(format, ...)  NSLog(@"%s :: %@", __PRETTY_FUNCTION__,[NSString stringWithFormat:format, ## __VA_ARGS__])

// Useful when writing iPad-specific code.
// to check that DEVICE == IPAD
#define DEVICE    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad

#define RED_TINT_COLOR [UIColor colorWithRed:(235.0/255.0) green:(52.0/255.0) blue:(36.0/255.0) alpha:1.0]

extern NSString *const SONApiKey;
extern NSString *const SONApiRoot;
extern NSString *const kPopularMoviesShowLoadingNotification;
extern NSString *const kPopularMoviesUpdatedNotification;
extern NSString *const kMovieDetailsUpdatedNotification;

#endif