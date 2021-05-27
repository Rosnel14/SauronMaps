//
//  GameViewController.m
//  SauronMaps
//
//  Created by Rosnel Leyva-Cortés on 5/20/21.
//

#import "GameViewController.h"
#import "GameScene.h"

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Load the SKScene from 'GameScene.sks'
    GameScene *scene = (GameScene *)[SKScene nodeWithFileNamed:@"GameScene"];
    
    // Set the scale mode to scale to fit the window
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    SKView *skView = (SKView *)self.view;
    
    // Present the scene
    [skView presentScene:scene];
    
    
    skView.showsFPS = NO;
    skView.showsNodeCount = NO;
}

- (BOOL)shouldAutorotate {
    return YES;
}

-(void)viewDidAppear:(BOOL)animated{
    //manipulate the display field
    [NSThread sleepForTimeInterval:5.0f]; //using this for pausing the app
    [self.DisplayField setText:@"Touch down to see Hobbinton to Mount Doom"];
  
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
