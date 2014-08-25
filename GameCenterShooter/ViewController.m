//
//  ViewController.m
//  GameCenterShooter
//
//  Created by Richard Yeates on 2014-08-17.
//  Copyright (c) 2014 Richard Yeates. All rights reserved.
//

#import "ViewController.h"
#import "MyScene.h"

#import <Social/Social.h>

@interface ViewController ()
{

}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
 
}

-(void) viewWillLayoutSubviews{
    //You have to put the logic here because we are using a landscape view
    
    [super viewWillLayoutSubviews];
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = NO;
    skView.showsNodeCount = NO;
    
    // Create and configure the scene.
    SKScene * scene = [MyScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    [GameData sharedData].inGameViewController = self;

    // Present the scene.
    [skView presentScene:scene];
    
}


- (BOOL)preferSatusbarHidden {
    return YES;
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


#pragma Social

-(IBAction)tweetButtonPressed :(UIButton*)sender{
    [self tweetMessage:[NSString stringWithFormat:@"Hey, I just scored %d in this awesome game on iOS, Check it out!", 17]];
}

-(IBAction)facebookButtonPressed :(UIButton*)sender{
    [self facebookMessage:[NSString stringWithFormat:@"Hey, I just scored %d in this awesome game on iOS, Check it out!", 23]];
}

-(void)tweetMessage:(NSString*)message{
    //Check if Twitter is available
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        //Create a Network Session
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        //set the optional properties; initial textual message, image and optional URL link of the tweet
        [controller setInitialText:message];
        [controller addImage:[UIImage imageNamed:@"Icon-60.png"]];
        [controller addURL:[NSURL URLWithString:@"http://www.myURL.com"]];
        //present the view controller
        [self.navigationController presentViewController:controller animated:YES completion:nil];
        //Use completion Handler to determine outcome, and publish
        [controller setCompletionHandler:^(SLComposeViewControllerResult result){
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            NSString *string= [[NSString alloc]init];
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    string = @"Tweet was cancelled.";
                    break;
                case SLComposeViewControllerResultDone:
                    string = @"Tweet Sent!";
                    break;
                default:
                    break;
            }
            //Let user know the status of their post
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Twitter" message:string delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }];
    } else {
        //If post can't happen, send user to the system settings
        NSString *string = @"Unable to Post, Please check your settings";
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Twitter" message:string delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}

-(void)facebookMessage:(NSString*)text{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [controller setInitialText:text];
        [controller addImage:[UIImage imageNamed:@"Icon-60.png"]];
        [controller addURL:[NSURL URLWithString:@"http://www.myURL.com"]];
        [self.navigationController presentViewController:controller animated:YES completion:nil];
        [controller setCompletionHandler:^(SLComposeViewControllerResult result){
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            NSString *string= [[NSString alloc]init];
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    string = @"Post was cancelled";
                    break;
                case SLComposeViewControllerResultDone:
                    string = @"Post Complete!";
                    break;
                default:
                    break;
            }
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Facebook" message:string delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }];
    } else {
        NSString *string = @"Unable to Post, check your settings";
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Facebook" message:string delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}


@end
