//
//  SandboxViewController.m
//  Sandbox
//
//  Created by Bill Weinman on 2010-10-28.
//  Copyright 2010 The BearHeart Group, LLC. All rights reserved.
//

#import "SandboxViewController.h"

@implementation SandboxViewController

@synthesize textView;

- (void) sandbox {
    message(@"Sandbox version %@", kBWUtilitiesVersion);
    [self testDatabase];
}

-(void) dispRow:(NSDictionary *) row {
    message(@"row %@ [%@]",
            [row objectForKey:@"title"],
            [row objectForKey:@"url"]
            );
}

-(void) testDatabase {
    RSSDB *db;
    NSString * dbfn = @"bwrss.db";
    
    db = [[RSSDB alloc] initWithRSSDBFilename:dbfn];
    message(@"RSSDB version %@", [db getVersion]);
    NSArray * feedIDs = [[NSArray alloc] initWithArray:[db getFeedIDs]];
    
    for (NSNumber *n in feedIDs) {
        NSDictionary *feed = [db getFeedRow:n];
        [self dispRow:feed];
    }
    [db release];
}

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    extern UITextView *messageTextView;
    messageTextView = textView;
    textView.font = [UIFont systemFontOfSize:12];
    [self sandbox];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
