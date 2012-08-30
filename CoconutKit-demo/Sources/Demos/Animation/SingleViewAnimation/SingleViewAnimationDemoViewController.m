//
//  SingleViewAnimationDemoViewController.m
//  CoconutKit-demo
//
//  Created by Samuel Défago on 2/13/11.
//  Copyright 2011 Hortis. All rights reserved.
//

#import "SingleViewAnimationDemoViewController.h"

@interface SingleViewAnimationDemoViewController ()

@property (nonatomic, retain) HLSAnimation *animation;
@property (nonatomic, retain) HLSAnimation *reverseAnimation;

- (void)updateUserInterface;

@end

@implementation SingleViewAnimationDemoViewController

#pragma mark Object creation and destruction

- (void)releaseViews
{
    [super releaseViews];
        
    self.rectangleView = nil;
    self.playForwardButton = nil;
    self.playBackwardButton = nil;
    self.cancelButton = nil;
    self.terminateButton = nil;
    self.animatedSwitch = nil;
    self.blockingSwitch = nil;
    self.delayedSwitch = nil;
    self.fasterSwitch = nil;
    self.animation = nil;
    self.reverseAnimation = nil;
}

#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.playBackwardButton.hidden = YES;
    self.cancelButton.hidden = YES;
    self.terminateButton.hidden = YES;
    
    self.animatedSwitch.on = YES;
    self.blockingSwitch.on = NO;
    self.delayedSwitch.on = NO;
    self.fasterSwitch.on = NO;
    
    [self updateUserInterface];
}

#pragma mark Accessors and mutators

@synthesize rectangleView = m_rectangleView;

@synthesize playForwardButton = m_playForwardButton;

@synthesize playBackwardButton = m_playBackwardButton;

@synthesize cancelButton = m_cancelButton;

@synthesize terminateButton = m_terminateButton;

@synthesize animatedSwitch = m_animatedSwitch;

@synthesize blockingSwitch = m_blockingSwitch;

@synthesize delayedLabel = m_delayedLabel;

@synthesize delayedSwitch = m_delayedSwitch;

@synthesize fasterSwitch = m_fasterSwitch;

@synthesize animation = m_animation;

@synthesize reverseAnimation = m_reverseAnimation;

#pragma mark Orientation management

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if (! [super shouldAutorotateToInterfaceOrientation:toInterfaceOrientation]) {
        return NO;
    }
    
    return UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
}

#pragma mark Event callbacks

- (IBAction)playForward:(id)sender
{
    self.playForwardButton.hidden = YES;
    self.cancelButton.hidden = NO;
    self.terminateButton.hidden = NO;
    
    HLSLayerAnimationStep *animationStep1 = [HLSLayerAnimationStep animationStep];
    animationStep1.tag = @"step1";
    animationStep1.duration = 2.;
    animationStep1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    HLSLayerAnimation *layerAnimation11 = [HLSLayerAnimation animation];
    [layerAnimation11 translateByVectorWithX:100.f y:100.f];
    [animationStep1 addLayerAnimation:layerAnimation11 forView:self.rectangleView];
    
    HLSLayerAnimationStep *animationStep2 = [HLSLayerAnimationStep animationStep];
    animationStep2.tag = @"step2";
    animationStep2.duration = 1.;
    HLSLayerAnimation *layerAnimation21 = [HLSLayerAnimation animation];
    layerAnimation21.opacityVariation = -0.3f;
    [animationStep2 addLayerAnimation:layerAnimation21 forView:self.rectangleView];
    
    HLSLayerAnimationStep *animationStep3 = [HLSLayerAnimationStep animationStep];
    animationStep3.tag = @"step3";
    HLSLayerAnimation *layerAnimation31 = [HLSLayerAnimation animation];
    [layerAnimation31 scaleWithXFactor:1.5f yFactor:1.5f];
    [animationStep3 addLayerAnimation:layerAnimation31 forView:self.rectangleView];
    
    HLSLayerAnimationStep *animationStep4 = [HLSLayerAnimationStep animationStep];
    animationStep4.tag = @"step4";
    HLSLayerAnimation *layerAnimation41 = [HLSLayerAnimation animation];
    [layerAnimation41 rotateByAngle:M_PI_4];
    [animationStep4 addLayerAnimation:layerAnimation41 forView:self.rectangleView];
    
    HLSLayerAnimationStep *animationStep5 = [HLSLayerAnimationStep animationStep];
    animationStep5.tag = @"step5";
    animationStep5.duration = 1.;
    animationStep5.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    HLSLayerAnimation *layerAnimation51 = [HLSLayerAnimation animation];
    [layerAnimation51 translateByVectorWithX:0.f y:200.f];
    [animationStep5 addLayerAnimation:layerAnimation51 forView:self.rectangleView];
    
    HLSLayerAnimationStep *animationStep6 = [HLSLayerAnimationStep animationStep];
    animationStep6.tag = @"step6";
    animationStep6.duration = 0.7;
    animationStep6.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    HLSLayerAnimation *layerAnimation61 = [HLSLayerAnimation animation];
    [layerAnimation61 rotateByAngle:M_PI_4];
    layerAnimation61.opacityVariation = 0.3f;
    [animationStep6 addLayerAnimation:layerAnimation61 forView:self.rectangleView];
    
    // Create the animation and play it
    self.animation = [HLSAnimation animationWithAnimationSteps:[NSArray arrayWithObjects:animationStep1,
                                                                animationStep2,
                                                                animationStep3,
                                                                animationStep4,
                                                                animationStep5,
                                                                animationStep6,
                                                                nil]];
    if (self.fasterSwitch.on) {
        self.animation = [self.animation animationWithDuration:2.];
    }
    self.animation.tag = @"singleViewAnimation";
    self.animation.lockingUI = self.blockingSwitch.on;
    self.animation.delegate = self;
    
    if (! self.delayedSwitch.on) {
        [self.animation playAnimated:self.animatedSwitch.on];
    }
    else {
        [self.animation playAfterDelay:2.];
    }
}

- (IBAction)playBackward:(id)sender
{
    self.playBackwardButton.hidden = YES;
    self.cancelButton.hidden = NO;
    self.terminateButton.hidden = NO;
    
    // Create the reverse animation
    self.reverseAnimation = [self.animation reverseAnimation];
    self.reverseAnimation.lockingUI = self.blockingSwitch.on;
    
    if (! self.delayedSwitch.on) {
        [self.reverseAnimation playAnimated:self.animatedSwitch.on];    
    }
    else {
        [self.reverseAnimation playAfterDelay:1.];
    }
}

- (IBAction)pause:(id)sender
{
    if (self.animation.running) {
        if (! self.animation.paused) {
            [self.animation pause];
        }
        else {
            [self.animation resume];
        }
    }
    if (self.reverseAnimation.running) {
        if (! self.reverseAnimation.paused) {
            [self.reverseAnimation pause];
        }
        else {
            [self.reverseAnimation resume];
        }
    }    
}

- (IBAction)cancel:(id)sender
{
    if (self.animation.running) {
        self.playBackwardButton.hidden = NO;
        [self.animation cancel];
    }
    if (self.reverseAnimation.running) {
        self.playForwardButton.hidden = NO;
        [self.reverseAnimation cancel];
    }
    
    self.cancelButton.hidden = YES;
    self.terminateButton.hidden = YES;
}

- (IBAction)terminate:(id)sender
{
    if (self.animation.running) {
        self.playBackwardButton.hidden = NO;
        [self.animation terminate];
    }
    if (self.reverseAnimation.running) {
        self.playForwardButton.hidden = NO;
        [self.reverseAnimation terminate];
    }
    
    self.cancelButton.hidden = YES;
    self.terminateButton.hidden = YES;
}

- (IBAction)toggleAnimated:(id)sender
{
    self.delayedSwitch.on = NO;
    
    [self updateUserInterface];
}

#pragma mark HLSAnimationDelegate protocol implementation

- (void)animationWillStart:(HLSAnimation *)animation animated:(BOOL)animated
{
    HLSLoggerInfo(@"Animation %@ will start, animated = %@", animation.tag, HLSStringFromBool(animated));
}

- (void)animationStepFinished:(HLSAnimationStep *)animationStep animated:(BOOL)animated
{
    HLSLoggerInfo(@"Step %@ finished, animated = %@", animationStep.tag, HLSStringFromBool(animated));
}

- (void)animationDidStop:(HLSAnimation *)animation animated:(BOOL)animated
{
    HLSLoggerInfo(@"Animation %@ did stop, animated = %@", animation.tag, HLSStringFromBool(animated));
    
    // Can find which animation ended using its tag
    if ([animation.tag isEqualToString:@"singleViewAnimation"]) {
        self.playBackwardButton.hidden = NO;
    }
    else if ([animation.tag isEqualToString:@"reverse_singleViewAnimation"]) {
        self.playForwardButton.hidden = NO;
    }
    
    self.cancelButton.hidden = YES;
    self.terminateButton.hidden = YES;
}

#pragma mark Localization

- (void)localize
{
    [super localize];
    
    self.title = NSLocalizedString(@"Single view animation", @"Single view animation");
}

#pragma mark Miscellaneous

- (void)updateUserInterface
{
    if (self.animatedSwitch.on) {
        self.delayedLabel.hidden = NO;
        self.delayedSwitch.hidden = NO;
    }
    else {
        self.delayedLabel.hidden = YES;
        self.delayedSwitch.hidden = YES;
    }
}

@end
