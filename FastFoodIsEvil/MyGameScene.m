//
//  MyGameScene.m
//  FastFoodIsEvil
//
//  Created by Mac User on 23.08.15.
//  Copyright (c) 2015 Nikolay Shubenkov. All rights reserved.
//

#import "MyGameScene.h"

typedef NS_ENUM(NSInteger, MyGameSceneState){
    MyGameSceneStateInitial,
    MyGameSceneStateReady,
    MyGameSceneStateDragging
};

@interface MyGameScene ()

@property (nonatomic) BOOL didInitContent;
@property (nonatomic) MyGameSceneState state;
@property (nonatomic, weak) SKPhysicsBody *bodyToThrow;
@property (nonatomic, weak) SKNode *nodeToThrow;
@property (nonatomic) CGPoint startDragPosition;

@end

@implementation MyGameScene

#pragma mark - Setup

-(void)didMoveToView:(SKView *)view
{
    if (self.didInitContent == NO) {
        [self initContent];
    }
    }
-(void)initContent
{
    SKPhysicsBody *border = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsBody = border;
    [self runAction:[SKAction waitForDuration:1] completion:^{
        self.didInitContent = YES;
        [self updateState];
    }];
}

#pragma mark - UpdateState
-(void)updateState{
    switch (self.state) {
        case MyGameSceneStateInitial:{
            [self putNodeToBallPosition:[self nextObjectToThrow]];
            
        }break;
            
        case MyGameSceneStateReady:
            
            break;
            
        default:
            NSParameterAssert(NO);
            break;
    }
}

#pragma mark - Touch Handling

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    switch (self.state) {
        case MyGameSceneStateReadyToThrow:{
            
        }UITouch *anyTouch = [touches anyObject];
            CGPoint touchCoordinate = [anyTouch locationInNode:self];
            if ([self nodesAtPoint:touchCoordinate] == self.nodeToThrow) {
                self.startDragPosition = touchCoordinate;
                self.state = MyGameSceneStateDragging;
            }
    }break;
        default:
            break;
    }
    

}


-(void)putNodeToBallPosition:(SKNode *)aNode{
    self.nodeToThrow = aNode;
    self.bodyToThrow = aNode.physicsBody;
    aNode.physicsBody = nil;
    [aNode runAction:[SKAction moveTo:CGPointMake(150, 200) duration:0.25] completion:^{
    self.state = MyGameSceneStateInitial;
         }];
}

-(SKNode *)nextObjectToThrow{
    SKNode *meatBall = [self childNodeWithName:@"meatBall"];
    NSParameterAssert(meatBall);
    return meatBall;
}
@end
