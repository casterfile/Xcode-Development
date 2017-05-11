//
//  MyScene.m
//  AVAudioPlayer
//
//  Created by Anon on 7/9/14.
//  Copyright (c) 2014 Anthony Castor. All rights reserved.
//

#import "MyScene.h"
@implementation MyScene
AVAudioPlayer *player;
BOOL setOnOff = true;

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"bgmusic" ofType:@"caf"]];
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        
        

    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches)
    {
        
        if (setOnOff == true)
        {
            [player play];
            [player setNumberOfLoops: INFINITY];
            setOnOff = false;
        }
        else
        {
            //[player stop];
            [player pause];
            setOnOff = true;
        }
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
