//
//  MasterViewController.h
//  Master Detail Appplication
//
//  Created by Anon on 12/8/14.
//  Copyright (c) 2014 Anthony Castor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
