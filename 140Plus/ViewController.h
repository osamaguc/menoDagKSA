//
//  ViewController.h
//  140Plus
//
//  Created by ousamaMacBook on 5/25/13.
//  Copyright (c) 2013 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "NoteView.h"
#import <Social/Social.h>
#import <CoreText/CoreText.h>
#import "ArabicConverter.h"
#import "ILSideScrollView.h"
#import "ILSideScrollViewItem.h"
#import "WEPopoverController.h"
#import "ColorViewController.h"
#import "HMSideMenu.h"
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>
#import <Twitter/Twitter.h>

@interface ViewController : UIViewController<UITextViewDelegate,WEPopoverControllerDelegate, UIPopoverControllerDelegate, ColorViewControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *myNoteView;
- (IBAction)changed:(id)sender;
- (IBAction)colorMe:(id)sender;
- (IBAction)shot:(id)sender;
- (IBAction)showMenu:(id)sender;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *busy;
@property (strong, nonatomic) IBOutlet UIProgressView *progressBar;
@property (strong, nonatomic) IBOutlet UIToolbar *keyToolBar;
@property (strong, nonatomic) IBOutlet UIView *optionsView;
@property (strong, nonatomic) IBOutlet UINavigationItem *mainNavBar;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *optionsButton;
@property (strong, nonatomic) IBOutlet UILabel *fontLabel;
@property (strong, nonatomic) IBOutlet UILabel *backgroundLabel;

@property (strong, nonatomic) UIActionSheet* actionSheet;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *tweetBtn;
@property (nonatomic, strong) NSArray *accounts;
@property (nonatomic, strong) NSMutableArray *tweetsArray;
@property (nonatomic, strong) ACAccountStore *accountStore;
@property (strong, nonatomic) UIPickerView* accountsPicker;
@property (nonatomic, assign) BOOL menuIsVisible;
@property (nonatomic, strong) HMSideMenu *sideMenu;
@property (nonatomic, strong) WEPopoverController *wePopoverController;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet ILSideScrollView *scroller3;
@property (strong, nonatomic) NSArray *fonts;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (strong, nonatomic) NSString *title2;
@end
