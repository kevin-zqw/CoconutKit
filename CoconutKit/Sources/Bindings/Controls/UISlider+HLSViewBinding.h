//
//  Copyright (c) Samuel Défago. All rights reserved.
//
//  Licence information is available from the LICENCE file.
//

#import "UIView+HLSViewBindingImplementation.h"

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * Binding support for UISlider:
 *   - binds to NSNumber (float) or float model values
 *   - displays and updates the underlying model value
 *   - can animate updates
 *   - check (if not disabled via bindInputChecked) and update the value each time it is changed
 */
@interface UISlider (HLSViewBindingImplementation) <HLSViewBindingImplementation>

@end
