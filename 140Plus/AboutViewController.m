//
//  AboutViewController.m
//  140Plus
//
//  Created by ousamaMacBook on 5/30/13.
//  Copyright (c) 2013 MacBook. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

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
    [_followUsButton setBackgroundImage:[UIImage imageNamed:@"about-button-highlighted.png"] forState:UIControlStateHighlighted];
    [_ourAppsButton setBackgroundImage:[UIImage imageNamed:@"about-button-highlighted.png"] forState:UIControlStateHighlighted];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ourApps:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"تطبيقاتنا" delegate:self cancelButtonTitle:@"إلغاء" destructiveButtonTitle:nil otherButtonTitles:@"تطبيق 'غردلي'",@"تطبيق 'ضيفني أضيفك'",@"تطبيق 'إنستاعربي'",@"المزيد..",nil];
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    actionSheet.tag = 1;
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

- (IBAction)followUs:(id)sender {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetbot:///follow/ArabDevs"]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tweetbot:///follow/ArabDevs"]];
    }
    else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://user?screen_name=ArabDevs"]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?screen_name=ArabDevs"]];
    }
    else
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/ArabDevs"]];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex  {
    switch (buttonIndex) {
        case 0:
        {
            if (actionSheet.tag == 1)
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/ghrdly/id671151269?ls=1&mt=8"]];
            }
        }
            break;
        case 1:
        {
            if (actionSheet.tag == 1)
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/dyfny-adyfk/id663980256?ls=1&mt=8"]];
            }
        }
            break;
        case 2:
        {
            if (actionSheet.tag == 1)
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/us/app/instaarabic-ansta-rby/id682522511?ls=1&mt=8"]];
            }
        }
            break;
        case 3:
        {
            if (actionSheet.tag == 1)
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.arabdevs.com/apps.html"]];
            }
        }
            break;
    }
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)noqta:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://n8th.com"]];
}

- (IBAction)twitter:(id)sender {
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"برنامج يمكنك من كتابة أكثر من ١٤٠ حرف و بخطوط مختلفة \n @Q8App"];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    
}
@end
