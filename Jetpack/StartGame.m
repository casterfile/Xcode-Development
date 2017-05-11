//
//  StartGame.m
//  flappy-bird
//
//  Created by Anon on 5/15/14.
//  Copyright (c) 2014 Anthony Castor. All rights reserved.
//

#import "MyScene.h"
#import "StartGame.h"
#import "EndGame.h"

/*********************************************************************************************************************************
 *********************************************************************************************************************************
This part is for the variable
 *********************************************************************************************************************************
 *********************************************************************************************************************************/


//contact variable
static const uint32_t playerCategory = 0x1;
static const uint32_t missileCategory  = 0x1 << 1;

//variable
SKSpriteNode *player;
SKSpriteNode *missile1;
SKSpriteNode *missile2;
SKSpriteNode *missile3;
SKSpriteNode *missile4;
SKSpriteNode *missile5;
SKEmitterNode *jetengine;
SKEmitterNode *missileengine1;
SKEmitterNode *missileengine2;
SKEmitterNode *missileengine3;
SKEmitterNode *missileengine4;
SKEmitterNode *missileengine5;
SKEmitterNode *explosion;
SKLabelNode *lblScore, *lblHighScore;
int score, scoreSave, nanoSec, nanoMin, nanoHour;
int booster;
int delay;
int randomLevel, randomMissile1,randomMissile2,randomMissile3,randomMissile4,randomMissile5;
int levelChangeCount;
BOOL playerDead;
BOOL touching;
BOOL startPlay;


//label of the game
SKLabelNode *lblYouLose;
@implementation StartGame


/*********************************************************************************************************************************
 *********************************************************************************************************************************
This will handle the main function that handle the game
 *********************************************************************************************************************************
 *********************************************************************************************************************************/


-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        //setting the status of the game
        SKView *skView = (SKView *)self.view;
        skView.showsFPS = YES;
        skView.showsNodeCount = false;
        startPlay = NO;
        playerDead = NO;
        delay = 0;
        booster = 0;
        nanoSec = 0; nanoMin = 0; nanoHour = 0;
        score = 0;
        scoreSave = 0;
        levelChangeCount = 0;
        
        //variable setting
        touching = NO;
        player = [SKSpriteNode spriteNodeWithImageNamed:@"jetpack"];
        missile1 = [SKSpriteNode spriteNodeWithImageNamed:@"missile"];
        missile2 = [SKSpriteNode spriteNodeWithImageNamed:@"missile"];
        missile3 = [SKSpriteNode spriteNodeWithImageNamed:@"missile"];
        missile4 = [SKSpriteNode spriteNodeWithImageNamed:@"missile"];
        missile5 = [SKSpriteNode spriteNodeWithImageNamed:@"missile"];
        
        // add bg
        SKSpriteNode *bg = [SKSpriteNode spriteNodeWithImageNamed:@"nightskyNoStarts"];
        
        bg.position = CGPointMake(size.width/2, size.height/2);
        [self addChild:bg];
        
        SKSpriteNode *stars1 = [SKSpriteNode spriteNodeWithImageNamed:@"stars"];
        stars1.position = CGPointMake(size.width/2, size.height/2);
        [self addChild:stars1];
        
        SKSpriteNode *stars2 = [SKSpriteNode spriteNodeWithImageNamed:@"stars"];
        stars2.position = CGPointMake(size.width*2, size.height/2);
        [self addChild:stars2];
        
        SKSpriteNode *stars3 = [SKSpriteNode spriteNodeWithImageNamed:@"stars"];
        stars3.position = CGPointMake(size.width*2, size.height/4);
        [self addChild:stars3];
        
        SKSpriteNode *stars4 = [SKSpriteNode spriteNodeWithImageNamed:@"stars"];
        stars4.position = CGPointMake(size.width/2, size.height/5);
        [self addChild:stars4];
        
        SKSpriteNode *stars5 = [SKSpriteNode spriteNodeWithImageNamed:@"stars"];
        stars5.position = CGPointMake(size.width/2, size.height/5);
        [self addChild:stars5];


        
        //bg animation
        SKAction *moveBGstars1 = [SKAction moveByX:size.width-(size.width*3) y:0 duration:10];
        SKAction *moveBackBGstars1 = [SKAction moveToX:self.size.width+100 duration:0];
        SKAction *backAndForthBGstars1 =[SKAction sequence:@[moveBGstars1,moveBackBGstars1]];
        SKAction *repeaterBGstars1 = [SKAction repeatActionForever:backAndForthBGstars1];
        [stars1 runAction:repeaterBGstars1];
        [stars3 runAction:repeaterBGstars1];
        
        SKAction *moveBGstars2 = [SKAction moveByX:size.width-(size.width*3) y:0 duration:15];
        SKAction *moveBackBGstars2 = [SKAction moveToX:self.size.width+100 duration:0];
        SKAction *backAndForthBGstars2 =[SKAction sequence:@[moveBGstars2,moveBackBGstars2]];
        SKAction *repeaterBGstars2 = [SKAction repeatActionForever:backAndForthBGstars2];
        [stars2 runAction:repeaterBGstars2];
        [stars4 runAction:repeaterBGstars2];
        
        SKAction *moveBGstars3 = [SKAction moveByX:size.width-(size.width*3) y:0 duration:5];
        SKAction *moveBackBGstars3 = [SKAction moveToX:self.size.width+100 duration:0];
        SKAction *backAndForthBGstars3 =[SKAction sequence:@[moveBGstars3,moveBackBGstars3]];
        SKAction *repeaterBGstars3 = [SKAction repeatActionForever:backAndForthBGstars3];
        [stars5 runAction:repeaterBGstars3];
        
        
        
        
        //add emitter
        jetengine = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle]pathForResource:@"EngineParticle" ofType:@"sks"]];
        jetengine.numParticlesToEmit = 1;
        missileengine1 = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle]pathForResource:@"missileEngineParticle" ofType:@"sks"]];
        missileengine2 = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle]pathForResource:@"missileEngineParticle" ofType:@"sks"]];
        missileengine3 = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle]pathForResource:@"missileEngineParticle" ofType:@"sks"]];
        missileengine4 = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle]pathForResource:@"missileEngineParticle" ofType:@"sks"]];
        missileengine5 = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle]pathForResource:@"missileEngineParticle" ofType:@"sks"]];
        
        explosion = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle]pathForResource:@"explosive" ofType:@"sks"]];
        
        
        //calling functions
        [self playerFunction:size];
        [self MissileFunction:size];
        [self OutPutScoreLabel];
        //physicsWorld
        self.physicsWorld.gravity = CGVectorMake(0, -1);
        self.physicsWorld.contactDelegate = self;
        
    }
    return self;
}


/*********************************************************************************************************************************
 *********************************************************************************************************************************
This will handle the Player
 *********************************************************************************************************************************
 *********************************************************************************************************************************/


- (void)playerFunction:(CGSize)size
{
    // add spaceships
    player.position = CGPointMake(size.width/2-100, size.height/2);
    player.scale = 0.2;
    player.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:player.size];
    player.physicsBody.categoryBitMask = playerCategory;
    player.physicsBody.contactTestBitMask = missileCategory;
    player.physicsBody.collisionBitMask =0;
    [self addChild:player];
    
    //set position
    jetengine.position = CGPointMake(-35, 0);
    [player addChild:jetengine];
    
}

-(void)playerDeadFunction:(CFTimeInterval)currentTime
{
    if (playerDead == true)
    {
        delay++;
        if (delay >= 50)
        {
            [self PlayeScoreWrite];
            
        }
        
    }
}


-(void)PlayeScoreRead
{
    
    
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    
    NSString* currentScoreKey = @"currentScore";
    
    if([preferences objectForKey:currentScoreKey] == nil)
    {
        //  Doesn't exist.
        scoreSave = 0;
    }
    else
    {
        //  Get current level
        const NSInteger currentScore = [preferences integerForKey:currentScoreKey];
        scoreSave = currentScore;
    }
    
}

-(void)PlayeScoreWrite
{
    [self PlayeScoreRead];
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    
    NSString* currentScoreKey = @"currentScore";
    NSString* highScoreKey = @"highScore";
    
    if (scoreSave < score)
    {
        const NSInteger currentScore = score;
        [preferences setInteger:currentScore forKey:currentScoreKey];
        const NSInteger highScore = 1;
        [preferences setInteger:highScore forKey:highScoreKey];
        //NSLog(@"High");
    }
    else
    {
        const NSInteger highScore = 0;
        [preferences setInteger:highScore forKey:highScoreKey];
         //NSLog(@"Low");
    }
    
    
    const BOOL didSave = [preferences synchronize];
    
    if(!didSave)
    {
        //  Couldn't save (I've never seen this happen in real world testing)
        NSLog(@"Save is not working Please fix it");
    }
    //go to other page
    EndGame *end = [EndGame sceneWithSize:self.size];
    [self.view presentScene:end];
    //[self.view presentScene:end transition:[SKTransition doorsOpenHorizontalWithDuration:1.0]];
}




-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /* Called when a touch begins */
    touching = YES;
    //play the sound
    //SKAction *JetpackEngineSound = [SKAction playSoundFileNamed:@"jetpacEngineSound.caf" waitForCompletion:NO];
    //SKAction *RepeatForever = [SKAction repeatActionForever:];
    //[self runAction:JetpackEngineSound];
    
    
}


-(void)jetEngineEmiterFunction
{
    if (touching)
    {
        jetengine.numParticlesToEmit = 0;
    }
    else
    {
        jetengine.numParticlesToEmit = 100;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    touching = NO;
    
}


/*********************************************************************************************************************************
 *********************************************************************************************************************************
This will handle the Enemy Function
 *********************************************************************************************************************************
 *********************************************************************************************************************************/


- (void)MissileFunction:(CGSize)size
{
    
    //adding contact to the game
    missile1.physicsBody.categoryBitMask = missileCategory;
    missile2.physicsBody.categoryBitMask = missileCategory;
    missile3.physicsBody.categoryBitMask = missileCategory;
    missile4.physicsBody.categoryBitMask = missileCategory;
    missile5.physicsBody.categoryBitMask = missileCategory;
    
    //add level
    randomLevel = rand()%3+1;
    NSLog(@"LevelChange %i", randomLevel);
    if (randomLevel == 1)
    {
        randomMissile1 = 2;
        randomMissile2 = 4;
        randomMissile3 = 7;
        randomMissile4 = 9;
        randomMissile5 = 8;
        [self LevelOneFunction:size];
    }
    else if(randomLevel == 2)
    {
        randomMissile1 = 5;
        randomMissile2 = 3;
        randomMissile3 = 6;
        randomMissile4 = 6;
        randomMissile5 = 10;
        [self LevelOneFunction:size];
    }
    else if(randomLevel == 3)
    {
        randomMissile1 = 10;
        randomMissile2 = 4;
        randomMissile3 = 9;
        randomMissile4 = 2;
        randomMissile5 = 10;
        [self LevelOneFunction:size];
    }
    
    
    missile1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:missile1.size];
    missile2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:missile2.size];
    missile3.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:missile3.size];
    missile4.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:missile4.size];
    missile5.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:missile5.size];
    
    missile1.physicsBody.dynamic = NO;
    missile2.physicsBody.dynamic = NO;
    missile3.physicsBody.dynamic = NO;
    missile4.physicsBody.dynamic = NO;
    missile5.physicsBody.dynamic = NO;
    //set position
    missileengine1.position = CGPointMake(280, 0);
    missileengine2.position = CGPointMake(280, 0);
    missileengine3.position = CGPointMake(280, 0);
    missileengine4.position = CGPointMake(280, 0);
    missileengine5.position = CGPointMake(280, 0);
    
    [missile1 addChild:missileengine1];
    [missile2 addChild:missileengine2];
    [missile3 addChild:missileengine3];
    [missile4 addChild:missileengine4];
    [missile5 addChild:missileengine5];
    
}


-(void)LevelOneFunction:(CGSize)size
{
    [self Missile1Property:size];
    [self Missile2Property:size];
    [self Missile3Property:size];
    [self Missile4Property:size];
    [self Missile5Property:size];
}

-(void)Missile1Property:(CGSize)size
{
    //***************************************Missile 1
    // add Missile
    missile1.position = CGPointMake(size.width/2+300, size.height/2);
    missile1.scale = 0.1;
    
    [self addChild:missile1];
    
    //missile.physicsBody.dynamic;
    //CGVector missileForce = CGVectorMake(20, 20);
    //[missile.physicsBody applyImpulse:missileForce];
    //[missile.physicsBody applyForce:CGVectorMake(-7000, 10)];
    
    SKAction *move = [SKAction moveByX:size.width-(size.width*3) y:0 duration:randomMissile1+rand()%5];
    //SKAction *moveBack = [move reversedAction];
    SKAction *moveBack = [SKAction moveToX:self.size.width+100 duration:0];
    SKAction *Invisible = [SKAction fadeAlphaTo:0 duration:0];
    SKAction *Visible = [SKAction fadeAlphaTo:1 duration:0];
    SKAction *wait = [SKAction waitForDuration:randomMissile1+rand()%5];
    SKAction *backAndForth =[SKAction sequence:@[wait,move,wait,Invisible,moveBack,Visible]];
    SKAction *repeater = [SKAction repeatActionForever:backAndForth];
    [missile1 runAction:repeater];
    //***************************************Missile 1 End
}


-(void)Missile2Property:(CGSize)size
{
    //***************************************Missile 2
    // add Missile
    missile2.position = CGPointMake(size.width/2+300, (size.height/2)+100);
    missile2.scale = 0.1;
    
    [self addChild:missile2];
    
    SKAction *move2 = [SKAction moveByX:size.width-(size.width*3) y:0 duration:randomMissile2+rand()%5];
    //SKAction *moveBack2 = [move2 reversedAction];
    SKAction *moveBack2 = [SKAction moveToX:self.size.width+100 duration:0];
    SKAction *Invisible2 = [SKAction fadeAlphaTo:0 duration:0];
    SKAction *Visible2 = [SKAction fadeAlphaTo:1 duration:0];
    SKAction *wait2 = [SKAction waitForDuration:randomMissile2+rand()%5];
    SKAction *backAndForth2 =[SKAction sequence:@[wait2,move2,wait2,Invisible2,moveBack2,Visible2]];
    SKAction *repeater2 = [SKAction repeatActionForever:backAndForth2];
    [missile2 runAction:repeater2];
    
    //***************************************Missile 2 End
}

-(void)Missile3Property:(CGSize)size
{
    //***************************************Missile 3
    // add Missile
    missile3.position = CGPointMake(size.width/2+300, (size.height/2)+200);
    missile3.scale = 0.1;
    
    [self addChild:missile3];
    
    SKAction *move3 = [SKAction moveByX:size.width-(size.width*3) y:0 duration:randomMissile3+rand()%5];
    //SKAction *moveBack3 = [move3 reversedAction];
    SKAction *moveBack3 = [SKAction moveToX:self.size.width+100 duration:0];
    SKAction *Invisible3 = [SKAction fadeAlphaTo:0 duration:0];
    SKAction *Visible3 = [SKAction fadeAlphaTo:1 duration:0];
    SKAction *wait3 = [SKAction waitForDuration:randomMissile3+rand()%5];
    SKAction *backAndForth3 =[SKAction sequence:@[wait3,move3,wait3,Invisible3,moveBack3,Visible3]];
    SKAction *repeater3 = [SKAction repeatActionForever:backAndForth3];
    [missile3 runAction:repeater3];
    
    //***************************************Missile 3 End
}

-(void)Missile4Property:(CGSize)size
{
    //***************************************Missile 4
    // add Missile
    missile4.position = CGPointMake(size.width/2+300, (size.height/2)-100);
    missile4.scale = 0.1;
    
    [self addChild:missile4];
    
    SKAction *move4 = [SKAction moveByX:size.width-(size.width*3) y:0 duration:randomMissile4+rand()%5];
    //SKAction *moveBack4 = [move4 reversedAction];
    SKAction *moveBack4 = [SKAction moveToX:self.size.width+100 duration:0];
    SKAction *Invisible4 = [SKAction fadeAlphaTo:0 duration:0];
    SKAction *Visible4 = [SKAction fadeAlphaTo:1 duration:0];
    SKAction *wait4 = [SKAction waitForDuration:randomMissile4+rand()%5];
    SKAction *backAndForth4 =[SKAction sequence:@[wait4,move4,wait4,Invisible4,moveBack4,Visible4]];
    SKAction *repeater4 = [SKAction repeatActionForever:backAndForth4];
    [missile4 runAction:repeater4];
    
    //***************************************Missile 4 End
}

-(void)Missile5Property:(CGSize)size
{
    //***************************************Missile 5
    // add Missile
    missile5.position = CGPointMake(size.width/2+300, (size.height/2)-200);
    missile5.scale = 0.1;
    
    [self addChild:missile5];
    
    
    SKAction *move5 = [SKAction moveByX:size.width-(size.width*3) y:0 duration:randomMissile5+rand()%5];
    //SKAction *moveBack5 = [move5 reversedAction];
    SKAction *moveBack5 = [SKAction moveToX:self.size.width+100 duration:0];
    SKAction *Invisible5 = [SKAction fadeAlphaTo:0 duration:0];
    SKAction *Visible5 = [SKAction fadeAlphaTo:1 duration:0];
    SKAction *wait5 = [SKAction waitForDuration:randomMissile5+rand()%5];
    SKAction *backAndForth5 =[SKAction sequence:@[wait5,move5,wait5,Invisible5,moveBack5,Visible5]];
    SKAction *repeater5 = [SKAction repeatActionForever:backAndForth5];
    [missile5 runAction:repeater5];
    
    
    //***************************************Missile 5 End
}

/*********************************************************************************************************************************
 *********************************************************************************************************************************
This will handle the Game function like scoring etc.
 *********************************************************************************************************************************
 *********************************************************************************************************************************/


-(void)CheckIfYourIsTouchingTheScreen
{
    /* Called before each frame is rendered */
    if (touching)
    {
        [player.physicsBody applyForce:CGVectorMake(0, 150)];
        //location of the character
    }
    else
    {
        [player.physicsBody applyForce:CGVectorMake(0, 0)];
    }
}

-(void)CheckIfUserOfTheScreen
{
    //end the game if the player is below the screen
    if (player.position.y <= -20 || player.position.x <= -20) {
        [self PlayeScoreWrite];
        
    }
}


-(void)CheckIfThePlayerIsOnTheTopLimitOfTheScreen
{
    //top limit
    if (player.position.y > self.size.height-(player.size.height/2)) {
        touching = NO;
        player.position = CGPointMake(self.size.width/2-100, self.size.height-(player.size.height/2));
    }
}


-(void)ScoreOutput
{
    nanoSec++;
    if (nanoSec >= 60) {
        nanoSec = 0;
        score++;
        //NSString *stringScore = [@(score) stringValue];
        //[lblScore setText:stringScore];
        lblScore.text = [NSString stringWithFormat:@"Score: %i", score];
    }

}


-(void)OutPutScoreLabel
{
    
    //setting the propertice of the label
    lblScore = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
    //lblScore.text = @"Score = ";

    lblScore.fontColor = [SKColor whiteColor];
    lblScore.fontSize = 18;
    lblScore.position = CGPointMake(self.size.width-50, self.size.height-30);
    lblScore.text = [NSString stringWithFormat:@"Score: %i", score];
    [self addChild:lblScore];
    
    
    [self PlayeScoreRead];
    //setting the propertice of the label
    lblHighScore = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
    
    lblHighScore.fontColor = [SKColor whiteColor];
    lblHighScore.fontSize = 18;
    lblHighScore.position = CGPointMake(90, self.size.height-30);
    lblHighScore.text = [NSString stringWithFormat:@"High Score: %i", scoreSave];
    [self addChild:lblHighScore];
}


/*********************************************************************************************************************************
 *********************************************************************************************************************************
This handle the default function
 *********************************************************************************************************************************
 *********************************************************************************************************************************/


-(void)update:(CFTimeInterval)currentTime
{
    
    [self CheckIfYourIsTouchingTheScreen];
    [self CheckIfUserOfTheScreen];
    [self CheckIfThePlayerIsOnTheTopLimitOfTheScreen];
    [self ScoreOutput];
    [self jetEngineEmiterFunction];
    
    [self playerDeadFunction:currentTime];
    
}


-(void)didBeginContact:(SKPhysicsContact *)contact
{
    
    if (contact.bodyA.categoryBitMask == playerCategory || contact.bodyB.categoryBitMask == playerCategory)
    {
        
        playerDead = true;
        explosion.position = player.position;
        [self addChild:explosion];
        explosion.numParticlesToEmit = 500;
        [contact.bodyA.node removeFromParent];
        [contact.bodyB.node removeFromParent];
    }
    
}
@end


/*
 SKAction *wait = [SKAction waitForDuration:0.5];
 SKAction *performSelector = [SKAction performSelector:@selector(fireMethod:) onTarget:self];
 SKAction *sequence = [SKAction sequence:@[performSelector, wait]];
 SKAction *repeat   = [SKAction repeatActionForever:sequence];
 [self runAction:repeat];
 
 */




