//
//  fourLights.h
//  Sequence Match
//
//  Created by Ted Boardman on 2/25/18.
//  Copyright © 2018 Ted Boardman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FourLights.h"


@protocol FourLightsControllerDelegate <NSObject>
- (void)fourLightsControllerStateChange:(NSUInteger)gState;
@end


@interface FourLightsController : NSObject
@property (weak, nonatomic) id<FourLightsControllerDelegate> delegate;

@property (nonatomic) NSUInteger gameState;
@property (nonatomic,readonly) double delay;

@property (nonatomic,readonly) NSUInteger score;

@property (nonatomic,readonly) NSUInteger correctPresses;
@property (nonatomic,readonly) NSUInteger incorrectPresses;
@property (strong, nonatomic) FourLights *fourLights;

- (void)scoreTouched:(NSString *)padIdentifier;
- (NSUInteger)nextInSequenceIncrementRound:(BOOL)resetRound;

- (void)setGameState:(NSUInteger)gState;
- (NSUInteger)gameState;


typedef NS_ENUM(NSInteger, SMGAMESTATES) {
    SMDEFAULT,
    SMOBSERVE,
    SMBEGIN,
    SMPERFECT,
    SMNEXT,
    SMEND
};
@end
