//
//  MoviesViewController.h
//  RottenTomatoes
//
//  Created by Nicolas Halper on 3/13/14.
//  Copyright (c) 2014 Nicolas Halper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoviesViewController : UIViewController <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) NSString *apiURL;

@end
