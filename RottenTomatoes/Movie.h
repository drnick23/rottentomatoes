//
//  Movie.h
//  RottenTomatoes
//
//  Created by Nicolas Halper on 3/15/14.
//  Copyright (c) 2014 Nicolas Halper. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

-(id) initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *thumbUrl;
@property (nonatomic,strong) NSString *fullImageUrl;
@property (nonatomic,strong) NSString *summary;
@property (nonatomic,strong) NSString *cast;

@end
