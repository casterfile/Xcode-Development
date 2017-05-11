//
//  DetailViewController.h
//  Master Detail Appplication
//
//  Created by Anon on 12/8/14.
//  Copyright (c) 2014 Anthony Castor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
