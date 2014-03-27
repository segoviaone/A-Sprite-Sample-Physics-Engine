//
//  SpriteTestEDGameViewController.m
//  SpriteTestEDGame
//
//  Created by mcm2737 on 9/29/13.
//  Copyright (c) 2013 Absolutely Learning. All rights reserved.
//

#import "SpriteTestEDGameViewController.h"
#import "SpriteTestEDGameMyScene.h"
#import "HelloScene.h"
#import "SpaceShip.h"


@implementation SpriteTestEDGameViewController

- (void)viewWillAppear:(BOOL)animated
{
    HelloScene* hello = [[HelloScene alloc] initWithSize:CGSizeMake(768,1024)];
    SKView *spriteView = (SKView *) self.view;
    [spriteView presentScene: hello];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;

    
    // Create and configure the scene.
    SKScene * scene = [SpriteTestEDGameMyScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}




@end
