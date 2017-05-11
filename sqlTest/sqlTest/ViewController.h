//
//  ViewController.h
//  sqlTest
//
//  Created by Anon on 7/21/14.
//  Copyright (c) 2014 Anthony Castor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "Person.h"

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *ageField;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

- (IBAction)addPersonButton:(id)sender;
- (IBAction)displayPersonButton:(id)sender;
- (IBAction)deletePersonButton:(id)sender;

@end
