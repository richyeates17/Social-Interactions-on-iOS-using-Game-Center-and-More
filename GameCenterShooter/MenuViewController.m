//
//  MenuViewController.m
//  GameCenterShooter
//
//  Created by Richard Yeates on 2014-08-24.
//  Copyright (c) 2014 Richard Yeates. All rights reserved.
//

#import "MenuViewController.h"

#import "ViewController.h"
#import "GameData.h"


@interface MenuViewController ()
{

}
@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [GameData sharedData];
    
    //Game Center Time!
    [self authenticateLocalPlayer];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)preferSatusbarHidden {
    return YES;
}

////Buttons

-(IBAction)startButtonPressed:(id)sender {
    
    if (![GameData sharedData].isGameCenterEnabled) {
        return;
    }
    ViewController *gameViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    [self.navigationController pushViewController:gameViewController animated:YES];

}

-(IBAction)gameCenterButtonPressed:(id)sender {
    
    GKGameCenterViewController *gameCenterViewController = [[GKGameCenterViewController alloc]init];
    gameCenterViewController.gameCenterDelegate = self;
    gameCenterViewController.viewState = GKGameCenterViewControllerStateDefault;
    [self presentViewController:gameCenterViewController animated:YES completion:nil];
    
}



//Game Center Methods

-(void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController {
    [gameCenterViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void)authenticateLocalPlayer{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    
    localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error){
    
        if (viewController != nil) {
            [self presentViewController:viewController animated:YES completion:nil];
        } else if ([GKLocalPlayer localPlayer].authenticated) {
                [GameData sharedData].isGameCenterEnabled = YES;
        } else {
                [GameData sharedData].isGameCenterEnabled = NO;
                NSString *string= @"Unable To log into Game Center. Please check your settings.";
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Uh Oh" message:string delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alert show];
        }
        
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
    };
}




@end
