//
//  ViewController.m
//  NextFlix
//
//  Created by Ronan on 16/04/2015.
//  Copyright (c) 2015 Sonomos Software S.L. All rights reserved.
//


#import "SONMovieViewController.h"
#import "SONDefines.h"
#import "Haneke.h"
#import "SONMovieDetails.h"
#import "SONAppController.h"

@interface SONMovieViewController ()
{
    SONAppController *appController;
}

@end

@implementation SONMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    appController = [SONAppController sharedAppController];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:kMovieDetailsUpdatedNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        if (![self.movieDetails.overView isKindOfClass:[NSNull class]]
            && self.movieDetails.overView
            && [self.movieDetails.overView length] > 0) {
            self.textView.text = self.movieDetails.overView;
        } else {
            self.textView.text = @"No overview available.";
        }
        
        [self updateCategories];
    }];
    
    self.title = @"Movie Details";
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.movieDetails) {
        self.titleLabel.text = self.movieDetails.title;
        self.popularityLabel.text = [NSString stringWithFormat:@"Popularity: %1.2f", [self.movieDetails.popularity floatValue]];
        
        [self updateCategories];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy"];
        self.releaseDateLabel.text = [NSString stringWithFormat:@"Year: %@", [formatter stringFromDate:self.movieDetails.releaseDate]];
        
        self.textView.text = self.movieDetails.overView;
        if ([self.movieDetails.posterPath isKindOfClass:[NSString class]]) {
            NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",appController.imageRootPath, [appController.posterSizes lastObject], self.movieDetails.posterPath]];
            [self.thumbnailImageView hnk_setImageFromURL:imageURL];
        } else {
            self.thumbnailImageView.image = [UIImage imageNamed:@"Icon_512"];
        }

        self.textView.selectable = NO;
        [self.textView setEditable:NO];
    }
}

- (void) updateCategories
{
    if ([self.movieDetails.categories count] > 0) {
        NSMutableString *allCategories = [NSMutableString new];
        for (NSString *category in self.movieDetails.categories) {
            [allCategories appendString:category];
            [allCategories appendString:@","];
        }
        
        self.categoryLabel.text = [NSString stringWithFormat:@"Category: %@", [allCategories substringToIndex:allCategories.length-1]];
    } else {
        self.categoryLabel.text = @"Category: None defined";
    }
}

- (void) movieDetailsUpdatedNotificationHandler: (NSNotification *) notification
{
    if (![self.movieDetails.overView isKindOfClass:[NSNull class]]
        && self.movieDetails.overView
        && [self.movieDetails.overView length] > 0) {
        self.textView.text = self.movieDetails.overView;
    } else {
        self.textView.text = @"No overview available.";
    }
    
    [self updateCategories];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
