//
//  FourLightsViewController.m
//  Sequence Match
//
//  Created by Ted Boardman on 2/26/18.
//  Copyright © 2018 Ted Boardman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FourLightsViewController.h"


@interface FourLightsViewController()

@property (strong, nonatomic) FourLightsController *flc;

@property (weak, nonatomic) IBOutlet UIButton *pad1;
@property (weak, nonatomic) IBOutlet UIButton *pad2;
@property (weak, nonatomic) IBOutlet UIButton *pad3;
@property (weak, nonatomic) IBOutlet UIButton *pad4;

@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

// Playing sequence
- (void)playSequence:(NSTimer *)timer;
- (void)animatePress:(UIButton *)button;
- (void)animateRelease:(UIButton *)button;
@end

@implementation FourLightsViewController


- (FourLightsController *)flc {
    if (!_flc) {
        FourLightsController *flc = [[FourLightsController alloc] init];
        _flc = flc;
        _flc.delegate = self;
    }
    return _flc;
}

- (IBAction)tapped:(UIButton *)sender {
    if ([[self flc] gameState] == SMBEGIN) {
        [[self flc] scoreTouched:sender.titleLabel.text];
    }
    [self updateUI];
}

- (void)updateUI {
    NSString *score = [NSString stringWithFormat:@"Score: %lu", (unsigned long)[[self flc] score]];
    self.scoreLabel.text = score;
    
    switch ([[self flc] gameState]) {
        case SMOBSERVE: self.stateLabel.text = @"Observe..."; break;
        case SMBEGIN:   self.stateLabel.text = @"Begin!"; break;
        case SMPERFECT: self.stateLabel.text = @"Perfect!"; break;
        case SMNEXT: self.stateLabel.text = @"Ok, try this..."; break;
        case SMEND: self.stateLabel.text = @"Good job!"; break;
        default: self.stateLabel.text = @""; break;
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self flc] setGameState:SMOBSERVE];
    
    [self startPlayingWithDelay:2.0];
}


- (void)startPlayingWithDelay:(float)waitTime {
    
    [NSTimer scheduledTimerWithTimeInterval:waitTime
                                     target:self
                                   selector:@selector(playSequence:)
                                   userInfo:nil
                                    repeats:NO];
    
    
}

- (void)playSequence:(NSTimer *)timer {
  
    if (self.flc.gameState == SMOBSERVE ||
        self.flc.gameState == SMNEXT ||
        self.flc.gameState == SMPERFECT) {
        int buttonNumber = (int)[self.flc nextInSequenceIncrementRound:NO];
        
        switch (buttonNumber) {
            case 1: [self animatePress:_pad1]; break;
            case 2: [self animatePress:_pad2];
                self.pad1.selected = NO; break;
            case 3: [self animatePress:_pad3]; break;
            case 4: [self animatePress:_pad4]; break;
            default: break;
        }
        
        [self startPlayingWithDelay:self.flc.delay];
        
    }
}


- (void)animatePress:(UIButton *)button {
    
    [UIView transitionWithView:button
                      duration:0.25
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{ button.highlighted = YES; }
                    completion:^(BOOL finished) { if (finished) [self animateRelease:button]; }];
    
    
}

- (void)animateRelease:(UIButton *)button {
    
    [UIView transitionWithView:button
                      duration:0.25
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{ button.highlighted = NO; }
                    completion:nil];
    
}


/**
 Message receiver for FourLightsControllerDelegate
    (Message will occur whenver game state changes in the game controller)

 @param gState typedef NSUInteger indicating state of gameplay
 */
- (void)fourLightsControllerStateChange:(NSUInteger)gState {
    [self updateUI];
    if (gState == SMNEXT || gState == SMPERFECT) {
        
        [self startPlayingWithDelay:2.0];
    }
}

@end
