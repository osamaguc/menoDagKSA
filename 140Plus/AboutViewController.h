//
//  AboutViewController.h
//  140Plus
//
//  Created by ousamaMacBook on 5/30/13.
//  Copyright (c) 2013 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>

@interface AboutViewController : UIViewController <UIActionSheetDelegate>
- (IBAction)back:(id)sender;
- (IBAction)noqta:(id)sender;
- (IBAction)twitter:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *followUsButton;
@property (strong, nonatomic) IBOutlet UIButton *ourAppsButton;

@end
