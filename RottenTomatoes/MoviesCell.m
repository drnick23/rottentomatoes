//
//  MoviesCell.m
//  RottenTomatoes
//
//  Created by Nicolas Halper on 3/13/14.
//  Copyright (c) 2014 Nicolas Halper. All rights reserved.
//

#import "MoviesCell.h"

@implementation MoviesCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    if (highlighted) {
        NSLog(@"highlighted");
        self.titleLabel.textColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor blackColor];
        //self.textLabel.textColor = [UIColor whiteColor];
    } else {
        NSLog(@"unhighlighted");
        self.titleLabel.textColor = [UIColor blackColor];
        self.backgroundColor = [UIColor whiteColor];
        //self.textLabel.textColor = [UIColor blackColor];
    }
}

@end
