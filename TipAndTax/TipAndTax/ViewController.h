//
//  ViewController.h
//  TipAndTax
//
//  Created by Tony Castor on 5/4/14.
//  Copyright (c) 2014 Anthony Castor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *billAmount;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipPercent;
@property (weak, nonatomic) IBOutlet UITextField *tipAmount;
@property (weak, nonatomic) IBOutlet UITextField *totalAmount;

- (IBAction)tipPercentChanged:(UISegmentedControl *)sender;

-(void)displayTotalAmount:(float)amount;
-(float)calculateTipPercentageForSegment:(int)segment;
-(float)getBillAmount;
-(float)calculateTipAmount:(float)amount percent:(float)percent;
-(void)updateDisplayedTip;
-(void)updateDisplayedTotal;

@end
