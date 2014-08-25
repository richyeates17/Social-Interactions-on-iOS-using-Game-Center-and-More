//
//  GameData.h
//  Quantum Space Runner
//
//  Created by Richard Yeates on 2/24/2014.
//  Copyright (c) 2014 Richard Yeates. All rights reserved.
//

#import <Foundation/Foundation.h>
@import GameKit;

@interface GameData : NSObject

//audio properties

@property (nonatomic, assign) bool isSoundFXOn;
@property (nonatomic, assign) bool isMusicOn;

//game scores
@property (nonatomic, assign) int highScore;

//Game Center
@property (nonatomic, assign) BOOL isGameCenterEnabled;

@property (nonatomic, assign) UIViewController* inGameViewController;


+(GameData*) sharedData;

//game data
-(void)readDataFromPlist;
-(void)saveDataToPlist:(NSString *)theValue :(NSString *)forTheKey;

//music methods
-(void) playSoundFX:(NSString *)fileToPlay;
-(void) playBackgroundMusic:(NSString *)fileToPlay :(float)volume;
-(void) stopBackgroundMusic;


@end
