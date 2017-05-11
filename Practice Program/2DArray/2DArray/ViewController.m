//
//  ViewController.m
//  2DArray
//
//  Created by Anon on 9/12/14.
//  Copyright (c) 2014 Anthony Castor. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
     NSString *twoDimensionalArray[5][10];
	// Do any additional setup after loading the view, typically from a nib.
    twoDimensionalArray[0][0] = @"Hello1";
    twoDimensionalArray[0][1] = @"Hello2";
    twoDimensionalArray[0][2] = @"Hello3";
    twoDimensionalArray[0][3] = @"Hello4";
    twoDimensionalArray[0][4] = @"Hello5";
    
    
    NSLog(@"%@", twoDimensionalArray[0][0]);
    NSLog(@"%@", twoDimensionalArray[0][1]);
    NSLog(@"%@", twoDimensionalArray[0][2]);
    NSLog(@"%@", twoDimensionalArray[0][3]);
    NSLog(@"%@", twoDimensionalArray[0][4]);
    
    twoDimensionalArray[1][0] = @"1Hello1";
    twoDimensionalArray[1][1] = @"1Hello2";
    twoDimensionalArray[1][2] = @"1Hello3";
    twoDimensionalArray[1][3] = @"1Hello4";
    twoDimensionalArray[1][4] = @"1Hello5";
    
    NSLog(@"%@", twoDimensionalArray[1][0]);
    NSLog(@"%@", twoDimensionalArray[1][1]);
    NSLog(@"%@", twoDimensionalArray[1][2]);
    NSLog(@"%@", twoDimensionalArray[1][3]);
    NSLog(@"%@", twoDimensionalArray[1][4]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
