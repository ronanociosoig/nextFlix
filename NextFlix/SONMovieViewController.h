//
//  SONMovieViewController.h
//  NextFlix
//
//  Created by Ronan on 16/04/2015.
//  Copyright (c) 2015 Sonomos Software S.L. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SONMovieDetails;

@interface SONMovieViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *popularityLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) SONMovieDetails *movieDetails;

@end

