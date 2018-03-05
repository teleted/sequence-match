//
//  FourLights.h
//  Sequence Match
//
//  Created by Ted Boardman on 2/25/18.
//  Copyright © 2018 Ted Boardman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FourLights : NSObject

@property (strong, nonatomic) NSMutableArray *gameSequences;
@property (nonatomic) double delay;
@property (nonatomic) NSUInteger sequenceIndex;
@property (nonatomic) NSUInteger gameRound;

- (NSUInteger)currentSequenceCount;
- (NSUInteger)sequenceItemAtIndex:(NSUInteger)index inRound:(NSUInteger)round;
- (NSUInteger)nextSequenceItem;
@end
