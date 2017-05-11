//
//  MyScene.m
//  flopyClone
//
//  Created by Anon on 6/13/14.
//  Copyright (c) 2014 Anthony Castor. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene
SKSpriteNode *player;

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        
        //world physics
        self.physicsWorld.gravity = CGVectorMake(0, -1);
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsBody.dynamic = NO;
        
        
        //background image
        SKSpriteNode *bg = [SKSpriteNode spriteNodeWithImageNamed:@"bg"];
        bg.position = CGPointMake(size.width/2, size.height/2);
        bg.scale = 0.52;
        [self addChild:bg];
        
    

        
        
        player = [SKSpriteNode spriteNodeWithImageNamed:@"bird"];
        
        
        //call the function
        [self playerFunction:size];
        
        
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches)
    {
        [player.physicsBody applyForce:CGVectorMake(0, 250)];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}


/*********************************************************************************************************************************
 *********************************************************************************************************************************
 This will handle the Player
 *********************************************************************************************************************************
 *********************************************************************************************************************************/

-(void)playerFunction:(CGSize)size
{
    player.position = CGPointMake(size.width/2 -100, size.height/2);
    player.scale = 0.8;
    player.physicsBody.dynamic = NO;
    player.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:player.size];
    
    
    [self addChild:player];
}



@end
