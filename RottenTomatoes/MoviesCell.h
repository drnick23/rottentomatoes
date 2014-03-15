//
//  MoviesCell.h
//  RottenTomatoes
//
//  Created by Nicolas Halper on 3/13/14.
//  Copyright (c) 2014 Nicolas Halper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoviesCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UILabel *titleLabel;
@property (nonatomic,weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic,weak) IBOutlet UIImageView *thumbImageView;

@end
