//
//  Copyright (c) Samuel Défago. All rights reserved.
//
//  Licence information is available from the LICENCE file.
//

#import "SegueStackOtherDemoViewController.h"

#import "MemoryWarningTestCoverViewController.h"

@implementation SegueStackOtherDemoViewController

#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor randomColor];
}

#pragma mark Action callbacks

- (IBAction)hideWithModal:(id)sender
{
    MemoryWarningTestCoverViewController *memoryWarningTestCoverViewController = [[MemoryWarningTestCoverViewController alloc] init];
    [self presentViewController:memoryWarningTestCoverViewController animated:YES completion:nil];
}

@end
