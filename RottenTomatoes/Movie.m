//
//  Movie.m
//  RottenTomatoes
//
//  Created by Nicolas Halper on 3/15/14.
//  Copyright (c) 2014 Nicolas Halper. All rights reserved.
//

#import "Movie.h"

@implementation Movie

-(id) initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.title = dictionary[@"title"];
        self.thumbUrl = dictionary[@"posters"][@"thumbnail"];
        self.fullImageUrl = dictionary[@"posters"][@"profile"];
        self.summary = dictionary[@"synopsis"];
        
        // process the cast into a single string
        NSDictionary *cast = dictionary[@"abridged_cast"];
        NSMutableString *castString = [NSMutableString string];
        
        //NSLog(@"Cast %@ %d members",cast,cast.count);
        
        for (NSDictionary* castItem in cast) {
            NSLog(@"Cast item %@",castItem[@"name"]);
            [castString appendFormat:@"%@,",castItem[@"name"]];
        }
        
        // truncate last comma from castString and set into cast property
        self.cast = [castString substringToIndex:[castString length]-1];
    }
    return self;
}


@end
