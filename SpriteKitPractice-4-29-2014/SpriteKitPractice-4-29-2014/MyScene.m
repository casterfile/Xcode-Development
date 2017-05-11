//
//  MyScene.m
//  SpriteKitPractice-4-29-2014
//
//  Created by Milk Communications on 4/29/14.
//  Copyright (c) 2014 Anthony Castor. All rights reserved.
//


//Importing MyScene.h
#import "MyScene.h"
//Importing EndScene.h
#import "EndScene.h"
//import WinScene.h
#import "WinScene.h"


//adding my own scene
@interface MyScene()

//adding a paddle on the scene
@property (nonatomic) SKSpriteNode *paddle;

@end


//this is my code this is for the colition here we define a category
//difining unsign integer
static const uint32_t ballCategory = 0x1;
static const uint32_t brickCategory = 0x1 << 1;
static const uint32_t paddleCategory = 0x1 << 2;
static const uint32_t edgeCategory = 0x1 << 3;
static const uint32_t bottomEdgeCategory = 0x1 << 4;

/*
 the about is going to handle the contact
 we are fliping the bit so that xcode will know what category we are fliping
 by the way this is a 32bit so we have only use a for bit 28bits left
 */


//this part is for holding the variable of the SKAction in this case it is a sound
SKAction *playSFXPaddle;
SKAction *playSFXBrick;
SKAction *playbg;



//Variable that will going to track the game
int live = 0;
int BricksToWin = 0;

//this is created by the Xcode
//implementing myscene
@implementation MyScene


//this is the init Function this is the first function to run
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        //set the inisial value of the varialble
        BricksToWin = 12;
        
        /* Setup your scene here */
        self.backgroundColor = [SKColor whiteColor];
        
        //add a physics body to the scene
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        
        //adding the edge screen to the edgeCategory
        self.physicsBody.categoryBitMask = edgeCategory;
        
        //change gravity setting of the physics world
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        
        //where we are calling the contactDelegate to test the contact in the scene
        self.physicsWorld.contactDelegate = self;
        
        //this will import the sound to the scene
        playSFXPaddle = [SKAction playSoundFileNamed:@"blip.caf" waitForCompletion:NO];
        playSFXBrick = [SKAction playSoundFileNamed:@"brickhit.caf" waitForCompletion:NO];
        
        
        [self addBall:size];
        [self addPlayer:size];
        [self addBricks:size];
        [self addBottomEdge:size];
        //playbg = [SKAction playSoundFileNamed:@"bgmusic.caf" waitForCompletion:NO];
        //[self runAction:playbg];

        
        
    }
    return self;
}


//here we are testing if there is contact
//this is a function for testing contact in the scene
-(void)didBeginContact:(SKPhysicsContact *)contact{
    
    SKPhysicsBody *notTheBall;
    //creating placeholder reference for the "non Ball" object
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        notTheBall = contact.bodyB;
    }else{
        notTheBall = contact.bodyA;
    }
    
    //checking if we have a contact to the brick
    if (notTheBall.categoryBitMask == brickCategory) {
        [self runAction:playSFXBrick];
        [notTheBall.node removeFromParent];
        
        //this will check if we win the game
        //create an instance of the EndScene
        if (BricksToWin <= 1) {
            WinScene *WinGame = [WinScene sceneWithSize:self.size];
            //Changing the current scene to the end scene
            //[self.view presentScene:end transition:[SKTransition doorwayWithDuration:1.0]];
            [self.view presentScene:WinGame transition:[SKTransition doorsOpenHorizontalWithDuration:1.0]];
            
        }else{
            BricksToWin--;
        }
        NSLog(@"Live is %i", BricksToWin);
    }
    
    //checking if we have a contact to the paddle
    if (notTheBall.categoryBitMask == paddleCategory) {
        [self runAction:playSFXPaddle];
        
    }
    
    //checking if we have a contact to the bottom edge of the screen
    if (notTheBall.categoryBitMask == bottomEdgeCategory) {
        //if (live == 1) {
        
        //create an instance of the EndScene
        EndScene *end = [EndScene sceneWithSize:self.size];
        //Changing the current scene to the end scene
        //[self.view presentScene:end transition:[SKTransition doorwayWithDuration:1.0]];
        [self.view presentScene:end transition:[SKTransition doorsCloseHorizontalWithDuration:1.0]];
        
        /*}else{
         live--;
         }
         NSLog(@"Live is %i", live);
         */
    }
    
}

//this function will handle the buttom edge of the scene
-(void) addBottomEdge:(CGSize)size{
    SKNode *bottomEdge = [SKNode node];
    bottomEdge.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointMake(0, 1) toPoint:CGPointMake(size.width, 1)];
    bottomEdge.physicsBody.categoryBitMask = bottomEdgeCategory;
    [self addChild:bottomEdge];
}


//this is the function on handling the ball on the scene
- (void)addBall:(CGSize)size {
    //create a new sprite node image
    SKSpriteNode *ball = [SKSpriteNode spriteNodeWithImageNamed:@"orb0000"];
    
    
    //create a CGPoint for Position
    //CGPoint myPoint = CGPointMake(size.width/2, size.height/2); //size.width/2, 100
    //puting the ball on the paddle
    CGPoint myPoint = CGPointMake(size.width/2, 130);
    
    ball.position = myPoint;
    
    //add a physics body
    ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ball.frame.size.width/2];
    ball.physicsBody.friction = 0;
    ball.physicsBody.linearDamping = 0;
    ball.physicsBody.restitution = 1.0f;
    //adding the ball to the ballCategory
    ball.physicsBody.categoryBitMask = ballCategory;
    //testing the contact of the ball to the bricks
    ball.physicsBody.contactTestBitMask = brickCategory | paddleCategory | bottomEdgeCategory;
    //ball.physicsBody.collisionBitMask = edgeCategory | brickCategory;
    
    
    /*
     by default the colition is ON in all node in the scene
     we can change that by adding this line of code
     ball.physicsBody.collisionBitMask = brickCategory;
     here we are saying the we are no going to colide with the brick
     we can use this function to other game but not here
     */
    
    //get reference to the atlas
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"orb"];
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
    
    SKAction *glow = [SKAction animateWithTextures:orbTextures timePerFrame:0.1];
    SKAction *keepGlowing = [SKAction repeatActionForever:glow];
    
    [ball runAction:keepGlowing];
    
    
    //add  the sprite node to the scene
    [self addChild:ball];
    
    //create the vector this will handle the speed of the ball
    CGVector myVector = CGVectorMake(10, 10);
    
    //apply the vector
    [ball.physicsBody applyImpulse:myVector];
}

//create the bricks
-(void)addBricks:(CGSize)size{
    for (int i = 0; i<4; i++) {
        SKSpriteNode *brick = [SKSpriteNode spriteNodeWithImageNamed:@"brick"];
        
        //add a static physics body
        brick.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:brick.frame.size];
        brick.physicsBody.dynamic = NO;
        
        //adding brick to the brickcategory
        brick.physicsBody.categoryBitMask = brickCategory;
        
        //setting the location of the bricks
        int xPos = size.width/5 * (i+1);
        int yPox = size.height - 50;
        
        brick.position = CGPointMake(xPos, yPox);
        [self addChild:brick];
        
    }
    
    for (int i = 0; i<4; i++) {
        SKSpriteNode *brick = [SKSpriteNode spriteNodeWithImageNamed:@"brick"];
        
        //add a static physics body
        brick.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:brick.frame.size];
        brick.physicsBody.dynamic = NO;
        
        //adding brick to the brickcategory
        brick.physicsBody.categoryBitMask = brickCategory;
        
        //setting the location of the bricks
        int xPos = size.width/5 * (i+1);
        int yPox = size.height - 100;
        
        brick.position = CGPointMake(xPos, yPox);
        [self addChild:brick];
        
    }
    
    for (int i = 0; i<4; i++) {
        SKSpriteNode *brick = [SKSpriteNode spriteNodeWithImageNamed:@"brick"];
        
        //add a static physics body
        brick.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:brick.frame.size];
        brick.physicsBody.dynamic = NO;
        
        //adding brick to the brickcategory
        brick.physicsBody.categoryBitMask = brickCategory;
        
        //setting the location of the bricks
        int xPos = size.width/5 * (i+1);
        int yPox = size.height - 150;
        
        brick.position = CGPointMake(xPos, yPox);
        [self addChild:brick];
        
    }
}


//this will handel the control of the player on the paddle
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        CGPoint newPosition = CGPointMake(location.x, 100);
        
        //stop the paddle from going to far on the left
        if (newPosition.x < self.paddle.size.width/2) {
            newPosition.x   = self.paddle.size.width/2;
        }
        if (newPosition.x > self.size.width - (self.paddle.size.width/2)) {
            newPosition.x   = self.size.width - (self.paddle.size.width/2);
        }
        self.paddle.position = newPosition;
    }
}



//this will handle the player
-(void)addPlayer:(CGSize)size{
    //create paddle sprite
    self.paddle = [SKSpriteNode spriteNodeWithImageNamed:@"paddle" ];
    //position the paddle
    self.paddle.position = CGPointMake(size.width/2, 100);
    //add a physics body
    self.paddle.physicsBody= [SKPhysicsBody bodyWithRectangleOfSize:self.paddle.frame.size];
    
    //make the paddle static
    self.paddle.physicsBody.dynamic = NO;
    
    //adding paddle to the paddleCategory
    self.paddle.physicsBody.categoryBitMask = paddleCategory;
    
    
    //add to scene
    [self addChild:self.paddle];
    
}




-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end