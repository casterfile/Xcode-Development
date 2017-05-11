//
//  MyScene.m
//  TimerCount
//
//  Created by Anon on 5/16/14.
//  Copyright (c) 2014 Anthony Castor. All rights reserved.
//

#import "MyScene.h"

//
//  SLMyScene.m
//  CountdownTimer
//
//  Created by Steven Lipton on 4/8/14.
//  Copyright (c) 2014 Steven Lipton. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene
{
    SKLabelNode *countDown;
    BOOL startGamePlay;
    NSTimeInterval startTime;
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        //Make a label for the timer
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        countDown = [SKLabelNode labelNodeWithFontNamed:@"Futura-Medium"];
        countDown.fontSize = 50;
        countDown.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)*0.85);
        countDown.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter; //good for positioning with other sprites
        countDown.fontColor = [SKColor whiteColor ];
        countDown.name = @"countDown";
        countDown.zPosition = 100;
        [self addChild:countDown];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a toruch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if (CGRectContainsPoint(countDown.frame, location)){
            startGamePlay = YES;
        }
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    /*code for beginning animation before game play ,and the start game */
    
    //reset counter if starting
    if (startGamePlay){
        startTime = currentTime;
        startGamePlay = NO;
    }
    
    int countDownInt = (int)(currentTime-startTime);
    if(countDownInt>0){  //if counting down to 0 show counter
        countDown.text = [NSString stringWithFormat:@"%i", countDownInt];
    }else { //if not show message, dismiss, whatever you need to do.
        countDown.text=@"GO!";
        /* code here runs every frame --
         Try not to put animations here, unless
         you can fire them once only or fire them through good timing.
         */
    }
}

@end
