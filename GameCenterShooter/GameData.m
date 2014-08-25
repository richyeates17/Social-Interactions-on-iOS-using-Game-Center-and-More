//
//  GameData.m
//  Quantum Space Runner
//
//  Created by Richard Yeates on 2/24/2014.
//  Copyright (c) 2014 Richard Yeates. All rights reserved.
//

#import "GameData.h"
@import AVFoundation;

@implementation GameData{
    
    NSString *path;
    AVAudioPlayer *_backgroundMusicPlayer;
    AVAudioPlayer *_soundEffectPlayer;
}

static GameData* sharedData = nil;

+(GameData*) sharedData {
    
    if (sharedData == nil) {
        
        sharedData = [[GameData alloc] init];
        
    }
    
    return sharedData;
    
}

-(id) init {
    
    
    if (self = [super init]) {
        
        sharedData = self;
        
        NSError *error;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
        NSString *documentsDirectory = [paths objectAtIndex:0]; //2
        path = [documentsDirectory stringByAppendingPathComponent:@"GameData.plist"];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if (![fileManager fileExistsAtPath: path])
        {
            NSString *bundle = [[NSBundle mainBundle] pathForResource:@"GameData" ofType:@"plist"];
            
            [fileManager copyItemAtPath:bundle toPath: path error:&error];
        }
        
        
        
        self.isMusicOn = YES;
        self.isSoundFXOn = YES;
    }
    
    return self;
}

//Save Local Data

-(void)readDataFromPlist
{
    NSMutableDictionary *GameDataDict = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    
    self.highScore = [[GameDataDict objectForKey:@"HighScore"]intValue];
    
}

-(void)saveDataToPlist:(NSString *)theValue :(NSString *)forTheKey
{
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    
    [data setObject:theValue forKey:forTheKey];
    
    [data writeToFile: path atomically:YES];
    
}

//Sound Control

-(void) playSoundFX:(NSString *)fileToPlay
{
    if (self.isSoundFXOn) {
        NSError *error;
        NSURL * soundEffectURL = [[NSBundle mainBundle] URLForResource:fileToPlay withExtension:nil];
        _soundEffectPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundEffectURL error:&error];
        _soundEffectPlayer.numberOfLoops = 0;
        _soundEffectPlayer.volume = 0.5;
        [_soundEffectPlayer prepareToPlay];
        [_soundEffectPlayer play];
    }
}

-(void) playBackgroundMusic:(NSString *)fileToPlay :(float)volume
{
    if (self.isMusicOn) {
        NSError *error;
        NSURL *backgroundMusicURL = [[NSBundle mainBundle] URLForResource:fileToPlay withExtension:nil];
        _backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
        _backgroundMusicPlayer.numberOfLoops = -1;
        _backgroundMusicPlayer.volume = volume;
        [_backgroundMusicPlayer prepareToPlay];
        
        [_backgroundMusicPlayer play];
    }
}

-(void) stopBackgroundMusic
{
    [_backgroundMusicPlayer stop];
}



 
@end
