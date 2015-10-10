//
//  SONMainTableViewController.h
//  NextFlix
//
//  Created by Ronan on 19/04/2015.
//  Copyright (c) 2015 Sonomos Software S.L. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SONAppController;

@interface SONMainTableViewController : UITableViewController <UIScrollViewDelegate>

@property (nonatomic,weak) SONAppController *appController;

@end
