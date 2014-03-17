//
//  MovieList.h
//  RottenTomatoes
//
//  Created by Nicolas Halper on 3/15/14.
//  Copyright (c) 2014 Nicolas Halper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Movie.h"

@interface MovieList : NSObject

- (void)add:(Movie *)movie atTop:(BOOL)atTop;
- (Movie *)get:(NSUInteger)index;
- (MovieList *) filterContentForSearchText:(NSString*)searchText;

- (int) count;

@end
