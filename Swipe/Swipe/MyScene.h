//
//  MyScene.h
//  Swipe
//

//  Copyright (c) 2014 Anthony Castor. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MyScene : SKScene <UIGestureRecognizerDelegate>  {
    
    UISwipeGestureRecognizer* swipeRightGesture;
    
    UIRotationGestureRecognizer* rotationGR;
    
}

@end
