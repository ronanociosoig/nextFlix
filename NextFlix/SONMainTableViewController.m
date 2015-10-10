//
//  SONMainTableViewController.m
//  NextFlix
//
//  Created by Ronan on 19/04/2015.
//  Copyright (c) 2015 Sonomos Software S.L. All rights reserved.
//

#import "SONMainTableViewController.h"
#import "SONAppController.h"
#import "SONDefines.h"
#import "SONMovieDetails.h"
#import "SONMovieViewController.h"


static NSString *kResueIdentifier = @"PopularMovieIdentifier";
static float kPullToRefreshOffset = -120.0;

@interface SONMainTableViewController ()
{
    NSInteger numberOfMovies;
    SONMovieViewController *viewController;
}

@end

@implementation SONMainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    numberOfMovies = 0;
    self.title = @"Popular Movies";
    self.appController = [SONAppController sharedAppController];
    
    [self.navigationController.navigationBar setTintColor:RED_TINT_COLOR];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popularMoviesUpdatedNotificationHandler:) name:kPopularMoviesUpdatedNotification object:nil];
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([self.appController.popularMovies count] == 0) {
        [self.appController reloadPopularMovies];
    }
}

#pragma mark - Notification Handler
     
- (void) popularMoviesUpdatedNotificationHandler: (NSNotification*) notification
{
    numberOfMovies = [self.appController.popularMovies count];
    [self.tableView reloadData];
}

#pragma mark - Table view delegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.appController.selectedIndex = indexPath.row;
    
    SONMovieDetails *selectedMovieDetails = [self.appController.popularMovies objectAtIndex:self.appController.selectedIndex];
    viewController.movieDetails = selectedMovieDetails;
    if (!selectedMovieDetails.loaded) {
        [self.appController loadDetailsForMovieWithIdentifier:selectedMovieDetails.identifier];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return numberOfMovies;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kResueIdentifier forIndexPath:indexPath];
    SONMovieDetails *movieDetails = [self.appController.popularMovies objectAtIndex:indexPath.row];
    cell.textLabel.text = [movieDetails.title copy];
    float popularity = [movieDetails.popularity floatValue];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%1.2f", popularity];

    return cell;
}

#pragma mark - Trigger Reload

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.contentOffset.y < kPullToRefreshOffset) {
        if (!self.appController.loading) {
            [self.appController reloadPopularMovies];
        }
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    viewController = (SONMovieViewController*) [segue destinationViewController];
}

#pragma mark - Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
