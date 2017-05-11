//
//  GameViewController.m
//  Panning
//
//  Created by Anon on 12/11/14.
//  Copyright (c) 2014 Anthony Castor. All rights reserved.
//
#import "PanGestureScene.h"
//#import "LineNode.h"

@interface PanGestureScene()

@property (nonatomic)CGPoint start;
@property (nonatomic)CGPoint end;

@end

@implementation PanGestureScene

- (id)initWithSize:(CGSize)size {
    
    if (self = [super initWithSize:size]) {
        
    }
    return self;
}

- (void)didMoveToView:(SKView *)view {
    UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
    [[self view] addGestureRecognizer:gestureRecognizer];
}

- (void)handlePanFrom:(UIPanGestureRecognizer *)recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        self.start = [recognizer locationInView:recognizer.view];
        self.start = [self convertPointFromView:self.start];
        
        // Remove
        [[self childNodeWithName:@"samurai"] removeFromParent];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        //NSLog(@"Change");
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded) {
        self.end = [recognizer locationInView:recognizer.view];
        self.end = [self convertPointFromView:self.end];
        
        NSLog(@"start (%f, %f), end(%f, %f)", self.start.x, self.start.y, self.end.x, self.end.y);
        
        SKSpriteNode *Bg1 = [SKSpriteNode spriteNodeWithImageNamed:@"backbutton"];
        Bg1.name = @"samurai";
        [self addChild:Bg1];
    }
}
@end



