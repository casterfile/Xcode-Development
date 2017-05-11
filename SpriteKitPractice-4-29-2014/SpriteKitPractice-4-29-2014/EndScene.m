//
//  EndScene.m
//  SpriteKitPractice-4-29-2014
//
//  Created by Milk Communications on 5/1/14.
//  Copyright (c) 2014 Anthony Castor. All rights reserved.
//

#import "EndScene.h"
#import "MyScene.h"


@implementation EndScene

-(instancetype)initWithSize:(CGSize)size{
    //creating a label using SKLabelNode
    SKLabelNode *lblYouLose;
    SKLabelNode *lblTryAgain;
    
    if (self = [super initWithSize:size]) {
        
        //change the color of the scene
        self.backgroundColor = [SKColor blackColor];
        
        //play the sound
        SKAction *SNDPlay = [SKAction playSoundFileNamed:@"gameover.caf" waitForCompletion:NO];
        [self runAction:SNDPlay];
        
        if (lblYouLose != NULL) {
            [lblYouLose removeFromParent];
            //remove the lblYoulose LabEl from the scene
            //NSLog(@"Remove Lable");
        }
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
        lblTryAgain.text = @"Tap to play again";
        lblTryAgain.fontColor = [SKColor whiteColor];
        lblTryAgain.fontSize = 24;
        lblTryAgain.position = CGPointMake(self.size.width/2, - 50);
        
        //this adding the animation to the tryagain label
        SKAction *movelabel = [SKAction moveToY:(size.height/2 -50) duration:2.0];
        //this will going to run the animation in the label
        [lblTryAgain runAction:movelabel];
        
        
        [self addChild:lblTryAgain];
    }
    return self;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    MyScene *firstScene = [MyScene sceneWithSize:self.size];
    [self.view presentScene:firstScene transition:[SKTransition doorsOpenHorizontalWithDuration:1.0]];
    
}


@end
