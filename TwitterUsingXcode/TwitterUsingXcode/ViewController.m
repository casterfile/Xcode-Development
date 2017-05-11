//
//  ViewController.m
//  TwitterUsingXcode
//
//  Created by Anon on 5/22/14.
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showTwitterSheet:(id)sender {
    //this is for twitter
    //TWTweetComposeViewController *twitterSheet = [[TWTweetComposeViewController alloc] init];
    //[self presentModalViewController:twitterSheet animated:YES];
    
    //this is for facebook
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:@"First post from my iPhone app"];
        [self presentViewController:controller animated:YES completion:Nil];
    
    
}
@end
