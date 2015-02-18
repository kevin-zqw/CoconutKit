//
//  Copyright (c) Samuel Défago. All rights reserved.
//
//  Licence information is available from the LICENCE file.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIWindow (HLSExtensions)

/**
 * Return the active view controller (in general the root view controller of the window or a view controller 
 *ncurrently presented modally)
 */
@property (nonatomic, readonly, strong) UIViewController *activeViewController;

@end
