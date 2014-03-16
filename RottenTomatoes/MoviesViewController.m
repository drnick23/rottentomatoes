//
//  MoviesViewController.m
//  RottenTomatoes
//
//  Created by Nicolas Halper on 3/13/14.
//  Copyright (c) 2014 Nicolas Halper. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieDetailViewController.h"
#import "MoviesCell.h"
#import "MovieList.h"
#import "UIImageView+AFNetworking.h"
#import "MBProgressHUD.h"
#import "AFNetworkReachabilityManager.h"
#import "Reachability.h"


@interface MoviesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) MovieList *movieList;
@property BOOL isReachable;
@property (weak, nonatomic) IBOutlet UIView *networkErrorView;

@end

@implementation MoviesViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"Movies";
    
    // configure datasource and delegate of the table view
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // setup the custom cell
    UINib *customNib = [UINib nibWithNibName:@"MoviesCell" bundle:nil];
    [self.tableView registerNib:customNib forCellReuseIdentifier:@"MoviesCell"];
    
    
    // hide network unreachable view by default
    [self.networkErrorView setHidden:YES];
    
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
    }];
    
    
    // Initialize Refresh Control
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    
    // Configure Refresh Control
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    
    // Configure View Controller
    //self.refreshControl = refreshControl;
    [self.tableView addSubview:refreshControl];
    
    // load data from RottenTomatoes
    //http://api.rottentomatoes.com/api/public/v1.0/lists/movies.json?apikey=dnr7gjmesk2tm5vmvvvzrf6t
    
    
    // Allocate a reachability object
    Reachability* reach = [Reachability reachabilityWithHostname:@"api.rottentomatoes.com"];
    
    // Set the blocks
    reach.reachableBlock = ^(Reachability*reach)
    {
        self.isReachable = YES;
        [self.networkErrorView setHidden:YES];
        NSLog(@"REACHABLE!");
    };
    
    reach.unreachableBlock = ^(Reachability*reach)
    {
        self.isReachable = NO;
        [self.networkErrorView setHidden:NO];
        NSLog(@"UNREACHABLE!");
    };
    
    // Start the notifier, which will cause the reachability object to retain itself!
    [reach startNotifier];

    
    self.movieList = [[MovieList alloc] init];
    [self fetchMovies];
    
    
}

- (void) reachabilityChanged
{
    NSLog(@"reachability changed");
}

- (void)refresh:(UIRefreshControl *)refreshControl {
    [refreshControl endRefreshing];
    // TODO: should end refreshing after fetch movies has completed.
    [self fetchMovies];
}

- (void) fetchMovies
{
    
    // show progress indicator when fetching movies
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    //NSURL *rottenTomatoesMoviesListURL = [[NSURL alloc] initWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies.json?apikey=dnr7gjmesk2tm5vmvvvzrf6t"];
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=dnr7gjmesk2tm5vmvvvzrf6t";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        // hide progress indicator.
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        
        if (connectionError) {
            NSLog(@"Error connecting");
            [self.networkErrorView setHidden:NO];
        }
        else {
            id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            if([object isKindOfClass:[NSDictionary class]])
            {
                NSDictionary *results = object;
                //NSLog(@"%@",[results objectForKey:@"movies"]);
                
               /* if([[results objectForKey:@"movies"] isKindOfClass:[NSArray class]]) {
                    self.movies = [results objectForKey:@"movies"];
                }*/
                
                if([[results objectForKey:@"movies"] isKindOfClass:[NSArray class]]) {
                    
                    NSDictionary *movieRawData = [results objectForKey:@"movies"];
                    
                    // add all our movies to the list...
                    for (NSDictionary *dictionary in movieRawData) {
                        Movie *movie = [[Movie alloc] initWithDictionary:dictionary];
                        [self.movieList add:movie atTop:NO];
                        //NSLog(@"Added movie %@",movie.title);
                    }
                    
                }
                
                [self.tableView reloadData];
            }
            else
            {
                NSLog(@"Error: not a dict");
            }
        }

        
        //NSLog(@"%@", object);
    }];
    
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.movieList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MoviesCell";
    MoviesCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    Movie *movie = [self.movieList get:indexPath.row];
    
    cell.titleLabel.text = movie.title;//[NSString stringWithFormat:@"%@", self.movies[indexPath.row][@"title"]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    //NSLog(@"Movie object %@",movie.title);
    
    cell.descriptionLabel.text = movie.summary;//[NSString stringWithFormat:@"%@", self.movies[indexPath.row][@"synopsis"]];
    
    NSURL *imageUrl = [NSURL URLWithString:movie.thumbUrl];
    UIImage *placeholderImage = [UIImage imageNamed:@"MoviePlaceholder"];
    [cell.thumbImageView setImageWithURL:imageUrl placeholderImage:placeholderImage];

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Display Alert Message
    MoviesCell *cell = (MoviesCell *) [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"You selected %@",cell.titleLabel.text);
    
    MovieDetailViewController *mdvc = [[MovieDetailViewController alloc] init];
    mdvc.movie = [self.movieList get:indexPath.row];
    [self.navigationController pushViewController:mdvc animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110.0; // edit this return value to your liking
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
