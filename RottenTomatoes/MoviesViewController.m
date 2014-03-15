//
//  MoviesViewController.m
//  RottenTomatoes
//
//  Created by Nicolas Halper on 3/13/14.
//  Copyright (c) 2014 Nicolas Halper. All rights reserved.
//

#import "MoviesViewController.h"
#import "MoviesCell.h"
#import "UIImageView+AFNetworking.h"


@interface MoviesViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *movies;

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
    
    // configure datasource and delegate of the table view
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // setup the custom cell
    UINib *customNib = [UINib nibWithNibName:@"MoviesCell" bundle:nil];
    [self.tableView registerNib:customNib forCellReuseIdentifier:@"MoviesCell"];
    
    // load data from RottenTomatoes
    //http://api.rottentomatoes.com/api/public/v1.0/lists/movies.json?apikey=dnr7gjmesk2tm5vmvvvzrf6t
    
    [self fetchMovies];
    
}

- (void) fetchMovies
{
    
    //NSURL *rottenTomatoesMoviesListURL = [[NSURL alloc] initWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies.json?apikey=dnr7gjmesk2tm5vmvvvzrf6t"];
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=dnr7gjmesk2tm5vmvvvzrf6t";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if([object isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *results = object;
            NSLog(@"%@",[results objectForKey:@"movies"]);
            
            if([[results objectForKey:@"movies"] isKindOfClass:[NSArray class]]) {
                self.movies = [results objectForKey:@"movies"];
            }
            [self.tableView reloadData];
        }
        else
        {
            NSLog(@"Error: not a dict");
        }
        //NSLog(@"%@", object);
    }];
    
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MoviesCell";
    MoviesCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.titleLabel.text = [NSString stringWithFormat:@"%@", self.movies[indexPath.row][@"title"]];
    NSLog(@"Row movie %d %@",indexPath.row,self.movies[indexPath.row][@"title"]);
    
    cell.descriptionLabel.text = [NSString stringWithFormat:@"%@", self.movies[indexPath.row][@"synopsis"]];
    
    NSURL *imageUrl = [NSURL URLWithString:self.movies[indexPath.row][@"posters"][@"thumbnail"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:imageUrl];
    UIImage *placeholderImage = [UIImage imageNamed:@"MoviePlaceholder"];
    
    __weak MoviesCell *weakCell = cell;
    
    [cell.imageView setImageWithURLRequest:request
     placeholderImage:placeholderImage
     success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
         weakCell.imageView.image = image;
         //[weakCell setNeedsLayout];
     }
     failure:nil];
    
   
        
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Display Alert Message
    MoviesCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"You selected %@",cell.titleLabel.text);
    
    
    //int idx=indexPath.row;
    /*
    MovieDetailViewController *mdvc = [[]
	mdvc.dataItem =[dataItems objectAtIndex:idx];
	[self.view addSubview:[[B]myExistingController[/B].view]];*/
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
