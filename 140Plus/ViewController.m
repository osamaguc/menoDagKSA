//
//  ViewController.m
//  140Plus
//
//  Created by ousamaMacBook on 5/25/13.
//  Copyright (c) 2013 MacBook. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize myNoteView;
@synthesize scroller3;
@synthesize fonts;
@synthesize title2,accounts,accountStore,accountsPicker,actionSheet,tweetsArray,progressBar,busy;
static int neededTotal;
static int current;
static bool bg = false;
- (void)viewDidLoad
{
    BOOL isIPhone4 = NO;
    if ([[UIScreen mainScreen] bounds].size.height < 481)
    {
        isIPhone4 = YES;
    }
    progressBar.alpha = 0;
    busy.alpha = 0;
    tweetsArray = [[NSMutableArray alloc]init];
    
    accounts = [[NSArray alloc]init];
    accountStore = [[ACAccountStore alloc] init];
    ACAccountType *twitterAccountType = [self.accountStore
                                         accountTypeWithAccountTypeIdentifier:
                                         ACAccountTypeIdentifierTwitter];
    [self.accountStore
     requestAccessToAccountsWithType:twitterAccountType
     options:NULL
     completion:^(BOOL granted, NSError *error) {
         if (granted) {
             accounts = [self.accountStore accountsWithAccountType:twitterAccountType];
         }
     }];
    

    [self storeToTheServer];
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    [self.navigationItem setHidesBackButton:YES];
    [myNoteView becomeFirstResponder];
    title2 = @"Andalus";
    fonts = [NSArray arrayWithObjects:@"Andalus",@"ae_Japan", @"ae_Jet",@"ae_Salem",@"XBZar-Bold",@"BArabicStyle",@"Youssef-Reguler",@"MO_Nawel",@"Motken_AL-Rafidain_Art",@"Nazli",@"Rekaa-Bold",@"AdvertisingBold",@"ae_AlManzomah",@"ae_Arab",@"ae_Furat",@"ae_Granada",nil];
            myNoteView.textAlignment = NSTextAlignmentCenter;
    
    [myNoteView setDelegate:self];
    myNoteView.layer.cornerRadius = 5;
    myNoteView.layer.masksToBounds = YES;
    myNoteView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.4];

    NSMutableArray *items = [NSMutableArray array];
    
    for (int i = 0; i < [fonts count]; i++) {
        ILSideScrollViewItem *item = [ILSideScrollViewItem item];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[fonts objectAtIndex:i]]];
        item.title = [fonts objectAtIndex:i];
        item.defaultBackgroundImage = image;
        item.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
        item.defaultTitleColor = [UIColor brownColor];
        item.selectedTitleColor = [UIColor redColor];
        item.titleFont = [UIFont fontWithName:@"MarkerFelt-Wide" size:1];
        [item setTarget:self action:@selector(showAlertForItem:) withObject:item];
        [items addObject:item];
    }
    [scroller3 setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.3]
                   indicatorStyle:UIScrollViewIndicatorStyleBlack
                  itemBorderColor:[UIColor whiteColor]];
    [scroller3 populateSideScrollViewWithItems:items];
    
    
    
//    UIView *twitterItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
//    [twitterItem setMenuActionWithBlock:^{
//        [self.sideMenu close];
//        self.menuIsVisible = false;
//        [self performSegueWithIdentifier:@"segAbout" sender:self];
//    }];
//    UIImageView *twitterIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
//    [twitterIcon setImage:[UIImage imageNamed:@"Actions-help-about-icon"]];
//    [twitterItem addSubview:twitterIcon];
    
    
    
    
    UIView *emailItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    emailItem.tag = 1;
    [emailItem setMenuActionWithBlock:^{
        [myNoteView resignFirstResponder];
        if (!self.wePopoverController) {
            ColorViewController *contentViewController = [[ColorViewController alloc] init];
            contentViewController.delegate = self;
        
            self.wePopoverController = [[WEPopoverController alloc] initWithContentViewController:contentViewController];
            self.wePopoverController.delegate = self;
            self.wePopoverController.passthroughViews = [NSArray arrayWithObject:self.navigationController.navigationBar];

            [self.wePopoverController presentPopoverFromRect:CGRectMake(200, 200, 200, 200)
                                                      inView:_optionsView
                                    permittedArrowDirections:(UIPopoverArrowDirectionUp |UIPopoverArrowDirectionDown)
                                                    animated:YES];
            
        } else {
            [self.wePopoverController dismissPopoverAnimated:YES];
            self.wePopoverController = nil;
        }
    }];
    
    UIImageView *emailIcon = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 30 , 30)];
    
    [emailIcon setImage:[UIImage imageNamed:@"Actions-format-stroke-color-icon"]];
    [emailItem addSubview:emailIcon];
    
    
    
    
    UIView *facebookItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    facebookItem.tag = 2;
    [facebookItem setMenuActionWithBlock:^{
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [picker.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav-bar.png"] forBarMetrics:UIBarMetricsDefault];
        picker.delegate = self;
        [self presentModalViewController:picker animated:YES];
    }];
    
    UIImageView *facebookIcon = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 35, 35)];
    
    [facebookIcon setImage:[UIImage imageNamed:@"background-icon"]];
    [facebookItem addSubview:facebookIcon];
    
    self.sideMenu = [[HMSideMenu alloc] initWithItems:@[ emailItem, facebookItem]];
    [self.sideMenu setItemSpacing:5.0f];
    [self.view addSubview:self.sideMenu];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav-bar.png"] forBarMetrics:UIBarMetricsDefault];
    
    [[UIBarButtonItem appearance] setTintColor:[UIColor colorWithRed:81.0/255 green:81.0/255 blue:81.0/255 alpha:1]];
    
    myNoteView.inputAccessoryView = _keyToolBar;
    
    if (isIPhone4)
    {
        [_backgroundLabel setFrame:CGRectMake(0, 0, 320, 160)];
    }
    
    [_tweetBtn setTintColor:[UIColor colorWithRed:0/255 green:130.0/255 blue:146.0/255 alpha:1]];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [myNoteView setNeedsDisplay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)changed:(id)sender {
    myNoteView.font = [UIFont fontWithName:title2 size:[self.slider value]];
    _fontLabel.font = [UIFont fontWithName:title2 size:17];
    _fontLabel.text = [self convertToArabic:_fontLabel.text];
}

- (IBAction)colorMe:(id)sender {
    [myNoteView resignFirstResponder];
    if (!self.wePopoverController) {
		
		ColorViewController *contentViewController = [[ColorViewController alloc] init];
        contentViewController.delegate = self;
		self.wePopoverController = [[WEPopoverController alloc] initWithContentViewController:contentViewController];
		self.wePopoverController.delegate = self;
		self.wePopoverController.passthroughViews = [NSArray arrayWithObject:self.navigationController.navigationBar];
		
		[self.wePopoverController presentPopoverFromRect:CGRectMake(200, 200, 200, 200)
                                                  inView:_optionsView
                                permittedArrowDirections:(UIPopoverArrowDirectionUp|UIPopoverArrowDirectionDown)
                                                animated:YES];
        
	} else {
		[self.wePopoverController dismissPopoverAnimated:YES];
		self.wePopoverController = nil;
	}
}

- (IBAction)shot:(id)sender {
    UIActionSheet* sheet = [[UIActionSheet alloc]initWithTitle:@"خيارات التغريد" delegate:self cancelButtonTitle:@"إلغاء" destructiveButtonTitle:nil otherButtonTitles:@"تغريدات متقطعة",@"تغريدة كاملة بصورة", nil];
    sheet.tag = 1;
    [sheet showInView:self.view];
}

-(void)picTweet
{
    [myNoteView resignFirstResponder];
    //    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myNoteView.text];
    //    [attString addAttribute:(NSString*)kCTUnderlineStyleAttributeName
    //                      value:[NSNumber numberWithInt:kCTUnderlineStyleSingle]
    //                      range:(NSRange){0,[attString length]}];
    //        myNoteView.textAlignment = NSTextAlignmentCenter;
    //    myNoteView.attributedText = attString;
    myNoteView.textAlignment = NSTextAlignmentCenter;
    if(!bg)
    {
        myNoteView.backgroundColor = [UIColor whiteColor];
    }
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGRect size = myNoteView.frame;
    CGRect tempSize = size;
    size.size.height = myNoteView.contentSize.height+10;
    size.size.width = screenWidth;
    myNoteView.frame = size;
    UIGraphicsBeginImageContextWithOptions(self.myNoteView.bounds.size, self.view.opaque, 0.0);
    [self.myNoteView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *imageView = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(imageView, nil,nil,nil);
    myNoteView.frame = tempSize;
    myNoteView.textAlignment = NSTextAlignmentCenter;
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"#تغريدتي_بصورة"];
        [tweetSheet addImage:imageView];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"عذراً"
                                  message:@"تأكد من الإتصال بالإنترنت وأن لديك حساب تويتر تم تفعيله من إعدادات جهازك."
                                  delegate:self
                                  cancelButtonTitle:@"موافق"
                                  otherButtonTitles:nil];
        [alertView show];
    }
    if(!bg)
    {
        myNoteView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.4];
    }
}

- (IBAction)openOptions:(id)sender {
    _fontLabel.font = [UIFont fontWithName:title2 size:17];
    _fontLabel.textColor = myNoteView.textColor;
    
    ArabicConverter *converter = [[ArabicConverter alloc] init];
    NSString* convertedString = [converter convertArabic:[_fontLabel text]];
    [_fontLabel setText:convertedString];
    
    if (self.sideMenu.isOpen)
    {
        [self.sideMenu close];
        _optionsView.hidden = YES;
        [myNoteView becomeFirstResponder];
        [_optionsButton setTitle:@"خيارات"];
        [_optionsButton setTintColor:[UIColor colorWithRed:81.0/255 green:81.0/255 blue:81.0/255 alpha:1]];
        [_mainNavBar setTitle:@"140+"];
    }
    else
    {
        [self.sideMenu open];
        _optionsView.hidden = NO;
        [myNoteView resignFirstResponder];
        [_optionsButton setTitle:@"تم"];
        [_optionsButton setTintColor:[UIColor colorWithRed:150.0/255 green:150.0/255 blue:150.0/255 alpha:1]];
        [_mainNavBar setTitle:@"خيارات"];
    }
}

-(NSString *)convertToArabic:(NSString *)theString
{
    ArabicConverter *converter = [[ArabicConverter alloc] init];
    NSString* convertedString = [converter convertArabic:theString];
    return convertedString;
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    myNoteView.text = [self convertToArabic:[myNoteView text]];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [myNoteView resignFirstResponder];
}

- (void)showAlertForItem:(ILSideScrollViewItem *)item {
    title2 = item.title;
    [myNoteView setFont:[UIFont fontWithName:title2 size:[self.slider value]]];
    [_fontLabel setFont:[UIFont fontWithName:title2 size:17]];
    _fontLabel.text = [self convertToArabic:_fontLabel.text];
}



#pragma mark -
#pragma mark WEPopoverControllerDelegate implementation

- (void)popoverControllerDidDismissPopover:(WEPopoverController *)thePopoverController {
	//Safe to release the popover here
	self.wePopoverController = nil;
}

- (BOOL)popoverControllerShouldDismissPopover:(WEPopoverController *)thePopoverController {
	//The popover is automatically dismissed if you click outside it, unless you return NO here
	return YES;
}



-(void) colorPopoverControllerDidSelectColor:(NSString *)hexColor{
    self.myNoteView.textColor =[GzColors colorFromHex:hexColor];
    _fontLabel.textColor =[GzColors colorFromHex:hexColor];
    [self.wePopoverController dismissPopoverAnimated:YES];
    self.wePopoverController = nil;
}


-(void)splittedTweetChooseAccount
{
    
    actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self     cancelButtonTitle:@"الغاء" destructiveButtonTitle:nil otherButtonTitles:nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    
    
    accountsPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0,40, 320, 216)];
    accountsPicker.showsSelectionIndicator=YES;
    accountsPicker.dataSource = self;
    accountsPicker.delegate = self;
    accountsPicker.tag=1;
    [actionSheet addSubview:accountsPicker];
    // [picker release];
    
    
    
    UIToolbar *tools=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0,320,40)];
    tools.barStyle=UIBarStyleBlackOpaque;
    [actionSheet addSubview:tools];
    
    
    
    UIBarButtonItem *doneButton=[[UIBarButtonItem alloc] initWithTitle:@"موافق" style:UIBarButtonItemStyleBordered target:self action:@selector(tweetSplit)];
    
    doneButton.imageInsets=UIEdgeInsetsMake(200, 6, 50, 25);
    UIBarButtonItem *CancelButton=[[UIBarButtonItem alloc]initWithTitle:@"الغاء" style:UIBarButtonItemStyleBordered target:self action:@selector(btnActinCancelClicked)];
    
    UIBarButtonItem *flexSpace= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    NSArray *array = [[NSArray alloc]initWithObjects:CancelButton,flexSpace,flexSpace,doneButton,nil];
    
    [tools setItems:array];
    
    
    //picker title
    UILabel *lblPickerTitle=[[UILabel alloc]initWithFrame:CGRectMake(60,8, 200, 25)];
    lblPickerTitle.text=@"إختر الحساب";
    lblPickerTitle.backgroundColor=[UIColor clearColor];
    lblPickerTitle.textColor=[UIColor whiteColor];
    lblPickerTitle.textAlignment=NSTextAlignmentCenter;
    lblPickerTitle.font=[UIFont boldSystemFontOfSize:15];
    [tools addSubview:lblPickerTitle];
    
    
    [actionSheet showFromRect:CGRectMake(0,480, 320,215) inView:self.view animated:YES];
    [actionSheet setBounds:CGRectMake(0,0, 320, 411)];
}

-(void)tweetSplit
{
    progressBar.progress = 0;
    progressBar.alpha = 1;
    busy.alpha = 1;
    tweetsArray = [[NSMutableArray alloc]init];
    [self btnActinCancelClicked];
    [myNoteView resignFirstResponder];
    
    NSString* tweet = [myNoteView text];
    int len = [tweet length];
    NSString* tweets = [NSString stringWithFormat:@"%i",((len+1)/140)];
    int twetsInt = [tweets intValue];
    neededTotal = twetsInt;
    int needed = [tweets length]*2+1;
    int chunk = 140-needed;
    int current2 = 0;
    while([tweet length] > chunk)
    {
        [tweetsArray addObject:[NSString stringWithFormat:@"%@%i/%i",[tweet substringToIndex:chunk],current2,twetsInt]];
        current2++;
        tweet = [tweet substringFromIndex:chunk];
    }
    [tweetsArray addObject:[NSString stringWithFormat:@"%@%i/%i",tweet,current2,twetsInt]];
    current2++;

    current = 0;
    [self postTweets];
    
}

-(void)postTweets
{
    if([tweetsArray count]>0)
    {
        NSString* tweet = [tweetsArray objectAtIndex:0];
        [tweetsArray removeObjectAtIndex:0];
        NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/update.json"];
        NSDictionary *params = @{@"status" : tweet};
        SLRequest *request =
        [SLRequest requestForServiceType:SLServiceTypeTwitter
                           requestMethod:SLRequestMethodPOST
                                     URL:url
                              parameters:params];
        
        //  Attach an account to the request
        NSLog(@"%@",[[accounts objectAtIndex:[accountsPicker selectedRowInComponent:0]]username]);
        [request setAccount:[accounts objectAtIndex:[accountsPicker selectedRowInComponent:0]]];
        
        [request performRequestWithHandler:^(NSData *responseData,
                                             NSHTTPURLResponse *urlResponse,
                                             NSError *error) {
            if (responseData) {
                NSString* res = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
                NSString* error3 = @"error";
                if([res rangeOfString:error3].location!=NSNotFound)
                {
                    
                    [self performSelectorOnMainThread:@selector(updateMe3) withObject:nil waitUntilDone:YES];
                }else
                {
                    [self performSelectorOnMainThread:@selector(updateMe) withObject:nil waitUntilDone:YES];
                }
            }
        }];
    }else
    {
        [self performSelectorOnMainThread:@selector(updateMe2) withObject:nil waitUntilDone:YES];
    }
}

-(void)updateMe
{
    current++;
    [progressBar setProgress:((float)current/(float)neededTotal) animated:YES];
    [self postTweets];
}

-(void)updateMe2
{
    current  = 0;
    progressBar.alpha = 0;
    busy.alpha = 0;
}

-(void)updateMe3
{
    current = 0;
    progressBar.alpha = 0;
    busy.alpha = 0;
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"عفواٍ" message:@"لقد تم الوصول للحد المسموح للتغريد لهذا الحساب من هذا التطبيق. حاول بعد فترة قصيرة" delegate:nil cancelButtonTitle:@"تم" otherButtonTitles:nil];
    [alert show];
}

#pragma uiimage
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissModalViewControllerAnimated:YES];
    
    UIImage* originalImage = nil;
    originalImage = [info objectForKey:UIImagePickerControllerEditedImage];
    if(originalImage==nil)
    {
        originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    if(originalImage==nil)
    {
        originalImage = [info objectForKey:UIImagePickerControllerCropRect];
    }
    if(originalImage != nil)
    {
        myNoteView.backgroundColor = [UIColor colorWithPatternImage:originalImage];
        bg = true;
    }else{
        bg = false;
    }
}



#pragma mark action sheet
-(void)actionSheet:(UIActionSheet *)actionSheet2 clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(actionSheet2.tag == 1)
    {
        if(buttonIndex == 0)
        {
            [self splittedTweetChooseAccount];
        }else if(buttonIndex == 1)
        {
            [self picTweet];
        }
    }
}


#pragma mark delegates for buttons in custom action sheets
-(void)btnActinCancelClicked
{
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

#pragma mark picker view delegates
-(int) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{

        return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return  [accounts count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{

    return [[accounts objectAtIndex:row]username];
}

#pragma mark - this method for storing the information (tokens) to the server
-(void)storeToTheServer
{
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *deviceToken = [standardUserDefaults stringForKey:@"deviceToken"];
    
    NSString *post = [NSString stringWithFormat:@"deviceToken=%@", deviceToken];
    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
    NSString *postLength = [NSString stringWithFormat:@"%d", [post length]];
    
    NSURL *url = [NSURL URLWithString:@"http://osamalogician.com/arabDevs/140/storeInformation.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:90.0];
    [request setHTTPMethod:@"POST"];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    
    NSURLConnection* registerConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self    startImmediately:NO];
    
    [registerConnection scheduleInRunLoop:[NSRunLoop mainRunLoop]
                                  forMode:NSDefaultRunLoopMode];
    [registerConnection start];
}


@end
