//
//  HelloScene.m
//  SpriteTestEDGame
//
//  Created by mcm2737 on 9/29/13.
//  Copyright (c) 2013 Absolutely Learning. All rights reserved.
//

#import "HelloScene.h"
#import "SpaceShip.h"

@interface HelloScene()
@property BOOL contentCreated;
@end

@implementation HelloScene

// creates the textbox and centers it with given properties
- (SKLabelNode *)newHelloNode
{
    SKLabelNode *helloNode = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
    helloNode.text = @"Space Game Simulator";
    
    // set to describe the node and discover it later
    helloNode.name = @"helloNode";
    
    helloNode.fontSize = 42;
    
    helloNode.fontColor = [SKColor blueColor];
    
    helloNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    
    return helloNode;
}

// sets Scene Contents notice each child can call a separate method
- (void)createSceneContents
{
    self.backgroundColor = [SKColor whiteColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    [self addChild: [self newHelloNode]];
}

- (void)didMoveToView:(SKView *)view
{
    if (!self.contentCreated)
    {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}

- (void)touchesBegan:(NSSet *) touches withEvent:(UIEvent *)event
{
    SKNode *helloNode = [self childNodeWithName:@"helloNode"];
    
    if (helloNode != nil)
    {
        // to prevent the node from responding to repeated presses the name is cleared
        helloNode.name = nil;
        
        SKAction *moveUp = [SKAction moveByX: 0 y: 75.0 duration: 0.5];
        SKAction *rotate = [SKAction rotateByAngle:70 duration:0.25];
        SKAction *zoom = [SKAction scaleTo:1.85 duration: 0.25];
        SKAction *pause = [SKAction waitForDuration:0.5];
        SKAction *fadeAway = [SKAction fadeOutWithDuration: 0.25];
        SKAction *remove = [SKAction removeFromParent];
        SKAction *moveSequence = [SKAction sequence:@[moveUp,rotate, zoom,pause,fadeAway,remove]];
        
        [helloNode runAction: moveSequence completion:^{
            
            SKScene *spaceshipScene = [[SpaceShip alloc]initWithSize:self.size];
            SKTransition *doors = [SKTransition doorsOpenVerticalWithDuration:0.75];
            
            [self.view presentScene:spaceshipScene transition:doors];
            
        }];
    }
}


@end
