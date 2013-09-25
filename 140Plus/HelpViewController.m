//
//  HelpViewController.m
//  140Plus
//
//  Created by ousamaMacBook on 5/31/13.
//  Copyright (c) 2013 MacBook. All rights reserved.
//

#import "HelpViewController.h"
@interface HelpViewController ()

@end

@implementation HelpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"hasLaunchedOnce"])
    {
        [self performSegueWithIdentifier:@"segseg" sender:self];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushMe:(id)sender {
    if (_helpView1.alpha > 0.9)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.4];
        [_helpView1 setAlpha:0.0];
        [_helpView2 setAlpha:1.0];
        [UIView commitAnimations];
    }
    else if (_helpView2.alpha > 0.9)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.4];
        [_helpView2 setAlpha:0.0];
        [_helpView3 setAlpha:1.0];
        [UIView commitAnimations];
    }
    else if (_helpView3.alpha > 0.9)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.4];
        [_helpView3 setAlpha:0.0];
        [_helpView4 setAlpha:1.0];
        [UIView commitAnimations];
    }
    else if (_helpView4.alpha > 0.9)
    {
        [self performSegueWithIdentifier:@"segseg" sender:self];
    }
}
@end












