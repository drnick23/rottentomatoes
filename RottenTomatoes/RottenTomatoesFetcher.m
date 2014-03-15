//
//  RottenTomatoesFetcher.m
//  RottenTomatoes
//
//  Created by Nicolas Halper on 3/14/14.
//  Copyright (c) 2014 Nicolas Halper. All rights reserved.
//

#import "RottenTomatoesFetcher.h"

@implementation RottenTomatoesFetcher

- (void) fetchMovies
{
    
    //NSURL *rottenTomatoesMoviesListURL = [[NSURL alloc] initWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies.json?apikey=dnr7gjmesk2tm5vmvvvzrf6t"];
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=dnr7gjmesk2tm5vmvvvzrf6t";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%@", object);
    }];
    
}


@end
