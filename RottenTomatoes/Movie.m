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
        //NSLog("title: %@",dictionary[@"title"]);
        self.thumbUrl = dictionary[@"posters"][@"thumbnail"];
        self.fullImageUrl = dictionary[@"posters"][@"profile"];
        self.summary = dictionary[@"synopsis"];
        
        NSDictionary *cast = dictionary[@"abridged_cast"];
        NSMutableString *castString = [NSMutableString string];
        
        NSLog(@"Cast %@ %d members",cast,cast.count);
        
        for (NSDictionary* castItem in cast) {
            NSLog(@"Cast item %@",castItem[@"name"]);
            [castString appendFormat:@"%@,",castItem[@"name"]];
        }
        
        self.cast = [castString substringToIndex:[castString length]-1];//dictionary[@"abridged_cast"];
    }
    return self;
}


@end
