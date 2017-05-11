//
//  MyScene.m
//  flappy-bird
//
//  Created by Anon on 5/13/14.
//  Copyright (c) 2014 Anthony Castor. All rights reserved.
//

#import "MyScene.h"
#import "EndGame.h"
#import "StartGame.h"


@implementation MyScene

-(instancetype)initWithSize:(CGSize)size
{
    SKLabelNode *lblYouLose;
    SKLabelNode *lblTryAgain;
    
    
    if (self = [super initWithSize:size]) {
        
        //change the color of the scene
        self.backgroundColor = [SKColor blackColor];
        
        //play the sound
        //SKAction *SNDPlay = [SKAction playSoundFileNamed:@"gameover.caf" waitForCompletion:NO];
        //[self runAction:SNDPlay];
        
        //setting the propertice of the label
        lblYouLose = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
        lblYouLose.text = @"Start Game!";
        lblYouLose.fontColor = [SKColor whiteColor];
        lblYouLose.fontSize = 50;
        lblYouLose.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:lblYouLose];
        //NSLog(@"bottom");
        
        //create a level for try again to tab to go and play
        lblTryAgain = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
        lblTryAgain.text = @"Tap to start the GAME";
        lblTryAgain.fontColor = [SKColor whiteColor];
        lblTryAgain.fontSize = 24;
        lblTryAgain.position = CGPointMake(self.size.width/2, - 50);
        
        //this adding the animation to the tryagain label
        SKAction *movelabel = [SKAction moveToY:(size.height/2 -50) duration:2.0];
        //this will going to run the animation in the label
        [lblTryAgain runAction:movelabel];
        
        
        [self addChild:lblTryAgain];
        //NSLog(@"hellow world");
        
    }
    
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //StartGame *StartGame = [StartGame sceneWithSize:self.size];
    //[self.view presentScene:StartGame transition:[SKTransition doorsOpenHorizontalWithDuration:1.0]];
    
    //this will handle the local notification
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:60];
    localNotification.alertBody = @"Do You Want To Play Again!";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    
    StartGame *Start = [StartGame sceneWithSize:self.size];
    [self.view presentScene:Start transition:[SKTransition doorsOpenHorizontalWithDuration:1.0]];

    
}


@end
