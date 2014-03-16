//
//  MovieList.m
//  RottenTomatoes
//
//  Created by Nicolas Halper on 3/15/14.
//  Copyright (c) 2014 Nicolas Halper. All rights reserved.
//

#import "MovieList.h"

@interface MovieList()

@property (strong,nonatomic) NSMutableArray *movies; // of Movie

@end

@implementation MovieList

- (NSMutableArray *)movies
{
    if (!_movies) _movies = [[NSMutableArray alloc] init];
    return _movies;
}

- (void)add:(Movie *)movie atTop:(BOOL)atTop
{
    if (atTop) {
        [self.movies insertObject:movie atIndex:0];
    } else {
        [self.movies addObject:movie];
    }
    NSLog(@"added movie to list %@",movie);
}

- (Movie *) get:(NSUInteger) index
{
    return [self.movies objectAtIndex:index];
}

- (int) count
{
    return [self.movies count];
}



@end
