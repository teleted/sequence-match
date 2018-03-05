//
//  FourLights.m
//  Sequence Match
//
//  Created by Ted Boardman on 2/25/18.
//  Copyright © 2018 Ted Boardman. All rights reserved.
//

#import "FourLights.h"

@implementation FourLights

  - (instancetype)init {
      self = [super init];
      
      if (self) {
          NSMutableArray *gameSequences = [[NSMutableArray alloc] init];
          // critical: assign underbar to another variable, don't try to do alloc init and assign in one line
          _gameSequences = gameSequences;
          _delay = 0.7;
          // not strictly necessary as ins default to zero, but helps document intent
          _sequenceIndex = 0;
          _gameRound = 0;
          
          _gameSequences[0] = @[@4, @2, @3, @1];
          _gameSequences[1] = @[@1, @2, @3, @4];
          _gameSequences[2] = @[@3, @1, @4, @1];
      }
      return self;
  }


- (NSUInteger)currentSequenceCount {
    if (self.gameRound >= [self.gameSequences count]) {
        return [self.gameSequences[self.gameRound -1] count];
    } else {
        return [self.gameSequences[self.gameRound] count];
    }
}


- (NSUInteger)sequenceItemAtIndex:(NSUInteger)index inRound:(NSUInteger)round {
    return [self.gameSequences[round][index] intValue];
}


- (NSUInteger)nextSequenceItem {
    return [self sequenceItemAtIndex:self.sequenceIndex inRound:self.gameRound];
}

@end
