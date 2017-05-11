//
//  MyScene.m
//  SwipLeftRightDownUp
//
//  Created by Anon on 5/25/14.
//  Copyright (c) 2014 Anthony Castor. All rights reserved.
//
#import "MyScene.h"

@implementation MyScene
//SKVariable
SKLabelNode *moveTest;
SKSpriteNode *player;
//Premitive Variable
int xPosition, yPosition, movementSpeed;

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        //setting up the varible
        xPosition = 0;
        yPosition = 0;
        movementSpeed = 30;
        
        
        //setting up physicsworld
        self.backgroundColor = [SKColor whiteColor];
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        
        
        /* Setup your scene here */
        player = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        //player.position = CGPointMake(40, self.size.height/2);
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        
        //setting the function call
        [self playerFunction:size];
        
    }
    return self;
}


- (void)playerFunction:(CGSize)size
{
    // add spaceships
    player.scale = 0.1;
    //player.physicsBody.dynamic = NO;
    player.zRotation = M_PI/-2.0f;//look to the right
    player.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:player.size];
    player.position = CGPointMake(20, (self.size.height/2)+yPosition);
    [self addChild:player];
    
    
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

- (void)handleSwipeUp:(UISwipeGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        //NSLog(@"Swipe Up!");
        yPosition += movementSpeed;
        xPosition = 0;
        if (player.position.y+yPosition >= self.size.height-(player.size.width*4)+20) {
            
        }
        else
        {
            [self moveSpriteAnimation];
            player.zRotation = M_PI/-0.5f;//look to the up
        }
        
        [self resetXandY];
    }
}

- (void)handleSwipeDown:(UISwipeGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        //NSLog(@"Swipe Down!");
        yPosition-= movementSpeed;
        xPosition = 0;
        if (player.position.y+yPosition <= (player.size.width*4)-20) {
            
        }
        else
        {
            [self moveSpriteAnimation];
            player.zRotation = M_PI/-1.0f;//look to the down
        }
        [self resetXandY];
    }
}

- (void)handleSwipeLeft:(UISwipeGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        
        xPosition-= movementSpeed;
        yPosition = 0;
        if (player.position.x+xPosition <= 20) {
            
        }
        else
        {
            player.zRotation = M_PI/2;//look to the right
            [self moveSpriteAnimation];
        }
        [self resetXandY];
        
    }
}


- (void)handleSwipeRight:(UISwipeGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        xPosition+= movementSpeed;
        yPosition = 0;
        if (player.position.x+xPosition >= self.size.width-20) {
            
        }
        else
        {
            player.zRotation = M_PI/-2.0f;//look to the right
            [self moveSpriteAnimation];
        }
        [self resetXandY];
    }
    
}

-(void)resetXandY
{
    xPosition = 0;
    yPosition = 0;
}

-(void)moveSpriteAnimation
{
    SKAction *move = [SKAction moveTo:CGPointMake(player.position.x+xPosition, player.position.y+yPosition) duration:.5];
    [player runAction:move];
}
-(void)update:(CFTimeInterval)currentTime
{
    
    //player.position = CGPointMake((20)+xPosition, (self.size.height/2)+yPosition);
    //NSLog(@"Location %f", player.position.y);
    //NSLog(@"    high %f", self.size.height);
    
}

@end