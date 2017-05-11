//
//  ViewController.m
//  TipAndTax
//
//  Created by Tony Castor on 5/4/14.
//  Copyright (c) 2014 Anthony Castor. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self displayTheKeyboard];
    
}

-(void)displayTheKeyboard
{
    [self.billAmount becomeFirstResponder];
}

-(void)dismissTheKeyboard
{
    [self.billAmount resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tipPercentChanged:(UISegmentedControl *)sender
{
    [self updateDisplayedTip];
    [self updateDisplayedTotal];
    [self dismissTheKeyboard];
} 

-(NSString *)formatCurrentcy:(float)amount
{
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    nf.numberStyle = NSNumberFormatterCurrencyStyle;
    NSNumber *number = [NSNumber numberWithFloat:amount];
    return [nf stringFromNumber:number];
}

-(void)displayTotalAmount:(float)amount
{

    self.billAmount.text = [self formatCurrentcy:amount];
}

-(void)displayTipAmount:(float)amount
{
    self.tipAmount.text = [self formatCurrentcy:amount];
}

-(float)calculateTipPercentageForSegment:(int)segment
{
    NSString *tipText = [self.tipPercent titleForSegmentAtIndex:segment];
    return [tipText floatValue] / 100.0;
}

-(float)getBillAmount
{
    return [self.billAmount.text floatValue];
}

-(float)calculateTipAmount:(float)amount percent:(float)percent
{
    return amount * percent;
}

-(void)updateDisplayedTip
{
    float amount = [self getBillAmount];
    int segment = self.tipPercent.selectedSegmentIndex;
    float percent = [self calculateTipPercentageForSegment:segment];
    float tip = [self calculateTipAmount:amount percent:percent];
    self.tipAmount.text = [self formatCurrentcy:tip];
}

-(void)updateDisplayedTotal
{
    float amount = [self getBillAmount];
    int segment = self.tipPercent.selectedSegmentIndex;
    float percent = [self calculateTipPercentageForSegment:segment];
    float tip = [self calculateTipAmount:amount percent:percent];
    self.totalAmount.text = [self formatCurrentcy:tip+amount];
}

@end
