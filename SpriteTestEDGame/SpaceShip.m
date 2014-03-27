//
//  SpaceShip.m
//  SpriteTestEDGame
//
//  Created by mcm2737 on 9/30/13.
//  Copyright (c) 2013 Absolutely Learning. All rights reserved.
//

#import "SpaceShip.h"
#import "SpriteTestEDGameViewController.h"

@interface SpaceShip ()
@property BOOL contentCreated;
@end


@implementation SpaceShip


- (void)didMoveToView:(SKView *)view
{
    if(!self.contentCreated)
    {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}

static inline CGFloat skRandf(){
    return rand() / (CGFloat) RAND_MAX;
}

static inline CGFloat skRand(CGFloat low, CGFloat high) {
    return skRandf() * (high - low) + low;
}

- (void)addRock
{
    // init item
    SKSpriteNode *rock = [SKSpriteNode spriteNodeWithImageNamed:@"boltonMeteorite.png"];
    
    // init contact info
    static const uint32_t rockCategory = 0x1 << 0;
    rock.physicsBody.contactTestBitMask = rockCategory;
    
    // init size
    rock.xScale = 0.08;
    rock.yScale = 0.08;
    
    // randomly place rock
    rock.position = CGPointMake(skRand(0,self.size.width), self.size.height-50);
    
    // set size of physics body
    rock.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rock.size];
    // give it a name for later recall and recognition
    rock.name = @"rock";
    // turn its collision abilities on
    rock.physicsBody.usesPreciseCollisionDetection = YES;
    // bounces it off the space ship so it has less of tendency to stop
    rock.physicsBody.restitution = 0.5;
    
    [self addChild:rock];
}


- (void)createSceneContents
{
    self.backgroundColor = [SKColor blackColor];
    self.scaleMode = SKSceneScaleModeAspectFit;

    // create contact Delegate
    
    SKSpriteNode *spaceship = [self newSpaceShip];
    
    spaceship.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame)-150);
    
    
    SKAction *makeRocks = [SKAction sequence:@[
                                            [SKAction performSelector:@selector(addRock) onTarget:self],
                                            [SKAction waitForDuration:0.20 withRange:0.15]
                                                 ]];
    [self runAction: [SKAction repeatActionForever:makeRocks]];
    
    [self addChild:spaceship];
    
}


- (SKSpriteNode *)newSpaceShip
{
    SKSpriteNode *hull = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship.png"];
    
    // store start position
    //float startX  = CGRectGetMidX(self.frame);
    //float startY  = CGRectGetMidY(self.frame);
    CGPoint startPosition = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame)+250);
    
    // size graphic
    hull.xScale = 0.25;
    hull.yScale = 0.25;
    
    // to size physics body
    hull.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:hull.size];
    
    // to stop gravity and give the ship some strength but keep dynamics
    hull.physicsBody.dynamic = YES;// physics body is turned off
    hull.physicsBody.allowsRotation = NO;
    hull.physicsBody.affectedByGravity = NO;
    hull.physicsBody.mass = 10;
    
    hull.name = @"ss";
    // detect collisions turned on
    hull.physicsBody.usesPreciseCollisionDetection = YES;
    // init for contact test

    SKSpriteNode *light1 = [self newLight];
    light1.position = CGPointMake(-40.0, 120.0);
    [hull addChild:light1];
    
    SKSpriteNode *light2 = [self newLight];
    light2.position = CGPointMake(40.0, 120.0);
    [hull addChild:light2];
    
    
    SKAction *hover = [SKAction sequence:@[
                                           [SKAction waitForDuration: 1.0],
                                           [SKAction moveByX: 100.0 y:70.0 duration: 1.0],
                                           [SKAction waitForDuration:1.0],
                                           [SKAction moveByX: -100.0 y:70.0 duration: 1.0],
                                           [SKAction waitForDuration:1.0],
                                           [SKAction moveByX: -100.0 y:70.0 duration: 1.0],
                                           [SKAction waitForDuration:1.0],
                                           [SKAction moveByX: 100.0 y:70.0 duration: 1.0],
                                           [SKAction waitForDuration:0.1],
                                           // find top middle again
                                           [SKAction moveTo:startPosition duration:0.5]
                                            ]];
    
    
    [hull runAction: [SKAction repeatActionForever:hover]];
    
    
    return hull;
}


- (SKSpriteNode *)newLight
{
    SKSpriteNode *light = [[SKSpriteNode alloc] initWithColor:[SKColor yellowColor] size:CGSizeMake(20,70)];
    
    SKAction *blink = [SKAction sequence:@[
                                           [SKAction fadeOutWithDuration:0.5],
                                           [SKAction fadeInWithDuration:0.5]
                                           //[SKAction colorizeWithColor:[SKColor whiteColor] colorBlendFactor:0.2 duration:0.15],
                                           ]];
    
    SKAction *blinkForever = [SKAction repeatActionForever:blink];
    
    [light runAction:blinkForever];
    
    return light;
}


- (void)didSimulatePhysics  // to get rid of rocks after they fall off the screen
{
    [self enumerateChildNodesWithName:@"rock" usingBlock:^(SKNode *node, BOOL *stop) {
        // remove when nodes go off screen
        if (node.position.y < 0){
            [node removeFromParent];
        }
    }];
    
}


@end
