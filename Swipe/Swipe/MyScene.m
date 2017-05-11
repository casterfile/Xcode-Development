//
//  MyScene.m
//  Swipe
//
//  Created by Anon on 5/20/14.
//  Copyright (c) 2014 Anthony Castor. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene
SKLabelNode *moveTest;
int xPosition, yPosition;

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        //setting up the varible
        xPosition = 0;
        yPosition = 0;
        /* Setup your scene here */
        moveTest = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
        moveTest.fontColor = [SKColor whiteColor];
        moveTest.fontSize = 18;
        moveTest.position = CGPointMake(self.size.width/2, self.size.height/2);
        moveTest.text = [NSString stringWithFormat:@"Score: %i", 20];
        [self addChild:moveTest];
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /* Called when a touch begins */
   
    
}


- (void)didMoveToView:(SKView *)view
{
    UISwipeGestureRecognizer *recognizerSwipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeUp:)];
    recognizerSwipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    UISwipeGestureRecognizer *recognizerSwipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeDown:)];
    recognizerSwipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    UISwipeGestureRecognizer *recognizerSwipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeft:)];
    recognizerSwipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    UISwipeGestureRecognizer *recognizerSwipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRight:)];
    recognizerSwipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    
    [[self view] addGestureRecognizer:recognizerSwipeUp];
    [[self view] addGestureRecognizer:recognizerSwipeDown];
    [[self view] addGestureRecognizer:recognizerSwipeLeft];
    [[self view] addGestureRecognizer:recognizerSwipeRight];
}

- (void)handleSwipeUp:(UISwipeGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        /*
        CGPoint touchLocation = [sender locationInView:sender.view];
        touchLocation = [self convertPointFromView:touchLocation];
        SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchLocation];
        
        NSLog(@"%@", touchedNode);
         */
        NSLog(@"Swipe Up!");
        yPosition += 10;
    }
}

- (void)handleSwipeDown:(UISwipeGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        NSLog(@"Swipe Down!");
        yPosition-= 10;
    }
}

- (void)handleSwipeLeft:(UISwipeGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        NSLog(@"Swipe Left!");
        xPosition-= 10;
    }
}


- (void)handleSwipeRight:(UISwipeGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        NSLog(@"Swipe Right!");
        xPosition+= 10;
    }
}
-(void)update:(CFTimeInterval)currentTime
{
    /* Called before each frame is rendered */
    moveTest.position = CGPointMake((self.size.width/2)+xPosition, (self.size.height/2)+yPosition);
}

@end
