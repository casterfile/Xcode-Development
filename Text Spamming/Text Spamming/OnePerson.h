//
//  ViewController.h
//  Text Spamming
//
//  Created by Anon on 29/01/2016.
//  Copyright © 2016 Anon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OnePerson : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *MassageNumber;
@property (strong, nonatomic) IBOutlet UITextField *MassageTimes;
@property (strong, nonatomic) IBOutlet UITextView *MassageBody;
@property (strong, nonatomic) IBOutlet UINavigationItem *TitleBar;
- (IBAction)SendMassage:(id)sender;

@end

