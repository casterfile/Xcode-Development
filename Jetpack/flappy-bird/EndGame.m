//
//  EndGame.m
//  flappy-bird
//
//  Created by Anon on 5/14/14.
//  Copyright (c) 2014 Anthony Castor. All rights reserved.
//

#import "EndGame.h"
#import "MyScene.h"
#import "StartGame.h"

int score;
int testHighScore;

@implementation EndGame

-(void)PlayeScoreRead
{
    
    
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    
    NSString* currentScoreKey = @"currentScore";
    NSString* highScoreKey = @"highScore";
    
    if([preferences objectForKey:currentScoreKey] == nil)
    {
        //  Doesn't exist.
        score = 0;
    }
    else
    {
        //  Get current level
        const NSInteger currentScore = [preferences integerForKey:currentScoreKey];
        score = currentScore;
        const NSInteger highScore = [preferences integerForKey:highScoreKey];
        testHighScore = highScore;
    }
    
}

-(instancetype)initWithSize:(CGSize)size
{
    SKLabelNode *lblYouLose;
    SKLabelNode *lblTryAgain;
    
    [self PlayeScoreRead];
    
    
    if (self = [super initWithSize:size]) {
        
        //change the color of the scene
        self.backgroundColor = [SKColor blackColor];
        
        //play the sound
        //SKAction *SNDPlay = [SKAction playSoundFileNamed:@"gameover.caf" waitForCompletion:NO];
        //[self runAction:SNDPlay];
        
        //setting the propertice of the label
        lblYouLose = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
        lblYouLose.text = @"YOU LOSE!";
        lblYouLose.fontColor = [SKColor whiteColor];
        lblYouLose.fontSize = 50;
        lblYouLose.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:lblYouLose];
        //NSLog(@"bottom");
        
        //create a level for try again to tab to go and play
        lblTryAgain = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
        if (testHighScore == 1)
        {
            lblTryAgain.text = [NSString stringWithFormat:@"Your Score of %i is the high Score", score];
        }
        else
        {
            lblTryAgain.text = [NSString stringWithFormat:@"The Score %i is still the high Score", score];
            
        }
        //lblTryAgain.text = @"Tap to play again"; //with out intergir
        lblTryAgain.fontColor = [SKColor whiteColor];
        lblTryAgain.fontSize = 18;
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
    StartGame *firstScene = [StartGame sceneWithSize:self.size];
    [self.view presentScene:firstScene transition:[SKTransition doorsOpenHorizontalWithDuration:1.0]];
    
}

@end
