//
//  MyScene.m
//  Animation
//
//  Created by Anon on 5/25/14.
//  Copyright (c) 2014 Anthony Castor. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene
SKSpriteNode *feet;

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        feet = [SKSpriteNode spriteNodeWithImageNamed:@"missile"];
        [self enemyFunction:size];
        //[self groupAnimation];
    }
    return self;
}

-(void)groupAnimation
{
    feet.position = CGPointMake(self.size.width/2, self.size.height/2);
    feet.scale = 0.2;
    CGFloat circumference = feet.size.height * M_PI;
    SKAction *oneRevolution = [SKAction rotateByAngle:-M_PI*2 duration:2.0];
    SKAction *moveRight = [SKAction moveByX:circumference y:0 duration:2.0];
    SKAction *group = [SKAction group:@[oneRevolution, moveRight]];
    [self addChild:feet];
    [feet runAction:group];
}


-(void)enemyFunction:(CGSize)size
{
    //Setting up the enemy
    feet.scale = 0.2;
    feet.zRotation = M_PI/2.0f;
    feet.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:feet.size];
    //setting position of the enemy
    feet.position = CGPointMake(size.width/2, size.height-20);
    feet.physicsBody.dynamic = NO;
    [self addChild:feet];
    
    
    //adding a animation to a node
    SKAction *actionMoveUp = [SKAction moveToY:2 * self.size.height / 3 duration:0.5];
    actionMoveUp.timingMode = SKActionTimingEaseOut;
    
    SKAction *actionMoveDown = [SKAction moveToY:self.size.height / 2 duration:0.5];
    actionMoveDown.timingMode = SKActionTimingEaseIn;
    
    SKAction *actionMoveUpHalf = [SKAction moveToY:self.size.height duration:1];
    actionMoveUp.timingMode = SKActionTimingEaseOut;
    
    [feet runAction:[SKAction repeatActionForever:[SKAction sequence:@[actionMoveUp,actionMoveDown,actionMoveUpHalf,actionMoveDown]]]];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
