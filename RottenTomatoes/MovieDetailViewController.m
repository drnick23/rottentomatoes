//
//  MovieDetailViewController.m
//  RottenTomatoes
//
//  Created by Nicolas Halper on 3/15/14.
//  Copyright (c) 2014 Nicolas Halper. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MovieDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *castLabel;

@end

@implementation MovieDetailViewController

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
    
    //self.mainImage.
    self.summaryLabel.text = self.movie.summary;
    self.castLabel.text = self.movie.cast;
    NSURL *imageUrl = [NSURL URLWithString:self.movie.fullImageUrl];
    UIImage *placeholderImage = [UIImage imageNamed:@"MoviePlaceholder"];
    [self.mainImage setImageWithURL:imageUrl placeholderImage:placeholderImage];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
