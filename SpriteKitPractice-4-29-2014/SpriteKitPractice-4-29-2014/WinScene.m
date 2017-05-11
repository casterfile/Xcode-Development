//
//  WinScene.m
//  SpriteKitPractice-4-29-2014
//
//  Created by Tony Castor on 5/1/14.
//  Copyright (c) 2014 Anthony Castor. All rights reserved.
//

#import "WinScene.h"
#import "MyScene.h"


@implementation WinScene

-(instancetype)initWithSize:(CGSize)size{
    //creating a label using SKLabelNode
    SKLabelNode *lblYouWin;
    SKLabelNode *lblPlayAgain;
    
    if (self = [super initWithSize:size]) {
        
        //change the color of the scene
        self.backgroundColor = [SKColor blackColor];
        
        //play the sound
        //SKAction *SNDPlay = [SKAction playSoundFileNamed:@"gameover.caf" waitForCompletion:NO];
        //[self runAction:SNDPlay];
        
        if (lblYouWin != NULL) {
            [lblYouWin removeFromParent];
            //remove the lblYouWin LabEl from the scene
            //NSLog(@"Remove Lable");
        }
        lblYouWin = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
        lblYouWin.text = @"YOU WIN!";
        lblYouWin.fontColor = [SKColor whiteColor];
        lblYouWin.fontSize = 50;
        lblYouWin.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:lblYouWin];
        //NSLog(@"bottom");
        
        //create a level for try again to tab to go and play
        lblPlayAgain = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
        lblPlayAgain.text = @"Tap to play again";
        lblPlayAgain.fontColor = [SKColor whiteColor];
        lblPlayAgain.fontSize = 24;
        lblPlayAgain.position = CGPointMake(self.size.width/2, - 50);
        
        //this adding the animation to the tryagain label
        SKAction *movelabel = [SKAction moveToY:(size.height/2 -50) duration:2.0];
        //this will going to run the animation in the label
        [lblPlayAgain runAction:movelabel];
        
        
        [self addChild:lblPlayAgain];
    }
    return self;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    MyScene *firstScene = [MyScene sceneWithSize:self.size];
    [self.view presentScene:firstScene transition:[SKTransition doorsOpenHorizontalWithDuration:1.0]];
    
}


@end
