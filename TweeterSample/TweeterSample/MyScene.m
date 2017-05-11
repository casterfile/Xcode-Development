//
//  MyScene.m
//  TweeterSample
//
//  Created by Anon on 5/22/14.
//  Copyright (c) 2014 Anthony Castor. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {

    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    TWTweetComposeViewController *twitterSheet = [[TWTweetComposeViewController alloc] init];
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
