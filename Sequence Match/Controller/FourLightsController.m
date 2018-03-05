//
//  fourLights.m
//  Sequence Match
//
//  Created by Ted Boardman on 2/25/18.
//  Copyright © 2018 Ted Boardman. All rights reserved.
//

#import "FourLightsController.h"

@interface FourLightsController()
@property (nonatomic,readwrite) double delay;
@property (nonatomic,readwrite) NSUInteger score;
@property (nonatomic,readwrite) NSUInteger correctPresses;
@property (nonatomic,readwrite) NSUInteger incorrectPresses;
- (BOOL)finalSeuqnce;
@end

@implementation FourLightsController
@synthesize gameState = _gameState;
@synthesize delegate;

- (void)updateGameState:(NSUInteger )gameState {
    [self.delegate fourLightsControllerStateChange:self.gameState];
}


- (instancetype)init {
    self = [super init];
    
    if (self) {
       
        FourLights *fourLights = [[FourLights alloc] init];
        _fourLights = fourLights;
        _delay = fourLights.delay;
     }

    return self;
}


// Mark: Setters and getters

- (void)setGameState:(NSUInteger)gState {
    _gameState = gState;
    // This is delegate message to view upon game state change
    [self updateGameState:gState];
}

- (NSUInteger)gameState {
    return _gameState;
}

- (BOOL)finalSeuqnce {
    if (self.fourLights.gameRound  == [self.fourLights.gameSequences count]) {
        return YES;
    } else {
        return NO;
    }
}

- (void)scoreTouched:(NSString *)padIdentifier {
    NSUInteger nextInSequence = [self nextInSequenceIncrementRound:YES];
    if ([padIdentifier intValue] == nextInSequence) {
        self.correctPresses++;
        self.score++;
    } else {
        self.incorrectPresses++;
    }
    
    if (self.correctPresses == [[self fourLights] currentSequenceCount]) {
        self.correctPresses = 0;
        self.incorrectPresses = 0;
        self.gameState = ([self finalSeuqnce] ? SMEND : SMPERFECT);
        
    } else if (self.correctPresses + self.incorrectPresses == [[self fourLights] currentSequenceCount]) {
        self.correctPresses = 0;
        self.incorrectPresses = 0;
        self.gameState = ([self finalSeuqnce] ? SMEND : SMNEXT );
    }
}


- (NSUInteger)nextInSequenceIncrementRound:(BOOL)resetRound {
    if (self.fourLights.gameRound == [self.fourLights.gameSequences count]) {
        return 0;
    }
    
    NSUInteger currentSequenceCount = [[self fourLights] currentSequenceCount];
    NSUInteger currentIndex = [[self fourLights] sequenceIndex];
    
    if (currentIndex < currentSequenceCount) {
        if (currentIndex == 0 && resetRound == NO) self.gameState = SMOBSERVE;
        
        NSUInteger nextItemToReturn = [[self fourLights] nextSequenceItem];
        
        self.fourLights.sequenceIndex++;
        if (self.fourLights.sequenceIndex == currentSequenceCount) {
           self.gameState = SMBEGIN;
            if (self.fourLights.gameRound  < [self.fourLights.gameSequences count]) {
               if (resetRound) {
                   self.fourLights.gameRound++;
               }
               
               
            }
            self.fourLights.sequenceIndex = 0;
        }
        return nextItemToReturn;
    }
    return 0;
}

@end
