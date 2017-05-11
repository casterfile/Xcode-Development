//
//  MyScene.m
//  PlayerSound
//
//  Created by Anon on 7/9/14.
//  Copyright (c) 2014 Anthony Castor. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene
SKAction *musicBG;

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        musicBG = [SKAction playSoundFileNamed:@"bgmusic.caf" waitForCompletion:NO];
        [self runAction:musicBG];
    
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches)
    {
        
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
