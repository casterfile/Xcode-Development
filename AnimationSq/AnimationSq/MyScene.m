//
//  MyScene.m
//  AnimationSq
//
//  Created by Anon on 6/11/14.
//  Copyright (c) 2014 Anthony Castor. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        //setting up physicsworld
        self.backgroundColor = [SKColor blackColor];
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        
        //SKVariable
        SKSpriteNode *player;
        player = [SKSpriteNode spriteNodeWithImageNamed:@"bunny0000"];
        // add spaceships
        player.scale = 1;
        player.physicsBody.dynamic = NO;
        //player.zRotation = M_PI/-2.0f;//look to the right
        player.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:player.size];
        //player.position = CGPointMake(20, (self.size.height/2)+yPosition);
        player.position = CGPointMake((self.size.width/2), 60);
        //player.physicsBody.dynamic = NO;
        [self addChild:player];
        
        //get reference to the atlas
        SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"bunny"];
        //get all image filenames
        NSArray *orbImageNames = [atlas textureNames];
        //sort the filenames
        NSArray *sortedNames = [orbImageNames sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        //create an array to hold image textures
        NSMutableArray *orbTextures = [NSMutableArray array];
        
        for(NSString *filename in sortedNames){
            SKTexture *texture = [atlas textureNamed:filename];
            [orbTextures addObject:texture];
        }
        SKAction *glow = [SKAction animateWithTextures:orbTextures timePerFrame:0.05];
        SKAction *keepGlowing = [SKAction repeatActionForever:glow];
        
        [player runAction:keepGlowing];
        


    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
