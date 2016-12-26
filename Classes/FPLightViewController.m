//document.all[0].innerHTML

//credit to : http://www.kryogenix.org/code/browser/sorttable/

/*
 Status-check:
 -> Quite a few features are half-built but the base works but they need refining the all the features completing.
 -> Alerts implementation is basic and needs HEAVY work, pages, page numbers, number of unread alerts, etc.
 -> Messages view needs to show number of unread messages and alerts and flash each one individually if needed
 -> Messages can be listed but not read or sent; feature needs adding
 -> Gossip can show threads and read but no reply, no showing most popular, no support for tracking topics, etc.
 -> Friends list can show friends from spaz list and a list of all friends and needs to be integrated with all other features
 -> There is no support for viewing profiles at all, this needs to be created
 -> There are no support for images and videos, a picture-upload view exists but is very dodgy and needs to be fixed to upload to the logged in user and show their galleries
 -> Settings are not saved and the views do nothing, plus do not have the settings there to change, there is read-only database support which needs to be changed to write-support too, plus all variables need to be read and used (e.g. show/hide images)
 -> Included images need to be checked, is a selection of icons REALLY needed?
 -> Admin needs to approve the idea of the app, instead of ignoring the email...
 -> Any support for hubs planned? Maybe release a base app and add hubs at a later date?
 -> The 'loader-overlay' such as whilst logging in does not stop button presses to buttons on the views
 -> (probably no need) Purgatory support, viewing who's in and who isn't?
 -> Get a purgatory account and check login, need detection for purged accounts so they are unable to login (there is no point anyway)
 -> Sorting for friends list using javascript somehow?
 */

//AND DER TREI

//
//  FPLightViewController.m
//  Faceparty Light
//
//  Created by thedjnK on 17/08/2010.
//  $LAST_UPDATE$ : 02/01/2011.
//  $CUR_VERSION$ : 0.3
//  $CUR_BUILDNO$ : over 9000
//  Copyright © 2010-2011, todo. All rights reserved.

//Working right here

//Working here

//WORKIN' HEIR
/*
 Work log:
  -> Started with SQLite 3 stuff.. Check firefox bookmark for help page. Needs more optimising and testing... And implementation too...
  -> Started with the picture selector, and uploading.. Check last bookmark for info on how to upload, and test with fp!
  n.b. cookies need to update when a response is recieved too, else it will time out in 20 minutes... implement that somehow/sometime.
  n.b.2 frametransition can free up memory! Remove the old frame if it's not needed anymore. Also increses privacy and whatnot with messages.
 */

/*
 Slogans ! :

 "A happy punch in the A & kick in the B" - xxlauraxxbaby
 "Why are we here?" - spongyjay
 "It's pissing down & I've nothing better to do" - afcbmikey
 "Ambition & Productivity's Graveyard" - bennytheegg
 "Is this real life?" - o0odave2004o0o
 "A happy dysfunctional family" - 
 "A serious case of Bi-Polar" - kakaimacgul
 "One big happy dysfunctional family" - fra991e
 "The epitome of social recluse" - _arctic-monkey_
 "Happy dog party, woof woof!" - administrator
 "It's a 'Sausage-fest' in here!" - Chat
 "Js." - nigee20
*/

/*
 SQLite database:
 1 table
 
 CREATE TABLE storage (Key VARCHAR2(25) PRIMARY KEY, Value VARCHAR2(50));
 INSERT INTO storage VALUES ('Username', 'abc');
 INSERT INTO storage VALUES ('Password', 's');
 INSERT INTO storage VALUES ('Theme', 'FP');
 INSERT INTO storage VALUES ('CheckForUpdates', '0');
 INSERT INTO storage VALUES ('LastUpdateCheck', NULL);
 INSERT INTO storage VALUES ('EnableImages', '0');
 INSERT INTO storage VALUES ('PestListActive', '0');
 INSERT INTO storage VALUES ('FirstRun', '0');
 INSERT INTO storage VALUES ('NameColours', NULL);
 INSERT INTO storage VALUES ('TextColours', NULL);
 INSERT INTO storage VALUES ('IncludeTags', '0');
 INSERT INTO storage VALUES ('ShowSlogans', '0');
 INSERT INTO storage VALUES ('SloganImages', '0');
 INSERT INTO storage VALUES ('Language', '0');
 INSERT INTO storage VALUES ('Times', '0');
 INSERT INTO storage VALUES ('Timezone', '0');
 INSERT INTO storage VALUES ('afcbMode', '0');
 
 Table #1
 {
   -> Key [string] (e.g. Username)
   -> Value [string] (e.g. Timm)
 }
 Values
 {
   -> ('Username', '')
   -> ('Password', '')
   -> ('Theme', 'FP')
   -> ('CheckForUpdates', '1')
   -> ('LastUpdateCheck', 'DDMMYYYY')
   -> ('EnableImages', '0')
   -> ('PestListActive', '0') [1 = blocked users from pest list, 0 = off]
   -> ('FirstRun' '1') [sets to 0 when run for the first time and displays the help/config me please stuff]
   -> ('NameColours', '#xxxxxx') [Hex-Coded colour for usernames to appear, doesn't affect admin being red]
   -> ('TextColours', '#xxxxxx') [Hex-Coded colour for web-text to appear]
   -> ('IncludeTags', '0') [Show tags in gossip or remove them]
   -> ('ShowSlogans', '1') [Show slogans from H3K by FP users]
   -> ('SloganImages', '0') [Show slogans as images if enabled or text otherwise]
   -> ('Language', '0') [0 = english, 1 = pirate, 2 = 1337, 3 = ?]
   -> ('Times', '0') [0 = 'x minutes ago', 1 = 'hh:mm']
   -> ('Timezone', '0') [Affects times when Times (above) is 1]
   -> ('afcbmode', '0') [Changes names to red & black alternating AbCdEfG (caps = red, lower = black)]
 }
 
 n.b.;
 -> if having extra icons and whatnot, a table with an array is needed
*/

/*
 so err;
 password gets cleared on logout, fix this
 gossipweb is blank after login > logout > login (CANNOT REPRODUCE)
 */

 /*
   LAUNCH DAY:
   (when approved from apple)
   
   4 shoutouts on FP:
  
   1) FP Light
   2) for iPhone
   3) Now @ App Store
   4) ENJOY =)
   
   Probably have a beer or lots as well to celebrate.
   Or somethin'.
  
   Oh and also mass-message posters in thread #855155
 */

//Report feature!
//Have a button in gossip mode for reporting spammed threads
//Post results to site (thread and page IDs)
//Check list, add spammers to lock-out list and abusers of the system to an ignore list

#import "FPLightViewController.h"
#import "RegexKitLite.h"
#import <QuartzCore/QuartzCore.h>

#include "Version.h"
//Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator4.0.sdk/System/Library/Frameworks/UIKit.framework/Headers
//#import </Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator4.0.sdk/System/Library/Frameworks/UIKit.framework/Headers/UIResponder.h>

//Example or this and how to access;
//#define TIME_FOR_SHRINKING 0.61f
#define ARC4RANDOM_MAX      0x100000000
#define KeyboardHeight      170.0f
//[self performSelector:@selector(animateTransition:) withObject:[NSNumber numberWithFloat: TIME_FOR_EXPANDING]];

@implementation FPLightViewController

//For SQLite
static sqlite3_stmt *runstatement = nil;

- (IBAction)Next{
	/* should be another TBR */

//	[self presentModalViewController:untitled animated:NO];
/*ViewController *vc = [[ViewController alloc] initWithNibName:@"nibname@ bundle:nil"];
	[vc.modalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
	[self presentModalViewController:vc animated:YES];
	[vc release];
 */
//	View2 = [[View1 alloc] initWithNibName:@"untitled" bundle:Nil];
//	UIImage *image1 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Faceparty.png" ofType:nil]];
//	View1 = [[UIImageView alloc] initWithImage:image1];
//	View2 = [[UIView alloc] initWithImage:image1];
//	[TestyViewController addSubview:View2];
//	[TestyViewController presentModalViewController:View2 animated:NO];
	[self performSelector:@selector(showSplash2) withObject:nil afterDelay:0.5];
}

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
//    [super viewDidLoad];
	//Get the build number
	CurrentBuildVersion = [versionclass GetBuild]; //Replacing: [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]
	
	CurrentTheme = @"nK";
	HTTPProxy = FALSE;
	PestListActive = FALSE;
	colourChange = [[NSTimer alloc] init];
	
	GalleryNames = [[NSMutableArray alloc] init];
	[GalleryNames addObject:[NSArray arrayWithObjects:@"14", @"leet", nil]];
	[GalleryNames addObject:[NSArray arrayWithObjects:@"10", @"a 'nover", nil]];
	[GalleryNames addObject:[NSArray arrayWithObjects:@"20", @"boom", nil]];
	
	CookieData = [[NSMutableArray alloc] init];
	RecievedData = [[NSMutableString alloc] init];
	
	[self performSelector:@selector(OpenDatabase) withObject:nil afterDelay:0.0];
	[self performSelector:@selector(LoadSettings) withObject:nil afterDelay:0.15];
	[self performSelector:@selector(ShowAlert:) withObject:[NSArray arrayWithObjects:@"FP Light", [NSString stringWithFormat:@"THIS IS ALPHA SOFTWARE! PRIVATE TESTING ONLY!\r\nV%@ Build %@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"], CurrentBuildVersion], nil] afterDelay:0.6];
//	[self performSelector:@selector(ShowAlert:) withObject:[NSArray arrayWithObjects:@"Hi", @"This is BETA software.\r\n enjoy ;)", nil] afterDelay:0.6];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(void)didReceiveMemoryWarning
{
	/* Memory warning! Free up some memory */

	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
	[yo release];
}

-(void)viewDidUnload
{
	/* Unloading the view; release all objects */

	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	[GossipView removeFromSuperview];
	[LoginView removeFromSuperview];
	[LoaderView removeFromSuperview];
	[LoaderParentView removeFromSuperview];
	[menuView removeFromSuperview];
	[startupImage removeFromSuperview];
	GossipView = nil;
	LoginView = nil;
	LoaderView = nil;
	LoaderParentView = nil;
	menuView = nil;
	startupImage = nil;

	[LastView release];
	[ReturnString release];
	[yo release];
	[baseURL release];
	[RecievedData release];
	[globarray release];
	
	[startupImage release];
	[menuView release];
	[results release];
	[ques release];
	[Title release];
	[Username release];
	[Password release];
	[FPLightLogo release];
	[CreditView release];
	[CreditsBtn release];
	[CreditsCloseBtn release];
	[CreditsBar release];
	[LoaderParentView release];
	[LoaderView release];
	[LoaderAnimation release];
	[GossipView release];
	[GossipWeb release];
	[LoginView release];
}

-(void)dealloc
{
	/* Deallocate all allocated objects */

	[LastView release];
	[ReturnString release];
	[yo release];
	[baseURL release];
	[RecievedData release];
	[globarray release];
	
	[startupImage release];
	[menuView release];
	[results release];
	[ques release];
	[Title release];
	[Username release];
	[Password release];
	[FPLightLogo release];
	[CreditView release];
	[CreditsBtn release];
	[CreditsCloseBtn release];
	[CreditsBar release];
	[LoaderParentView release];
	[LoaderView release];
	[LoaderAnimation release];
	[GossipView release];
	[GossipWeb release];
	[LoginView release];
    [super dealloc];
}

-(void)showSplash
{
	/* TBR or renamed */

	UIViewController *modalViewController = [[UIViewController alloc] init];
	modalViewController.view = startupImage;
	[self presentModalViewController:modalViewController animated:NO];
	[self performSelector:@selector(hideSplash) withObject:nil afterDelay:0.2];
	[modalViewController release];
}

-(void)showSplash2
{
	/* TBR */

	UIViewController *modalViewController = [[UIViewController alloc] init];
	modalViewController.view = NewMessageView;
	[self presentModalViewController:modalViewController animated:YES];
	//	[ohffs setText:[NSString stringWithFormat:@"%f", theSize.height]];
	NewMessageContent.backgroundColor = [UIColor clearColor];
	
	NewMessageContent.contentSize = CGSizeMake(320, 720);
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector (keyboardDidShow:)
												 name: UIKeyboardDidShowNotification object:nil];
	
/*	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector (keyboardDidHide:)
												 name: UIKeyboardDidHideNotification object:nil];*/
		
	//	[self performSelector:@selector(selectUsername) withObject:nil afterDelay:0.6];
	[modalViewController release];
}

-(void)textViewDidChange:(UITextView *)inTextView
{
	/* Ran when the text in the textview changes to resize the border (inactive TextField) */

	/*
	NSLog(ohffs2.font.fontName);
	NSLog([NSString stringWithFormat:@"%f",ohffs2.font.pointSize]);
	NSLog(ohffs2.font.familyName);
	NSLog([NSString stringWithFormat:@"%f",ohffs2.font.capHeight]);
	NSLog([NSString stringWithFormat:@"%f",ohffs2.font.lineHeight]);
	 */
	if (NewMessageContent.text.length < 1)
	{
		NewMessageContentBorder.frame = CGRectMake((NewMessageContent.layer.position.x - (NewMessageContent.layer.frame.size.width / 2)), (NewMessageContent.layer.position.y - (NewMessageContent.layer.frame.size.height / 2)), [@" " sizeWithFont:[UIFont fontWithName:@"Helvetica" size:17.0f] constrainedToSize:CGSizeMake(278.0f, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap].width+8, [[NSString stringWithFormat:@"%@%@", NewMessageContent.text, @"\n"] sizeWithFont:[UIFont fontWithName:@"Helvetica" size:17.0f] constrainedToSize:CGSizeMake(278.0f, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap].height+4);
	}
	else
	{
		//boldSystemFontOfSize:17.0f
		NewMessageContentBorder.frame = CGRectMake((NewMessageContent.layer.position.x - (NewMessageContent.layer.frame.size.width / 2)), (NewMessageContent.layer.position.y - (NewMessageContent.layer.frame.size.height / 2)), [[NSString stringWithFormat:@"%@%@", NewMessageContent.text, @"\n"] sizeWithFont:[UIFont fontWithName:@"Helvetica" size:17.0f] constrainedToSize:CGSizeMake(278.0f, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap].width+8, [[NSString stringWithFormat:@"%@%@", NewMessageContent.text, @"\n"] sizeWithFont:[UIFont fontWithName:@"Helvetica" size:17.0f] constrainedToSize:CGSizeMake(278.0f, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap].height+4);
	}

	//	CGSize theSize = [ohffs2.text sizeWithFont:[UIFont boldSystemFontOfSize:18.0f] constrainedToSize:CGSizeMake(265.0f, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
	//	ohffs.frame = CGRectMake((ohffs2.layer.position.x - (ohffs2.layer.frame.size.width / 2)), (ohffs2.layer.position.y - (ohffs2.layer.frame.size.height / 2)), /*ohffs.layer.frame.size.width*/[ohffs2.text sizeWithFont:[UIFont boldSystemFontOfSize:18.0f] constrainedToSize:CGSizeMake(265.0f, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap].width+8, [ohffs2.text sizeWithFont:[UIFont boldSystemFontOfSize:18.0f] constrainedToSize:CGSizeMake(265.0f, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap].height+4);
}

-(void)keyboardDidShow: (NSNotification *)notif 
{
	/* Move the frame when the keyboard becomes visible */

	// If keyboard is visible, return
	if (keyboardVisible) 
	{
		NSLog(@"Keyboard is already visible. Ignoring notification.");
		return;
	}
	
	// Get the size of the keyboard.
	NSDictionary* info = [notif userInfo];
	NSValue* aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
	CGSize keyboardSize = [aValue CGRectValue].size;
	
	// Save the current location so we can restore
	// when keyboard is dismissed
	offset = NewMessageContentScroller.contentOffset;
	
	// Resize the scroll view to make room for the keyboard
/*	CGRect viewFrame = ohffs3.frame;
	viewFrame.size.height -= keyboardSize.height;
	ohffs3.frame = viewFrame;*/
	NewMessageContentScroller.contentOffset = CGPointMake(0, 100);
	
	// Keyboard is now visible
	keyboardVisible = YES;
}

-(void)keyboardDidHide: (NSNotification *)notif 
{
	/* Move the view back to normal when the keyboard dissapears */

	// Is the keyboard already shown
	if (!keyboardVisible) 
	{
		NSLog(@"Keyboard is already hidden. Ignoring notification.");
		return;
	}
	
	// Reset the height of the scroll view to its original value
	NewMessageContentScroller.frame = CGRectMake(0, 0, 320, 460);
	
	// Reset the scrollview to previous location
	NewMessageContentScroller.contentOffset = offset;
	
	// Keyboard is no longer visible
	keyboardVisible = NO;	
}

-(IBAction)CreditsBtnClick
{
	/* Show the credits */
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.0];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
	[self.view addSubview:CreditView];
	[UIView commitAnimations];
}

-(IBAction)CreditsCloseBtnClick
{
	/* Hide the credits */
	[UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
	[CreditView removeFromSuperview];
	[UIView commitAnimations];
}

-(IBAction)CreditsBtnClick2
{
	/* TBR? */

	UIViewController *modalViewController = [[UIViewController alloc] init];
	modalViewController.view = CreditView;
	[self presentModalViewController:modalViewController animated:YES];
	[modalViewController release];
}

-(IBAction)hideSplash
{
	[[self modalViewController] dismissModalViewControllerAnimated:YES];
	//Remove the view fully in a second after the view animation has finished to stop it just vanishing oddly.
	[self performSelector:@selector(RemoveFromSuperViewDelayed:) withObject:startupImage afterDelay:1.0];
	[self performSelector:@selector(DeleteView:) withObject:startupImage afterDelay:2.0];
}

-(void)FrameTransition: (UIView*)NewView
{
	// get the view that's currently showing
	UIView *currentView = self.view;
	// get the the underlying UIWindow, or the view containing the current view view
	UIView *theWindow = [currentView superview];
	
	// remove the current view and replace with myView1
	//[currentView removeFromSuperview];
	[theWindow addSubview:NewView];

	
	// set up an animation for the transition between the views	
	CATransition *animation = [CATransition animation];
	animation.duration = 0.75;
	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//	NSString *types[5] = {kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal, kCATransitionFade};
//	NSString *subtypes[4] = {kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom};
//	int rnd = random() % 4;
//	animation.type = types[rnd];
	animation.type = kCATransitionPush;
	animation.subtype = kCATransitionFromRight;
//	if (rnd < 3)
//	{
//		animation.subtype = subtypes[random()%4];
//	}
	animation.delegate = self;
	[theWindow.layer addAnimation:animation forKey:nil];
	
	//Fix for lame overlapping of elements. Fix it FFS apple
	NewView.layer.position = CGPointMake(320/2, 460/2+20);
	
	currentView.hidden = YES;
	NewView.hidden = NO;
	
	[self performSelector:@selector(FrameLoaded:) withObject:[NSString stringWithFormat:@"%d", NewView.tag] afterDelay:0.6];
	
//	[NewView release];
	//	NSLog([NSString stringWithFormat:@"%d", NewView.tag]);
	
	/* Old & Buggy;
	 // get the view that's currently showing
	 UIView *currentView = self.view;
	 // get the the underlying UIWindow, or the view containing the current view view
	 UIView *theWindow = [currentView superview];
	 
	 // remove the current view and replace with myView1
	 [currentView removeFromSuperview];
	 [theWindow addSubview:NewView];
	 
	 CATransition *animation = [CATransition animation];
	 [animation setDuration:0.5];
	 [animation setType:kCATransitionPush];
	 [animation setSubtype:kCATransitionFromRight];
	 [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	 
	 [[theWindow layer] addAnimation:animation forKey:nil];
	 */
}

-(void)FrameTransition2: (NSArray*) Params
{		
	//Split the array into parameters
	UIView *NewView = [Params objectAtIndex:0];
	NSString *Transition = [[NSString alloc] initWithString:[Params objectAtIndex:1]];
	NSString *TransitionType = [[NSString alloc] initWithString:[Params objectAtIndex:2]];
		
	// get the view that's currently showing
	UIView *currentView = self.view;
	// get the the underlying UIWindow, or the view containing the current view view
	UIView *theWindow = [currentView superview];
	
	// remove the current view and replace with myView1
	//[currentView removeFromSuperview];
	[theWindow addSubview:NewView];
	
	// set up an animation for the transition between the views	
	CATransition *animation = [CATransition animation];
	animation.duration = 0.75;
	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	animation.type = Transition;
	if (![TransitionType isEqualToString:nil])
	{
		animation.subtype = TransitionType;
	}
	animation.delegate = self;
	[theWindow.layer addAnimation:animation forKey:nil];
	
	//Fix for lame overlapping of elements. Fix it FFS apple
	NewView.layer.position = CGPointMake(320/2, 460/2+20);
	
	currentView.hidden = YES;
	NewView.hidden = NO;

	[self performSelector:@selector(FrameLoaded:) withObject:[NSString stringWithFormat:@"%d", NewView.tag] afterDelay:0.6];
	
	//Here comes the party mo-bil!
//	[Params release];
	[Transition release];
	[TransitionType release];
}

-(IBAction)closeKeyboard
{
	//No action required (for keyboard to close)
}

-(IBAction)nextKeyboard
{
//	if [Username];
//	[self selectPassword];
//	[self iHateThis:Username];

	//Find out which view we are in
	if (ImageUploadView.superview)
	{
		if ([ImageTitle isFirstResponder])
		{
			[ImageDescription becomeFirstResponder];
		}
		else if ([ImageDescription isFirstResponder])
		{
			[ImageGallery becomeFirstResponder];
		}
		else
		{
			[ImageGallery resignFirstResponder];
		}
	}
	else if (LoginView.superview)
	{
		//Login view, so set the next input to the password field
		[Password becomeFirstResponder];
	}

}

-(void)FrameLoaded:(NSString*)FrameTag
{
	//Check what frame we are in
	if ([FrameTag isEqualToString:@"3"])
	{
		//Login frame, set username field to active
/* NB: Do checking here to see if autologin or let user type username and password */
		[Username becomeFirstResponder];
		[CreditView removeFromSuperview];
		[GossipView removeFromSuperview];
		[LoginMenuView removeFromSuperview];
		[Settings_Main removeFromSuperview];
		[Settings_FPLight removeFromSuperview];
		[Settings_FP removeFromSuperview];
		[Settings_Password removeFromSuperview];
		[NewMessageView removeFromSuperview];
		[NewAlertView removeFromSuperview];
		[ViewAlertsView removeFromSuperview];
		[ViewMessagesView removeFromSuperview];
		[MessagesView removeFromSuperview];
		[UnsavedMessageView removeFromSuperview];
		[ViewMessagesView removeFromSuperview];
	}
	else if ([FrameTag isEqualToString:@"10"])
	{
		//Logged-in frame
		if ([UpdateInfo.text length] < 5)
		{
			[self performSelectorOnMainThread:@selector(DoWeb:) withObject:[NSArray arrayWithObjects:[NSString stringWithFormat:@"http://www.URL_REMOVED.com/fplight_news.php?v=%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]] , @"", nil] waitUntilDone:NO];
		}
		//Reset password box to blank so it can't be used by mischevious scripts/programs/viruses/etc.
		if (Password.text.length > 4)
		{
			Password.text = @"";
		}
		
		//Remove extra views from being active
		[CreditView removeFromSuperview];
		[GossipView removeFromSuperview];
		[Settings_Main removeFromSuperview];
		[Settings_FPLight removeFromSuperview];
		[Settings_FP removeFromSuperview];
		[Settings_Password removeFromSuperview];
		[NewMessageView removeFromSuperview];
		[NewAlertView removeFromSuperview];
		[ViewAlertsView removeFromSuperview];
		[ViewMessagesView removeFromSuperview];
		[MessagesView removeFromSuperview];
		[UnsavedMessageView removeFromSuperview];
		[ViewMessagesView removeFromSuperview];
	}
	else if ([FrameTag isEqualToString:@"15"])
	{
		[BannedViewWeb loadHTMLString:@"<html><head><meta name=\"viewport\" content=\"initial-scale = 0.565\" /></head><body bgcolor=\"#AAAAAA\"><br /><br /><br /><div align=\"center\"><img src=\"Banned1.png\" width=\"550\" /><br /><img src=\"Banned3.gif\" width=\"550\" /><br /><img src=\"Banned2.png\" width=\"550\" /><br /><h1>Please wait...<br />Loading data.</h1><br /><h3>(This may take a while on mobile web connections)</h3></div></body></html>\r\n" baseURL:[NSURL URLWithString: [NSString stringWithFormat:@"file:/%@//", [[[[NSBundle mainBundle] resourcePath] stringByReplacingOccurrencesOfString:@"/" withString:@"//"] stringByReplacingOccurrencesOfString:@" " withString:@"%20"]]]];
	}
	else
	{
	}

}

//USE TEH REGEX THING.
//And check bookmarks for URL to site on how to do thing so app doesn't get rejected

-(void)HTTP_Login
{
	//Go into a secondary thread
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	//Wait until a reply is recieved in this split-thread.
	while (1)
	{
		//Due to the most disgrace of apple programmers; a function has to be called here else the optimisation flag ENTIRELY removes this function which is a complete joke.
		[self nilFunction];
		
		if (HTTPProgress == FALSE)
		{

	//Reply has been recieved!
//	[WTFa setText:@"WINNAH =D"];
	
	//Perform a javascript function to get the value.
	//[NSThread performSelectorOnMainThread:@selector(PerformJavascript:) withObject:@"csf.action" waitUntilDone:YES];
	//[WTFa setText:ReturnString];

	/* Cookie testing! */
//	NSArray *Cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:[httpResponse allHeaderFields] forURL:baseURL];
//	[[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:allCookies forURL:request mainDocumentURL:nil];
//			NSLog([NSString stringWithFormat:@"%@%d", @"SIZE: ", Cookies.count]);
			
	//Check if the user has logged in successfully or not
	if (NSEqualRanges(NSMakeRange(NSNotFound, 0), [RecievedData rangeOfString:@"Hi, <font color=\"3399FF\">"]) == 0)
	{
		//Logged in! Now we need to retrieve the list of blocked accounts
		/*
		 get page 1
		 check number of pages
		 run loop for page #2...#last
		 oh each loop, run a request and parse through each page
		 */
		//Gather the cookies that we recieved from logging in with

		[self GetCookies];
		//Check if there are any unread messages or alerts too.
//		[self GetMessages]
		[self performSelectorOnMainThread:@selector(GetMessages) withObject:nil waitUntilDone:YES];
		[self performSelectorOnMainThread:@selector(SetMessages) withObject:nil waitUntilDone:YES];
//^^ do
		
		//Colour the login boxes green
		Username.backgroundColor = [UIColor colorWithRed:0.36 green:0.967 blue:0.325 alpha:0.9];
		Username.textColor = [UIColor colorWithRed:0.36 green:0.967 blue:0.325 alpha:0.9];
		Password.backgroundColor = [UIColor colorWithRed:0.36 green:0.967 blue:0.325 alpha:0.9];
		Password.textColor = [UIColor colorWithRed:0.36 green:0.967 blue:0.325 alpha:0.9];
		
//heir
[welcomeLbl_Menu setText:[NSString stringWithFormat:@"%@%@%@", @"Hi, ", Username.text, @"."]];
[settings_MainLbl_Menu setText:[NSString stringWithFormat:@"%@%@%@", @"Hi, ", Username.text, @"."]];
[settings_FPLbl_Menu setText:[NSString stringWithFormat:@"%@%@%@", @"Hi, ", Username.text, @"."]];
[settings_FPLightLbl_Menu setText:[NSString stringWithFormat:@"%@%@%@", @"Hi, ", Username.text, @"."]];
[settings_PasswordLbl_Menu setText:[NSString stringWithFormat:@"%@%@%@", @"Hi, ", Username.text, @"."]];
		
//[URLConnection release];
		//Is the pest list active? If so, get retrieving those lists
		if (PestListActive == TRUE)
		{
			PestList = [[NSMutableArray alloc] init];
			HTTPProgress = true;
			RecievedData = @"";
			
			[self performSelectorOnMainThread:@selector(DoWeb:) withObject:[NSArray arrayWithObjects:@"http://www.faceparty.com/account/pest_list.aspx", @"", nil] waitUntilDone:NO];
			while (1)
			{
				[self nilFunction];
				if (HTTPProgress == false)
				{
					NSArray *tempArray = [RecievedData arrayOfCaptureComponentsMatchedByRegex:@"style=\"font-size:11px;\"> ([0-9]*) pests. Page 1 of ([0-9]*)</font>"];
				
					l = [[[tempArray objectAtIndex:0] objectAtIndex:2] intValue];
					i4 = 0;
					
					i5 = [tempArray count];
					while (i5 < 0)
					{
						[[tempArray objectAtIndex:(i5-1)] release];
						i5--;
					}
					
					while (i4 < l)
					{
						//Get pest list pages here and parse
						NSArray *tempArray = [RecievedData arrayOfCaptureComponentsMatchedByRegex:@"<b>([^<]*)</b></font></td><td>[&]nbsp;</td><td width=60>"];
						
						i2 = 0;
						while (i2 < tempArray.count)
						{

//							NSLog([[tempArray objectAtIndex:i2] objectAtIndex:1]);
							[PestList addObject:[[tempArray objectAtIndex:i2] objectAtIndex:1]];
							i2++;
						}
						i4++;

//	[URLConnection release];
						i5 = [tempArray count];
						while (i5 < 0)
						{
							[[tempArray objectAtIndex:(i5-1)] release];
							i5--;
						}

						//Got any additional pages to parse?
						if (i4 < l)
						{
							HTTPProgress = true;
							RecievedData = @"";
							[self performSelectorOnMainThread:@selector(DoWeb:) withObject:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@%d", @"http://www.faceparty.com/account/pest_list.aspx?Page=", (i4+1)], @"", nil] waitUntilDone:NO];

							while (HTTPProgress == TRUE)
							{
								[self nilFunction];
							}
						}
					}
//					NSLog([NSString stringWithFormat:@"%d", PestList.count]);
					break;
				}
			}
		}
		//Move from the login view to the loged-in view after a delay of 1 second (allows for the loader to dissepate)
		[NSThread sleepForTimeInterval:1];
		[self performSelectorOnMainThread:@selector(FrameTransition2:) withObject:[NSArray arrayWithObjects:LoginMenuView, kCATransitionPush, kCATransitionFromTop, nil] waitUntilDone:NO];
//Cookie testing!
//[NSThread sleepForTimeInterval:1];
//[self performSelectorOnMainThread:@selector(DoWeb:) withObject:[NSArray arrayWithObjects:@"http://www.faceparty.com/", @"", nil] waitUntilDone:NO];
		break;
	}
	else
	{
		//Invalid username/password, or possible account locked out. Let's run some tests;
		if (NSEqualRanges(NSMakeRange(NSNotFound, 0), [RecievedData rangeOfString:@"<B>The log in details you entered were incorrect"]) == 0)
		{
			//Invalid password; mark the password box in red
			Password.backgroundColor = [UIColor colorWithRed:0.967 green:0.325 blue:0.36 alpha:0.9];
			Password.textColor = [UIColor colorWithRed:0.967 green:0.325 blue:0.36 alpha:0.9];
			Password.font = [UIFont boldSystemFontOfSize:12];
		}
		else if (NSEqualRanges(NSMakeRange(NSNotFound, 0), [RecievedData rangeOfString:@"<B>Member not found"]) == 0)
		{
			//Invalid username; mark the usernme box in red
			Username.backgroundColor = [UIColor colorWithRed:0.967 green:0.325 blue:0.36 alpha:0.9];
			Username.textColor = [UIColor colorWithRed:0.967 green:0.325 blue:0.36 alpha:0.9];
			Username.font = [UIFont boldSystemFontOfSize:12];
		}
		else if (NSEqualRanges(NSMakeRange(NSNotFound, 0), [RecievedData rangeOfString:@"<B>You have supplied your details incorrectly"]) == 0)
		{
			//Account locked out.
//change this;
			[self performSelectorOnMainThread:@selector(ShowAlert:) withObject:[NSArray arrayWithObjects:@"Error Occured", @"Your account is locked out due to too many login failures. Please try again in 15 minutes.", nil] waitUntilDone:NO];
		}
		else if (NSEqualRanges(NSMakeRange(NSNotFound, 0), [RecievedData rangeOfString:@"<B>Sorry we cannot log you in at the moment. Please try again in a few seconds"]) == 0)
		{
			//FP is down
			[self performSelectorOnMainThread:@selector(ShowAlert:) withObject:[NSArray arrayWithObjects:@"Error Occured", @"Faceparty's database appears to be experiencing some problems and many features including authentication services are currently unavailable.\r\n\r\nPlease try logging in again in 5-15 minutes. We apologise for the inconvenience.", nil] waitUntilDone:NO];
		}
		else
		{
			//Unknown error
//			NSLog(RecievedData);
			[self performSelectorOnMainThread:@selector(ShowAlert:) withObject:[NSArray arrayWithObjects:@"Error Occured", @"Your login request could not be processed, this could be a problem with your internet connection or service provider.\r\nA proxy option is provided for ISPs that block requests to Faceparty directly in the settings screen.", nil] waitUntilDone:NO];
		}

		//Re-enable the login and password inputs, and the button after a short delay
		[Username setUserInteractionEnabled:YES];
		[Password setUserInteractionEnabled:YES];
		[NSThread detachNewThreadSelector:@selector(enableLoginBtn) toTarget:self withObject:nil];
	}
//	NSString *ReplyAA = [Gossip stringByEvaluatingJavaScriptFromString:@"csf.action"];
//	NSString *ReplyAA = [Gossip stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"csf\").action"];
			break;
		}
	}
	//Give the thread back!
	[pool release];
}

-(void)enableLoginBtn
{
	/* */
	
	//Go into a secondary thread
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	//Delay for a moment and enable the button again
	[NSThread sleepForTimeInterval:4.5];
	LoginBtn.enabled = TRUE;
	
	//Give the thread back!
	[pool release];
}

-(void)nilFunction
{
	/* Does nothing. But prevents a very bad xcode optimisation bug which is absolutely pathetic in this day and age */
}

-(void)GetCookies
{
	/* Takes cookie data from headers and puts it into an array */
	NSArray *Cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
	for (NSHTTPCookie *cookie in Cookies)
	{
		i = 0;
		while (i < CookieData.count)
		{
			if ([[cookie name] isEqualToString: [[CookieData objectAtIndex:i] objectAtIndex:0]])
			{
				[[CookieData objectAtIndex:i] release];
				[CookieData removeObjectAtIndex:i];
				i = CookieData.count;
			}
			i++;
		}
		[CookieData addObject:[[NSMutableArray alloc] initWithObjects:[cookie name], [cookie value], nil]];
	}
	//Retain cookie data, release cookie data
	[CookieData retain];
}

-(NSString*)SendCookies
{
	/* Gets cookie data from array and sends it back */

	i3 = 0;
	NSString *Cookies = [[NSString alloc] init];
	while (i3 < CookieData.count)
	{
		Cookies = [NSString stringWithFormat:@"%@%@%@%@", Cookies, [[CookieData objectAtIndex:i3] objectAtIndex:0], @"=", [[CookieData objectAtIndex:i3] objectAtIndex:1]];
		i3++;
		
		if (i3 < CookieData.count)
		{
			//Only append this if there is another piece of cookie data to send
			Cookies = [NSString stringWithFormat:@"%@%@", Cookies, @"; "];
		}
	}
	
	return [Cookies autorelease];
}

-(void)GetMessages
{
	/* */

	//Get the message and alert counts from either the login page of the messages page!
	NSArray *tempArray = [[NSArray alloc] init];
	//First, get the unread messages
	tempArray = [RecievedData arrayOfCaptureComponentsMatchedByRegex:@"class=myrl><a href=/message/inbox.aspx>([0-9]*) new message"];
	if (tempArray.count > 0 && [[[tempArray objectAtIndex:0] objectAtIndex:1] intValue] > 0)
	{
		//There are unread messages
		NewMessages = [[[tempArray objectAtIndex:0] objectAtIndex:1] intValue];
	}
	else
	{
		//No unread messages
		NewMessages = 0;
	}
	//Next; get the unread alerts
	tempArray = [RecievedData arrayOfCaptureComponentsMatchedByRegex:@"class=myrl><a href=/message/alerts.aspx>([0-9]*) new alert"];
	if (tempArray.count > 0 && [[[tempArray objectAtIndex:0] objectAtIndex:1] intValue] > 0)
	{
		//There are unread alerts
		NewAlerts = [[[tempArray objectAtIndex:0] objectAtIndex:1] intValue];
	}
	else
	{
		//No unread alerts
		NewAlerts = 0;
	}
//	NSLog([NSString stringWithFormat:@"%d%@%d", NewMessages, @" - ", NewAlerts]);
	//And so this temporary array is no longer needed.
	[self SetMessages];
}

-(void)SetMessages
{
	/* */

	if (NewMessages > 0 || NewAlerts > 0)
	{
		[MessagesBtn setBackgroundImage:[UIImage imageNamed:@"RedButton.png"] forState:UIControlStateSelected];
		[MessagesBtn setBackgroundImage:[UIImage imageNamed:@"RedButton.png"] forState:UIControlStateDisabled];
		[MessagesBtn setBackgroundImage:[UIImage imageNamed:@"RedButton.png"] forState:UIControlStateNormal];
		[MessagesBtn setTitleColor:[UIColor colorWithRed:0.967 green:0.325 blue:0.36 alpha:1.0] forState:UIControlStateSelected];
		[MessagesBtn setTitleColor:[UIColor colorWithRed:0.967 green:0.325 blue:0.36 alpha:1.0] forState:UIControlStateDisabled];
		[MessagesBtn setTitleColor:[UIColor colorWithRed:0.967 green:0.325 blue:0.36 alpha:1.0] forState:UIControlStateNormal];
		[NSThread sleepForTimeInterval:0.15];
		colourChange = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(ColChange) userInfo:nil repeats:YES];
		[colourChange retain];
//	[MessagesBtn setTitleColor:[UIColor colorWithRed:0.967 green:0.325 blue:0.36 alpha:1.0] forState:UIControlStateHighlighted];
	}
	else
	{		
		if ([colourChange isValid])
		{
			[colourChange invalidate];
		}
		
		[MessagesBtn setBackgroundImage:nil forState:UIControlStateSelected];
		[MessagesBtn setBackgroundImage:nil forState:UIControlStateDisabled];
		[MessagesBtn setBackgroundImage:nil forState:UIControlStateNormal];
		[MessagesBtn setTitleColor:LogoutBtn_MainMenu.currentTitleColor forState:UIControlStateSelected];
		[MessagesBtn setTitleColor:LogoutBtn_MainMenu.currentTitleColor forState:UIControlStateDisabled];
		[MessagesBtn setTitleColor:LogoutBtn_MainMenu.currentTitleColor forState:UIControlStateNormal];
	}

}

-(void)ColChange
{
	/* */
	if (LoginMenuView.superview && (NewMessages > 0 || NewAlerts > 0))
	{
		const float* colors = CGColorGetComponents( [MessagesBtn titleColorForState:UIControlStateNormal].CGColor );
		//((double)arc4random() / ARC4RANDOM_MAX)
		if (colors[0] < 0.12)
		{
			ColDirection = 0;
		}
		else if (colors[1] > 0.92)
		{
			ColDirection = 1;
		}
	
		if (ColDirection == 0)
		{
			[MessagesBtn setTitleColor:[UIColor colorWithRed:colors[0]+0.05 green:colors[1]+0.025 blue:colors[2]+0.032 alpha:0.8] forState:UIControlStateNormal];
		}
		else
		{
			[MessagesBtn setTitleColor:[UIColor colorWithRed:colors[0]-0.05 green:colors[1]-0.025 blue:colors[2]-0.032 alpha:0.7] forState:UIControlStateNormal];
		}
	
//		[colors release];
	}
	else
	{
		if ([colourChange isValid])
		{
			[colourChange invalidate];
		}
	}
}

-(IBAction)MessagesBtnClicked
{
	/* */

	[self FrameTransition:MessagesView];
}

-(IBAction)ViewMessagesBtnClicked
{
	//Goes to the view messages view and shows a list of messages
	[self FrameTransition:ViewMessagesView];
	viewMessagesTitle.title = @"FP Light • View Messages";
	viewMessagesWeb.dataDetectorTypes = UIDataDetectorTypeNone;
	MessageTypes = TRUE;
	[self DoWeb:[NSArray arrayWithObjects:@"http://www.faceparty.com/message/inbox.aspx", @"", nil]];
}

-(IBAction)ViewAlertsBtnClicked
{
	//Goes to the view alerts view and shows a list of alerts
	[self FrameTransition:ViewMessagesView];
	viewMessagesTitle.title = @"FP Light • View Alerts";
//	viewMessagesWeb.dataDetectorTypes = UIDataDetectorTypeLink;
	viewMessagesWeb.dataDetectorTypes = UIDataDetectorTypeNone;
	MessageTypes = FALSE;
	[self DoWeb:[NSArray arrayWithObjects:@"http://www.faceparty.com/message/alerts.aspx", @"", nil]];
}

-(IBAction)ViewMessagesBackBtnClicked
{
	/* */
//	NSLog([viewMessagesWeb stringByEvaluatingJavaScriptFromString:@"document.all[0].innerHTML"]);
//	NSLog([viewMessagesWeb stringByEvaluatingJavaScriptFromString:@"document.documentElement.innerHTML"]);
	[self FrameTransition:MessagesView];
}

-(void)PerformJavascript:(NSString*) Javascript
{
	/* */

	//Reset the text variable
	ReturnString = @"";
	
	//Just execute a standard javascript request on the UIWeb object
	ReturnString = [GossipWeb stringByEvaluatingJavaScriptFromString:Javascript];
	
}

-(void)ReleaseRecievedData
{
/*	if ([RecievedData retainCount] < 400)
	{
		while ([RecievedData retainCount] > 2)
		{
			[RecievedData release];
		}
	}*/
}

-(void)DoWeb:(NSArray*) Params
{
	/* */
	//Enable loading overlay
	[self LoadingOverlay:1];
	
	//Split the array into parameters
	NSString* URL = [[NSString alloc] initWithString:[Params objectAtIndex:0]];
	NSString* POST = [[NSString alloc] initWithString:[Params objectAtIndex:1]];

	//Mark that a HTTP request is in progress
	HTTPProgress = TRUE;
	
	//Clear the recieved-text buffer
	[self ReleaseRecievedData];
	
	NSLog([NSString stringWithFormat:@"RTN1: %d", [RecievedData retainCount]]);
	RecievedData = [[NSMutableString alloc] init];
	NSLog([NSString stringWithFormat:@"RTN2: %d", [RecievedData retainCount]]);
//	[RecievedData retain];

	//Check if the proxy mode is active or not
	if (NSEqualRanges(NSMakeRange(NSNotFound, 0), [URL rangeOfString:@"fplight_news"]) != 0)
	{
		if (HTTPProxy == TRUE)
		{
			//Proxify the URL and forward it via HTTPS!
			NSArray *replacements = [[NSArray alloc] initWithObjects:@"http://", @"www.", @"faceparty.com", nil];

			i = 0;
			while (i < replacements.count)
			{
				URL = [URL stringByReplacingOccurrencesOfString:[replacements objectAtIndex:i] withString:@""];
				i++;
			}
			//Free up some memory
			[replacements release];
		
			//Add the proxy details...
			URL = [NSString stringWithFormat:@"%@%@", @"http://www.URL_REMOVED.com/proxy.php?k=key&URL=", [self URLencode:URL]];
		}
	}

	//The URL to request
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
	baseURL = URL;

	//Append Cookie data if it's available
	if (CookieData.count > 1)
	{
		i = 0;
		[request setValue:[self SendCookies] forHTTPHeaderField:@"Cookie"];
	}

	//set HTTP Method (GET/POST)
	if (POST.length > 2)
	{
		//We're sending via POST
		[request setHTTPMethod:@"POST"];
		[request setHTTPBody:[POST dataUsingEncoding:NSUTF8StringEncoding]];
	}
	else
	{
		//We're using a standard GET
		[request setHTTPMethod:@"GET"];
	}

	//Send the request to the server !	  
/*	NSURLConnection *theConnection =*/ //[[NSURLConnection alloc] initWithRequest:request delegate:self];
//	[NSURLConnection connectionWithRequest:request delegate:self];
	NSURLConnection *URLConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];

	//No longer needed
//	[request release];
	[URL release];
	[POST release];
}
/////////
-(void)DoImageWeb
{
	//WORKIN' HEIR
	/* */
	
	//Check if the proxy mode is active or not
	if (HTTPProxy == TRUE)
	{
		[self performSelector:@selector(ShowAlert:) withObject:[NSArray arrayWithObjects:@"Error Uploading", @"Picture uploading is not supporting using the proxy mode.\r\nYou need to either disable the proxy or upload from a different supported device.", nil] afterDelay:0.0];
	}
	else
	{
		//STCHOP! This uploads a friggin image to the member id above! :|
		
		//Enable loading overlay
		[self LoadingOverlay:1];
	
		//Split the array into parameters
//		NSString* URL = [[NSString alloc] initWithString:[Params objectAtIndex:0]];
//		NSString* POST = [[NSString alloc] initWithString:[Params objectAtIndex:1]];
	
		//Mark that a HTTP request is in progress
		HTTPProgress = TRUE;
	
		//Clear the recieved-text buffer
		[RecievedData release];
		RecievedData = [[NSMutableString alloc] init];

		//The URL to request
		NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://tools.faceparty.com/upload_picture.aspx"]];
		baseURL = @"http://tools.faceparty.com/upload_picture.aspx";
	
		//We're sending a picture so obviously it'll be via POST
		[request setHTTPMethod:@"POST"];
		
		//Append Cookie data if it's available
		if (CookieData.count > 1)
		{
			i = 0;
			[request setValue:[self SendCookies] forHTTPHeaderField:@"Cookie"];
		}
		//Additional-data information
		[request addValue:@"multipart/form-data; boundary=---------------------------5917415734901424982746591174" forHTTPHeaderField: @"Content-Type"];

		NSMutableData *body = [NSMutableData alloc];
		/*
		 OK! Now I need to; get member_id
		 galleries and gallery IDs
		 */
		[body appendData:[@"\r\n-----------------------------5917415734901424982746591174\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[@"Content-Disposition: form-data; name=\"member_id\"\r\n\r\n8310267" dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[@"\r\n-----------------------------5917415734901424982746591174\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[@"Content-Disposition: form-data; name=\"gallery_id\"\r\n\r\n0" dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[@"\r\n-----------------------------5917415734901424982746591174\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[@"Content-Disposition: form-data; name=\"image_caption\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[ImageTitle.text dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[@"\r\n-----------------------------5917415734901424982746591174\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[@"Content-Disposition: form-data; name=\"image_description\"\r\n\r\n(FP Light by thedjnK) " dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[ImageDescription.text dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[@"\r\n-----------------------------5917415734901424982746591174\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[@"Content-Disposition: form-data; name=\"is_adult\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
		//AVS:
		if (AdultPublicSelector.selectedSegmentIndex == 0)
		{
			[body appendData:[@"no" dataUsingEncoding:NSUTF8StringEncoding]];
		}
		else
		{
			[body appendData:[@"yes" dataUsingEncoding:NSUTF8StringEncoding]];
		}
		[body appendData:[@"\r\n-----------------------------5917415734901424982746591174\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[@"Content-Disposition: form-data; name=\"i_protect\"\r\n\r\nno" dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[@"\r\n-----------------------------5917415734901424982746591174\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[@"Content-Disposition: form-data; name=\"f1\"; filename=\"FPLightBythedjnKUpload_username.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[NSData dataWithData:UploadImage]];
		[body appendData:[@"\r\n-----------------------------5917415734901424982746591174--\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
		
		/*
		 On checking page later;
		 <!-- Status:1:Status -->
		 = success
		 */
		// setting the body of the post to the reqeust
		[request setHTTPBody:body];
	
		//Send the request to the server !
		[NSURLConnection connectionWithRequest:request delegate:self];

		//No longer needed
		[request release];
		[body release];
		[UploadImage release];
	}
}
/////////

-(NSArray *)Arrayencode: (NSString *)String1 String2:(NSString *)String2
{
	/* Returns an array for use in the Web function */

	return [[NSArray arrayWithObjects:String1, String2, nil] autorelease];
}

-(NSString *)URLencode: (NSString *)EncString
{
	/* Encodes a string to be HTTP/1.1 POST complient */
	return [[[[[[[[[[[[[[[[[[EncString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByReplacingOccurrencesOfString:@"&" withString:@"%26"] stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"] stringByReplacingOccurrencesOfString:@"," withString:@"%2C"] stringByReplacingOccurrencesOfString:@"/" withString:@"%2F"] stringByReplacingOccurrencesOfString:@":" withString:@"%3A"] stringByReplacingOccurrencesOfString:@";" withString:@"%3B"] stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"] stringByReplacingOccurrencesOfString:@"\?" withString:@"%3F"] stringByReplacingOccurrencesOfString:@"@" withString:@"%40"] stringByReplacingOccurrencesOfString:@" " withString:@"%20"] stringByReplacingOccurrencesOfString:@"\t" withString:@"%09"] stringByReplacingOccurrencesOfString:@"#" withString:@"%23"] stringByReplacingOccurrencesOfString:@"<" withString:@"%3C"] stringByReplacingOccurrencesOfString:@">" withString:@"%3E"] stringByReplacingOccurrencesOfString:@"\n" withString:@"%0A"] stringByReplacingOccurrencesOfString:@"\"" withString:@"%22"] autorelease];
}
	//Old stuff! Kept in-case something might be needed in 20 years.. ;)
	/*
	NSString* html = [NSString stringWithFormat:baseURL, @"http://www.google.com", 200, 200];  
	[Gossip loadHTMLString:baseURL baseURL:nil];
	
	NSString *baseURL = @"http://www.av.com";
	NSURL *url = [NSURL URLWithString:baseURL];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	[Gossip loadRequest:requestObj];
	[Gossip release];
	
    NSURL *url = [NSURL URLWithString:@"http://www.faceparty.com/gossip/default.aspx"];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
	 
	NSString *post = @"li_mn=&li_pwd=";
	NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
	NSMutableURLRequest *Login = [[[NSMutableURLRequest alloc] init] autorelease];
	[Login setURL:[NSURL URLWithString:@"http://www.faceparty.com/account/log_in.aspx"]];
	[Login setHTTPMethod:@"POST"];
	[Login setValue:postLength forHTTPHeaderField:@"Content-Length"];
	[Login setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[Login setHTTPBody:postData];
	
	NSError *error;
	NSURLResponse *response;
	NSData *urlData=[NSURLConnection sendSynchronousRequest:Login returningResponse:&response error:&error];
	NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
	*/

-(void)connection:(NSURLConnection *)theConnection didReceiveResponse:(NSURLResponse *)response
{
	/* */

//	NSHTTPURLResponse * httpResponse;
//    NSString * contentTypeHeader;
	
//	NSHTTPURLResponse *httpResponse = [[NSHTTPURLResponse alloc] init];
//	httpResponse = (NSHTTPURLResponse *) response;
//	httpResponse = nil;
//	[httpResponse dealloc];
	if([response respondsToSelector:@selector(statusCode)])
	{
		if([(NSHTTPURLResponse *)response statusCode] == 404 || [(NSHTTPURLResponse *)response statusCode] == 403)
		{
			NSLog(@"OHSHI...");
		}
	}

//	[WTFa setText:[NSString stringWithFormat:@"%d", httpResponse.statusCode]];
}

-(void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)data
{
	/* */

	NSString *DataStr = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
	if (DataStr.length > 2)
	{
//		RecievedData = [RecievedData stringByAppendingString:DataStr];
		RecievedData = [NSMutableString stringWithFormat:@"%@%@", RecievedData, DataStr];
	}

	[RecievedData retain];
	[DataStr release];
	
//	NSInteger dataLength = [data length];
//	NSInteger currentLength = 0;
/*	do
	{
		DataStr = DataStr + stringByAppendingString: [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
		currentLength = DataStr.length;
	} while (currentLength != dataLength);*/
}

-(void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error
{
	/* */
//THIS NEEDS TESTING :
}

-(void)connectionDidFinishLoading:(NSURLConnection *)theConnection
{
	/* */
	if ([baseURL isEqualToString:@"http://tools.faceparty.com/upload_picture.aspx"])
	{
		NSLog(RecievedData);
	}
	//temp thing above... TST4PIC LRN2TST ;)
	else if (ViewMessagesView.superview)
	{
		if (MessageTypes == TRUE)
		{
			/*
			 1 : dd.mm.yy
			 2 : status (2 = read, 1 = ?)
			 3 : nil if read, style=colour if unread
			 4 : messageID
			 5 : page=
			 6 : from
			 7 : user online?
			 11: title
			 
			 TODO: Get number of messages in total
			 */
			//Parse out messages
			NSArray *MessagesArray = [RecievedData arrayOfCaptureComponentsMatchedByRegex:@"face=\"Arial\"> ([0-9][0-9][.][0-9][0-9][.][0-9][0-9]) </font></td><td><img src=/im/shim.gif width=\"6\" height=\"1\"/><img width=\"13\" height=\"13\" src=\"/im/msg_([0-9]).gif\"></td><td><font size=\"2\" face=\"Arial\"><a (style=\"color:#FF0066\" )?href=read_message.aspx[?]message_id=([0-9]*)&page=([0-9]*)>([^<]*)</a>( [*] )?</font></td><td><font size=\"2\" face=\"Arial\"><a (style=\"color:#FF0066\" )?href=read_message.aspx[?]message_id=([0-9]*)&page=([0-9]*)>([^<]*)</a>"];
			NSInteger aba = 0;
			NSString *WebData = @"<html><head></head><body><div align=\"center\"><table width=\"98%%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">";
			NSString *LastDate = @"";
			//for local file access;
			NSString *imagePath = [[[[NSBundle mainBundle] resourcePath] stringByReplacingOccurrencesOfString:@"/" withString:@"//"] stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
			//end
			
			while (aba < MessagesArray.count)
			{
				if (![LastDate isEqualToString:[[MessagesArray objectAtIndex:aba] objectAtIndex:1]])
				{
					if (LastDate.length > 1)
					{
						WebData = [NSString stringWithFormat:@"%@%@", WebData, @"<tr><td colspan=\"2\"><br />"];
					}
					else
					{
						WebData = [NSString stringWithFormat:@"%@%@", WebData, @"<tr><td colspan=\"2\">"];
					}
					
					LastDate = [[MessagesArray objectAtIndex:aba] objectAtIndex:1];
					WebData = [NSString stringWithFormat:@"%@%@%@%@%@%@", WebData, @"<div align=\"center\"><b>", [[[[MessagesArray objectAtIndex:aba] objectAtIndex:1] stringByReplacingOccurrencesOfString:@"." withString:@"/"] substringToIndex:6], @"20", [[[MessagesArray objectAtIndex:aba] objectAtIndex:1] substringFromIndex:6], @"</b></div><br/></td></tr>"];
				}
				
				//(UN)READ: title: from user: (Online/offline) [ID:]
				//^^ Change into a flashing message for unread?
				
				if ([[[MessagesArray objectAtIndex:aba] objectAtIndex:2] isEqualToString:@"1"])
				{
					//Unread
					WebData = [NSString stringWithFormat:@"%@%@%@%@", WebData, @"<tr><td><img src=\"", CurrentTheme, @"_msg1.png\" />&nbsp;&nbsp;</td><td>"];
				}
				else if ([[[MessagesArray objectAtIndex:aba] objectAtIndex:2] isEqualToString:@"2"])
				{
					//Read
					WebData = [NSString stringWithFormat:@"%@%@%@%@", WebData, @"<tr><td><img src=\"", CurrentTheme, @"_msg2.png\" />&nbsp;&nbsp;</td><td>"];
				}
				else if ([[[MessagesArray objectAtIndex:aba] objectAtIndex:2] isEqualToString:@"3"])
				{
					//Replied
					WebData = [NSString stringWithFormat:@"%@%@%@%@", WebData, @"<tr><td><img src=\"", CurrentTheme, @"_msg3.png\" />&nbsp;&nbsp;</td><td>"];
				}
				else
				{
					//Unknown... Could this be the... LEGENDARY AUDIO MESSAGE OF 4!?
				}
				
				if (![[[MessagesArray objectAtIndex:aba] objectAtIndex:11] isEqualToString:@""])
				{
					//Title present
					WebData = [NSString stringWithFormat:@"%@%@%@%@%@%@", WebData, @"<a href=\"bob.html?M=", [[MessagesArray objectAtIndex:aba] objectAtIndex:4], @"\">\"", [[MessagesArray objectAtIndex:aba] objectAtIndex:11], @"\"</a>"];
				}
				else
				{
					//No title
				}
				
				//Append who the message is from
				WebData = [NSString stringWithFormat:@"%@%@%@%@%@%@", WebData, @" From <a href=\"", [[MessagesArray objectAtIndex:aba] objectAtIndex:4], @"\">", [[MessagesArray objectAtIndex:aba] objectAtIndex:6], @"</a>"];
				
				if ([[[MessagesArray objectAtIndex:aba] objectAtIndex:7] isEqualToString:@" * "])
				{
					//User online
					WebData = [NSString stringWithFormat:@"%@%@", WebData, @" (Online)"];
				}
				else
				{
					//User offline
				}
				
				WebData = [NSString stringWithFormat:@"%@%@", WebData, @"</td></tr>"];
				
				//			NSLog([NSString stringWithFormat:@"%@%d", @"#", aba]);
				//			i = 0;
				//			while (i < [[MessagesArray objectAtIndex:aba] count])
				//			{
				//				NSLog([NSString stringWithFormat:@"%d%@%@", i, @" - ", [[MessagesArray objectAtIndex:aba] objectAtIndex:i]]);	
				//				i++;
				//			}
				aba++;
			}
			WebData = [NSString stringWithFormat:@"%@%@", WebData, @"</table></div></body></html>"];
			//		[viewMessagesWeb loadHTMLString:[NSString stringWithFormat:@"%@%d%@", @"Times:", MessagesArray.count, RecievedData] baseURL:nil];
			[viewMessagesWeb loadHTMLString:WebData baseURL:[NSURL URLWithString: [NSString stringWithFormat:@"file:/%@//",imagePath]]];
		}
		else
		{
NSString *tempString = @"";
			NSArray *AlertsArray = [RecievedData arrayOfCaptureComponentsMatchedByRegex:@"class=bl><b>([a-zA-Z]*) comment from <a href=/([^>]*)>([^<]*)</a></b></font>(&nbsp;<font face=arial color=#FF0033 size=1 style=\"font-size:9px;\">new!</font>)?<[/]?td><td width=20></td></tr><tr><td colspan=3><img src=/im/shim.gif width=1 height=3 /></td></tr><tr><td colspan=3><font face=arial size=1 color=#999999 style=\"font-size:11px;\" class=bl>Posted on <a href=/([^>]*)>([^<]*)</a>( in gallery <a href=/gallery/pics.aspx[?]pid=([0-9]*)&gid=([0-9]*)>([^<]*)</a>)? at ([0-9]*):([0-9]*) on ([0-9]*) ([^ ]*) ([0-9]*)</td></tr><tr><td colspan=3><img src=/im/shim.gif width=1 height=5 /></td></tr><tr><td colspan=3><table width=457 cellpadding=0 border=0 cellspacing=1 bgcolor=#e5e5e5><tr><td bgcolor=#ffffff><table width=455 cellpadding=0 cellspacing=10 border=0><tr><td><font face=arial size=1 color=#333333 style=\"font-size:11px;\">(.*?)</font>"];
			i = 0;
			while (i < [AlertsArray count])
			{
				/*
				 1  = photo/profile
				 2  = from
				 4  =	
				 5  = (?) profile URL?
				 6  = posting location
				 8  = (!) Profile ID
				 9  = (!) Gallery ID
				 10 = (!) Gallery name
				 11 = hh
				 12 = mm
				 13 = dd
				 14 = month
				 15 = yyyy
				 16 = message
				*/
				
				//AND DER TREI
				/*
				NSLog([NSString stringWithFormat:@"TYPE (1): %@", [[AlertsArray objectAtIndex:i] objectAtIndex:1]]); //Type of comment (photo, profile, etc)
				NSLog([NSString stringWithFormat:@"FROM (2): %@", [[AlertsArray objectAtIndex:i] objectAtIndex:2]]); //from
				NSLog([NSString stringWithFormat:@" (4): %@", [[AlertsArray objectAtIndex:i] objectAtIndex:4]]); //if its new ?
				NSLog([NSString stringWithFormat:@"TO (5): %@", [[AlertsArray objectAtIndex:i] objectAtIndex:5]]); //profile name (user) or URL gallery/view.aspx?pid=8310267&iid=35663320
				NSLog([NSString stringWithFormat:@"WHERE? (6): %@", [[AlertsArray objectAtIndex:i] objectAtIndex:6]]); //'untitled image' / 'your profile'
				NSLog([NSString stringWithFormat:@"?? (7): %@", [[AlertsArray objectAtIndex:i] objectAtIndex:7]]); //
				NSLog([NSString stringWithFormat:@"?? (8): %@", [[AlertsArray objectAtIndex:i] objectAtIndex:8]]); //IMG ONLY (PID)
				NSLog([NSString stringWithFormat:@"?? (9): %@", [[AlertsArray objectAtIndex:i] objectAtIndex:9]]); //IMG ONLY (GID)
				NSLog([NSString stringWithFormat:@"?? (10): %@", [[AlertsArray objectAtIndex:i] objectAtIndex:10]]); //IMG ONLY (gallery name)
				NSLog([NSString stringWithFormat:@"HH (11): %@", [[AlertsArray objectAtIndex:i] objectAtIndex:11]]); //HH
				NSLog([NSString stringWithFormat:@"MM (12): %@", [[AlertsArray objectAtIndex:i] objectAtIndex:12]]); //MM
				NSLog([NSString stringWithFormat:@"DD (13): %@", [[AlertsArray objectAtIndex:i] objectAtIndex:13]]); //DD
				NSLog([NSString stringWithFormat:@"MONTH (14): %@", [[AlertsArray objectAtIndex:i] objectAtIndex:14]]); //Mon
				NSLog([NSString stringWithFormat:@"YYYY (15): %@", [[AlertsArray objectAtIndex:i] objectAtIndex:15]]); //YYYY
				NSLog([NSString stringWithFormat:@"MSG (16): %@", [[AlertsArray objectAtIndex:i] objectAtIndex:16]]); //Message
				NSLog([NSString stringWithFormat:@"-> %i", [[AlertsArray objectAtIndex:i] count]]);*/
				tempString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@", tempString, @"<a href=\"\">(", [[AlertsArray objectAtIndex:i] objectAtIndex:2], @") [", [[AlertsArray objectAtIndex:i] objectAtIndex:13], @"/", [[AlertsArray objectAtIndex:i] objectAtIndex:14], @"/", [[AlertsArray objectAtIndex:i] objectAtIndex:15], @"]:</a><br /><i>", [[AlertsArray objectAtIndex:i] objectAtIndex:16], @"</i><br /><br />"];
				i++;
			}
//			<font face=arial color=#333333 size=1 style="font-size:11px;"> 3807 alerts. Page 1 of 381</font>
		[viewMessagesWeb loadHTMLString:tempString baseURL:nil];
		}
	}
	else if (GossipView.superview)
	{
		NSLog(@"INB4");
		if ([URLRequest isEqualToString:@"thread"])
		{
			//Getting a thread from gossip
			NSArray *tempArray = [RecievedData arrayOfCaptureComponentsMatchedByRegex:@"(?s)class=gTopLink>by <a href=\"/([^\"]*)\">([^\"]*)</a> (about a minute|[0-9]* (minutes|mins|hours|days)) ago</div><div style=\"font-size:12px;color:#333333;margin:7px 0px 7px 0px;\"><b>([^<]*)</b></div><div style=\"font-size:10px;color:#666666;\">(.*?)</div></font>"];
			NSString *tempString = @"";
			NSMutableString *tempString2;

			if (tempArray.count < 1 || ([[[tempArray objectAtIndex:0] objectAtIndex:5] length] < 1 && [[[tempArray objectAtIndex:0] objectAtIndex:6] length] < 1))
			{
				//Thread doesn't exist
				tempString = @"No such thread.";
				[GossipWeb loadHTMLString:tempString baseURL:nil];
			}
			else
			{
				
				//Thread exists!
				tempString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@", @"<script src=\"http://www.URL_REMOVED.com/test.js\"></script><meta name=\"viewport\" content=\"initial-scale = 0.9\" /><table border=\"1\" cellpadding=\"0\" cellspacing=\"1\" width=\"320\"><tr><td>", @"By ", [[tempArray objectAtIndex:0] objectAtIndex:1], @" (", [[tempArray objectAtIndex:0] objectAtIndex:2], @")\r\n<br>Posted: ", [self NormaliseTime:[[tempArray objectAtIndex:0] objectAtIndex:3]], @"\r\n<br>Title: ", [[tempArray objectAtIndex:0] objectAtIndex:5], @"\r\n<br>Body: ", [[[tempArray objectAtIndex:0] objectAtIndex:6] stringByReplacingOccurrencesOfRegex:@"(?s)<img src=(.*?)[/]?>" withString:@""], @"</td></tr>"];
				/*
				 Topic:
				 1 = thread starter
				 3 = time posted
				 5 = title
				 6 = body
				 
				 Page Numbers:
				 1 = first post number (page)
				 2 = last post number (page)
				 3 = total number of posts
				 
				 Replies:
				 1 = poster
				 3 = time
				 4 = message
				 */
				//get replies
				tempArray = [RecievedData arrayOfCaptureComponentsMatchedByRegex:@"(?s)class=sgtlink>by <a href=/([^\"]*)>([^\"]*)</a> (about a minute|[0-9]* (minutes|mins|hours|days)) ago</font><BR><img src=/im/shim.gif width=1 height=2 /><BR><font face=arial size=2 color=#666666 style=\"font-size:12px;\">(.*?)</font></td>"];
				i = 0;
				while (i < tempArray.count)
				{
					tempString2 = [NSMutableString stringWithString:[[tempArray objectAtIndex:i] objectAtIndex:5]];
//					[tempString2 replaceOccurrencesOfRegex:@"(http://www.|http://|www.)you[ ]?tube[ ]?.[ ]?c[ ]?o[ ]?m/[ ]?wat[ ]?c[ ]?h[ ]?[?][ ]?[ ]?v[ ]?=[ ]?([a-zA-Z0-9][ ]?[a-zA-Z0-9][ ]?[a-zA-Z0-9][ ]?[a-zA-Z0-9][ ]?[a-zA-Z0-9][ ]?[a-zA-Z0-9][ ]?[a-zA-Z0-9][ ]?[a-zA-Z0-9][ ]?[a-zA-Z0-9][ ]?[a-zA-Z0-9]?[ ]?[a-zA-Z0-9]?)" withString:@"<a href=\"http://www.youtube.com/watch?v=$2\">http://www.youtube.com/watch?v=$2</a>"];
					NSLog(@"OKHERE: ");
NSLog([[tempString2 componentsMatchedByRegex:@"(http://www.|http://|www.)you[ ]?tube[ ]?.[ ]?c[ ]?o[ ]?m/[ ]?wat[ ]?c[ ]?h[ ]?[?][ ]?[ ]?v[ ]?=[ ]?([a-zA-Z0-9][ ]?[a-zA-Z0-9][ ]?[a-zA-Z0-9][ ]?[a-zA-Z0-9][ ]?[a-zA-Z0-9][ ]?[a-zA-Z0-9][ ]?[a-zA-Z0-9][ ]?[a-zA-Z0-9][ ]?[a-zA-Z0-9][ ]?[a-zA-Z0-9]?[ ]?[a-zA-Z0-9]?)"] count]);
					tempString = [NSString stringWithFormat:@"%@%@%@%@%@%@%d%@%d%@%@%@%d%@", tempString, @"<tr><td><hr>", [[tempArray objectAtIndex:i] objectAtIndex:1], @" - ", [self NormaliseTime:[[tempArray objectAtIndex:i] objectAtIndex:3]], @"<br /><span name=\"Quote_", i, @"\" id=\"Quote_", i, @"\">", tempString2, @"</span><br /><input onclick='var ta=document.createElement(\"textarea\"); ta.innerHTML=Quote_", i, @".innerHTML.replace(/<br>/g, \"\\r\\n\"); alert(ta.value); document.removeElement(ta);' type=\"button\" value=\"Quote\" /></td></tr>"];
//					tempString = [NSString stringWithFormat:@"%@%@%@%@%@%@%d%@%d%@%@%@%d%@", tempString, @"<tr><td><hr>", [[tempArray objectAtIndex:i] objectAtIndex:1], @" - ", [self NormaliseTime:[[tempArray objectAtIndex:i] objectAtIndex:3]], @"<br /><span name=\"Quote_", i, @"\" id=\"Quote_", i, @"\">", [[tempArray objectAtIndex:i] objectAtIndex:5], @"</span><br /><input onclick='var ta=document.createElement(\"textarea\"); ta.innerHTML=Quote_", i, @".innerHTML.replace(/<br>/g, \"\\r\\n\"); alert(ta.value); document.removeElement(ta);' type=\"button\" value=\"Quote\" /></td></tr>"];
					i++;
				}
				
				//get number of pages and posts
//THIS NEEDS TESTING WITH THE frmPaG THING
//				tempArray = [RecievedData arrayOfCaptureComponentsMatchedByRegex:@"class=frmPa(G)?>>> |</a><span class=frmPaI>([0-9]*) to ([0-9]*) of ([0-9]*)</span>"];
tempArray = [RecievedData arrayOfCaptureComponentsMatchedByRegex:@"(</a><span class=frmPa[C|G]?>([0-9]*)</span><span class=frmPa[G]?>Next</span><span class=frmPa[G]?>>> [|]</span>|<a href=\"thread.aspx[?]topic=([0-9]*)&page=([0-9]*)\" class=frmPa[G]?>>> [|]</a>)<span class=frmPaI>([0-9]*) to ([0-9]*) of ([0-9]*)</span>"];
				tempString = [NSString stringWithFormat:@"%@%@", tempString, @"<a href=\"thread:856973.5\">5</a> . "];
				tempString = [NSString stringWithFormat:@"%@%@", tempString, @"<a href=\"thread:856973.6\">6</a> . "];
				tempString = [NSString stringWithFormat:@"%@%@", tempString, @"<a href=\"thread:861458.2\">A</a> . "];
				tempString = [NSString stringWithFormat:@"%@%@", tempString, @"<a href=\"thread:877458.1\">B</a> . "];
				tempString = [NSString stringWithFormat:@"%@%@", tempString, @"<a href=\"thread:881690.1\">THIS</a> . "];
				
//				tempString = [NSString stringWithFormat:@"%@%@%@", tempString, @"<br />", [[tempArray objectAtIndex:0] objectAtIndex:3], @" Posts in ", x, @" Pages."];
//Working right here
				if (tempArray.count > 0)
				{
					if ([[tempArray objectAtIndex:0] count] > 5 && [[[tempArray objectAtIndex:0] objectAtIndex:3] integerValue] > 1)
					{
//						tempString = [NSString stringWithFormat:@"%@ %@ Pages, %@ Posts (%@-%@)", tempString, [[tempArray objectAtIndex:0] objectAtIndex:4], [[tempArray objectAtIndex:0] objectAtIndex:7], [[tempArray objectAtIndex:0] objectAtIndex:5], [[tempArray objectAtIndex:0] objectAtIndex:6]];
						/*
						 not final page:
						 3 = thread ID
						 4 = total pages
						 5 = first post ID on page
						 6 = last post ID on page
						 7 = total number of posts
						 */
//						tempArray = [RecievedData arrayOfCaptureComponentsMatchedByRegex:@"<a href=\"thread.aspx[?]topic=([0-9]*)&page=([0-9]*)&action=track\"><img src=/im/fm/track_topic.gif width=50 height=20 border=0 /></a>"];
					}
					else
					{
//						tempString = [NSString stringWithFormat:@"%@ %@ Pages, %@ Posts (%@-%@)", tempString, [[tempArray objectAtIndex:0] objectAtIndex:2], [[tempArray objectAtIndex:0] objectAtIndex:7], [[tempArray objectAtIndex:0] objectAtIndex:5], [[tempArray objectAtIndex:0] objectAtIndex:6]];
						/*
						 final page:
						 2 = page number
						 5 = first post ID on page
						 6 = last post ID on page
						 7 = total number of posts
						 */
//						tempArray = [RecievedData arrayOfCaptureComponentsMatchedByRegex:@"<a href=\"thread.aspx[?]topic=([0-9]*)&page=([0-9]*)&action=track\"><img src=/im/fm/track_topic.gif width=50 height=20 border=0 /></a>"];
					}
				}
				else
				{
//					tempArray = [RecievedData arrayOfCaptureComponentsMatchedByRegex:@"<a href=\"thread.aspx[?]topic=([0-9]*)&page=([0-9]*)&action=track\"><img src=/im/fm/track_topic.gif width=50 height=20 border=0 /></a>"];
					/*
					 No page numbers/post numbers:
					 1 = thread ID
					 2 = page number
					 */
					if (i > 0)
					{
						//Posts !
//						tempString = [NSString stringWithFormat:@"%@ Page %@ (1-%d), Thread #%@", tempString, [[tempArray objectAtIndex:0] objectAtIndex:2], i, [[tempArray objectAtIndex:0] objectAtIndex:1]];
					}
					else
					{
						//No posts
//						tempString = [NSString stringWithFormat:@"%@ Page %@ (0), Thread #%@", tempString, [[tempArray objectAtIndex:0] objectAtIndex:2], [[tempArray objectAtIndex:0] objectAtIndex:1]];
					}
				}
				//Working here
				//Insert the reply part of the page
//				tempString = [NSString stringWithFormat:@"%@<form action=\"reply:%@%@%@%@", tempString, [[tempArray objectAtIndex:0] objectAtIndex:1], @".", [[tempArray objectAtIndex:0] objectAtIndex:2], @"\" method=\"post\"><textarea name=\"replytext\" id=\"replytext\"></textarea><br /><input type=\"submit\" value=\"post\" /></form>"];
				
				//Load the page in the web object
				[GossipWeb loadHTMLString:tempString baseURL:nil];
				RecievedData = [NSMutableString stringWithFormat:@""];
				[RecievedData retain];
			}

//			NSLog([NSString stringWithFormat:@"%@", [[tempArray objectAtIndex:0] objectAtIndex:1]]);
			
			//[GossipWeb loadHTMLString:RecievedData baseURL:nil];
		}
		else
		{
			//Unknwon; assume retrieving a list of topics
			
			NSArray *Threads = [RecievedData arrayOfCaptureComponentsMatchedByRegex:@"class=\"sgtlink\">In <a href=\"topics.aspx[?]cat=([0-9]*)\">([^<]*)</a>, by <a href=\"/([^<]*)\">([^<]*)</a></font></td></tr><tr><td><img src=/im/shim.gif width=1 height=2 /></td></tr><tr><td><font face=\"arial\" size=\"2\" style=\"font-size:11px;\" class=\"gblinks\"><a href=\"thread.aspx[?]topic=([0-9]*)\">([^<]*) [(]([0-9]*)[)]</a>"];
//		Threads = [RecievedData arrayOfCaptureComponentsMatchedByRegex:@"class=\"sgtlink\">In <a href=\"topics.aspx[?]cat=([0-9]*)\">([^<]*)</a>, by <a href=\"/([^<]*)\">([^<]*)</a></font></td></tr><tr><td><img src=/im/shim.gif width=1 height=2 /></td></tr><tr><td><font face=\"arial\" size=\"2\" style=\"font-size:11px;\" class=\"gblinks\"><a href=\"thread.aspx[?]topic=([0-9]*)\">([^<]*)</a>"];
			/*
			 0 = unassign
			 1 = catID
			 2 = catNAME
			 3 = poster
			 4 = unassign
			 5 = threadID
			 6 = title
			 7 = post count
			 */
			//		RecievedData = @"";
			
			//Clear the recieved-text buffer
			[self ReleaseRecievedData];
			RecievedData = [[NSMutableString alloc] initWithString:@"<html><head><meta name=\"viewport\" content=\"initial-scale = 0.9\" /><style>\r\nbody {margin:0px;padding:0px;}\r\nbackground:#ffe;width:80%;#titlepost {background:#eff;clear:both;width:80%;}A:link {color:#223399;}A:active {color:#223399;}A:visited {color:#992233;}</style></head><body>\r\n<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" align=\"center\" width=\"320\">"];
			if (Threads.count > 0)
			{
				i = 0;
				while (i < Threads.count)
				{
					//Check if the pest-list is active; if so then do some filtering!
					if (PestListActive == TRUE)
					{
						FoundPestList = FALSE;
					
						for (NSString *thisUser in PestList)
						{
							if ([thisUser isEqualToString:[[Threads objectAtIndex:i] objectAtIndex:3]])
							{
								FoundPestList = TRUE;
							}
						}
					
						if (FoundPestList == FALSE)
						{
							RecievedData = [NSMutableString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@", RecievedData, @"<tr><td colspan=\"1\">", [[Threads objectAtIndex:i] objectAtIndex:3], @"</td><td colspan=\"1\"><div align=\"right\">", [[Threads objectAtIndex:i] objectAtIndex:2], @"</div></td></tr><tr><td colspan=\"2\"><div align=\"center\"><a href=\"thread:", [[Threads objectAtIndex:i] objectAtIndex:5], @".1\">", [[Threads objectAtIndex:i] objectAtIndex:6], @"</a> [", [[Threads objectAtIndex:i] objectAtIndex:7], @"]</div><br /></td></tr>"];	
						}
					}
					else
					{
						//RecievedData = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@", RecievedData, @"<img src=\"", CurrentTheme, @"_cat", [[Threads objectAtIndex: i] objectAtIndex:1], @".gif\" width=\"30\" /><br /><a href=\"", [[Threads objectAtIndex: i] objectAtIndex:5], @"\">", [[Threads objectAtIndex:i] objectAtIndex:6], @" - ", [[Threads objectAtIndex: i] objectAtIndex:3], @"</a><br /><br />"];
						RecievedData = [NSMutableString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@", RecievedData, @"<tr><td colspan=\"1\"><font face=\"Helvetica\">", [[Threads objectAtIndex:i] objectAtIndex:3], @"</font></td><td colspan=\"1\"><div align=\"right\"><font face=\"Helvetica\">", [[Threads objectAtIndex:i] objectAtIndex:2], @"</font></div></td></tr><tr><td colspan=\"2\"><div align=\"center\"><font face=\"Helvetica\"><a href=\"thread:", [[Threads objectAtIndex:i] objectAtIndex:5], @".1\">", [[Threads objectAtIndex:i] objectAtIndex:6], @"</a> [", [[Threads objectAtIndex:i] objectAtIndex:7], @"]</font></div><br /><br /></td></tr>"];	
					}
					i++;
				}
			}
		
			RecievedData = [NSMutableString stringWithFormat:@"%@%@", RecievedData, @"</table></body></html>\r\n"];
			[GossipWeb loadHTMLString:RecievedData baseURL:[NSURL URLWithString: [NSString stringWithFormat:@"file:/%@//",[[[[NSBundle mainBundle] resourcePath] stringByReplacingOccurrencesOfString:@"/" withString:@"//"] stringByReplacingOccurrencesOfString:@" " withString:@"%20"]]]];
			
			//Memory management!
			RecievedData = [NSMutableString stringWithFormat:@""];
			[RecievedData retain];
		}
//	RecievedData = [NSString stringWithFormat:@"%@%@", RecievedData, @"<body><form name=\"aform\" id=\"aform\" method=\"get\" action=\"#\"><textarea onclick=\"this.value=this.id\" name=\"ThreadReply\" id=\"ThreadReply\"></textarea><input type=\"submit\" /></form><a href=\"http://www.google.com\">GTFO</a></body>"];

//	[WTFa setText:[NSString stringWithFormat:@"%@", Threads[0]]];
	
//	[WTFa setText:[Threads objectAtIndex:4]];
//	NSString *str = [NSString stringWithFormat:@"%d", x];
	}
	else if (FriendListView.superview)
	{
		//Load the friends list.
		if ([URLRequest isEqualToString:@"all_p1"])
		{
			//Tempoary variables
			NSArray *tempArray = [RecievedData arrayOfCaptureComponentsMatchedByRegex:@"(?s)style=\"font-size:11px;\"> ([0-9]*) friends. Page ([0-9]*) of ([0-9]*)</font>"];
			NSArray *tempArray2 = [RecievedData arrayOfCaptureComponentsMatchedByRegex:@"(?s)<tr><td bgcolor=\"#FFFFFF\" align=\"center\"><a href=/([^<]*)><img border=\"0\" width=\"32\" height=\"38\" src=\"([^\"]*)\" /></a></td></tr></table></td>(.*?)size=1 style=\"font-size:11px;\">(([0-9]*[.][0-9]*[.][0-9]*)|online)</font></td>(.*?)<a href=\"/member/rate_member.aspx[?]pid=([0-9]*)&pnam"];
			NSString *tempString = @"";
			//Put a 'loading' text on the actual web object for now.
			[FriendListWeb loadHTMLString:@"<html><head><meta name=\"viewport\" content=\"initial-scale = 1.0\" /></head><body><div align=\"center\"><h2>Loading #1...</h2></div></body></html>\r\n" baseURL:nil];
			/*
			 1 = username
			 2 = picture
			 4 = last online dd.mm.yy / online
			 7 = user id
			 */
			i = 0;
			while (i < [tempArray2 count])
			{
				tempString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@", tempString, @"<tr><td>", [[tempArray2 objectAtIndex:i] objectAtIndex:1], @"</td><td><a href=\"", [self LargerPics:[[tempArray2 objectAtIndex:i] objectAtIndex:2]], @"\"><img src=\"", [[tempArray2 objectAtIndex:i] objectAtIndex:2], @"\" /></a></td><td ", [self ChangeDate:[[tempArray2 objectAtIndex:i] objectAtIndex:4]], @"</td><td>", [[tempArray2 objectAtIndex:i] objectAtIndex:7], @"</td></tr>\r\n"];
				i++;
			}

			//Run this again with the next page if there is another page
			if ([[[tempArray objectAtIndex:0] objectAtIndex:3] integerValue] > 1)
			{
				//And next page, first save and retain the data
				ReturnString = [NSString stringWithFormat:@"%@%@%@%@", @"<html><head><script src=\"sorttable.js\"></script><meta name=\"viewport\" content=\"initial-scale = 1.0\" /><style>table.sortable thead { background-color:#eee; color:#666666; font-weight: bold; cursor: default; }</style></head><body><h1>Total friends: ", [[tempArray objectAtIndex:0] objectAtIndex:1], @"</h1><table width=\"100%\" border=\"2\" cellpadding=\"2\" cellspacing=\"2\" class=\"sortable\"><tr><td>Username</td><td class=\"sorttable_nosort\">Pic</td><td>Online</td><td>ID</td></tr>", [tempString stringByReplacingOccurrencesOfString:@"/im/p_nam.gif" withString:@"http://www.faceparty.com/im/p_nam.gif"]];
				[ReturnString retain];
				//And now prepare the HTTP request
				URLRequest = @"all";
				[URLRequest retain];
				[self DoWeb:[NSArray arrayWithObjects:@"http://www.faceparty.com/account/buddy_list.aspx?page=2", @"", nil]];
			}
			else
			{
				//No next page, so display all content here.
				[FriendListWeb loadHTMLString:[NSString stringWithFormat:@"%@%@%@%@%@", @"<html><head><meta name=\"viewport\" content=\"initial-scale = 1.0\" /></head><body><h1>Total friends: ", [[tempArray objectAtIndex:0] objectAtIndex:1], @"</h1><table width=\"100%\" border=\"2\" cellpadding=\"2\" cellspacing=\"2\"><tr><td>Username</td><td>Pic</td><td>Online</td><td>ID</td></tr>", [tempString stringByReplacingOccurrencesOfString:@"/im/p_nam.gif" withString:@"http://www.faceparty.com/im/p_nam.gif"], @"</table></body></html>\r\n\r\n"] baseURL:nil];
			}
		}
		else if ([URLRequest isEqualToString:@"all"])
		{
			//Not the first page, let's split this up to see what page we're on and how many we have left to parse through.
			NSArray *tempArray = [RecievedData arrayOfCaptureComponentsMatchedByRegex:@"(?s)Page ([0-9]*) of ([0-9]*)</font>"];
			NSString *tempString = @"";
			if ([[[tempArray objectAtIndex:0] objectAtIndex:1] integerValue] < [[[tempArray objectAtIndex:0] objectAtIndex:2] integerValue])
			{
				//One of the middle pages, keep parsin'...
				NSArray *tempArray2 = [RecievedData arrayOfCaptureComponentsMatchedByRegex:@"(?s)<tr><td bgcolor=\"#FFFFFF\" align=\"center\"><a href=/([^<]*)><img border=\"0\" width=\"32\" height=\"38\" src=\"([^\"]*)\" /></a></td></tr></table></td>(.*?)size=1 style=\"font-size:11px;\">(([0-9]*[.][0-9]*[.][0-9]*)|online)</font></td>(.*?)<a href=\"/member/rate_member.aspx[?]pid=([0-9]*)&pnam"];
				i = 0;
				while (i < [tempArray2 count])
				{
					tempString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@", tempString, @"<tr><td>", [[tempArray2 objectAtIndex:i] objectAtIndex:1], @"</td><td><a href=\"", [self LargerPics:[[tempArray2 objectAtIndex:i] objectAtIndex:2]], @"\"><img src=\"", [[tempArray2 objectAtIndex:i] objectAtIndex:2], @"\" /></a></td><td ", [self ChangeDate:[[tempArray2 objectAtIndex:i] objectAtIndex:4]], @"</td><td>", [[tempArray2 objectAtIndex:i] objectAtIndex:7], @"</td></tr>\r\n"];
					i++;
				}
				ReturnString = [NSString stringWithFormat:@"%@%@", ReturnString, [tempString stringByReplacingOccurrencesOfString:@"/im/p_nam.gif" withString:@"http://www.faceparty.com/im/p_nam.gif"]];
				[ReturnString retain];
				
				//Update the loading text
				[FriendListWeb loadHTMLString:[NSString stringWithFormat:@"%@%@%@", @"<html><head><meta name=\"viewport\" content=\"initial-scale = 1.0\" /></head><body><div align=\"center\"><h2>Loading #", [[tempArray objectAtIndex:0] objectAtIndex:1], @"...</h2></div></body></html>\r\n"] baseURL:nil];
				
				[self DoWeb:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@%i", @"http://www.faceparty.com/account/buddy_list.aspx?page=", [[[tempArray objectAtIndex:0] objectAtIndex:1] integerValue]+1], @"", nil]];
			}
			else
			{
				//The final page! Last parse through and hide the warning
				NSString *tempString = @"";				
				NSArray *tempArray2 = [RecievedData arrayOfCaptureComponentsMatchedByRegex:@"(?s)<tr><td bgcolor=\"#FFFFFF\" align=\"center\"><a href=/([^<]*)><img border=\"0\" width=\"32\" height=\"38\" src=\"([^\"]*)\" /></a></td></tr></table></td>(.*?)size=1 style=\"font-size:11px;\">(([0-9]*[.][0-9]*[.][0-9]*)|online)</font></td>(.*?)<a href=\"/member/rate_member.aspx[?]pid=([0-9]*)&pnam"];
				i = 0;
				while (i < [tempArray2 count])
				{
					tempString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@", tempString, @"<tr><td>", [[tempArray2 objectAtIndex:i] objectAtIndex:1], @"</td><td><a href=\"", [self LargerPics:[[tempArray2 objectAtIndex:i] objectAtIndex:2]], @"\"><img src=\"", [[tempArray2 objectAtIndex:i] objectAtIndex:2], @"\" /></a></td><td ", [self ChangeDate:[[tempArray2 objectAtIndex:i] objectAtIndex:4]], @"</td><td>", [[tempArray2 objectAtIndex:i] objectAtIndex:7], @"</td></tr>\r\n"];
					i++;
				}
				//if ([[tempArray objectAtIndex:0] objectAtIndex:2] integerValue]%10 == 0)
				[FriendListWeb loadHTMLString:[NSString stringWithFormat:@"%@%@%@", ReturnString, [tempString stringByReplacingOccurrencesOfString:@"/im/p_nam.gif" withString:@"http://www.faceparty.com/im/p_nam.gif"], @"</table></body></html>\r\n\r\n"] baseURL:[NSURL URLWithString: [NSString stringWithFormat:@"file:/%@//", [[[[NSBundle mainBundle] resourcePath] stringByReplacingOccurrencesOfString:@"/" withString:@"//"] stringByReplacingOccurrencesOfString:@" " withString:@"%20"]]]];
//				NSLog([[NSURL URLWithString: [NSString stringWithFormat:@"file:/%@//", [[[[NSBundle mainBundle] resourcePath] stringByReplacingOccurrencesOfString:@"/" withString:@"//"] stringByReplacingOccurrencesOfString:@" " withString:@"%20"]]] absoluteString]);
				while ([ReturnString retainCount] > 1)
				{
					[ReturnString release];
				}
				[ReturnString release];
			}
		}
		else
		{
			/*NSArray *tempArray = [RecievedData arrayOfCaptureComponentsMatchedByRegex:@"<div style=\"position:relative; border-left: solid 1px #999999;border-right: solid 1px #999999;background-color:#E6E6E6;color:#666666;letter-spacing:-1px;font-size:12px;font-family: Verdana;padding:5px;\">Spaz List [\(]([0-9]*)[\)] <div style=\"position:absolute;top:5px;right:8px;cursor:pointer;\">"];
			 NSArray *tempArray = [RecievedData arrayOfCaptureComponentsMatchedByRegex:@"Spaz List [(]([0-9]*)[)]"];
			 NSArray *tempArray = [RecievedData arrayOfCaptureComponentsMatchedByRegex:@"(?s)>Spaz List [(]([0-9]*)[)] <div(.*?)<BR><a href=/message/send_message[.]aspx[?]member_name=([^>]*)><img src=/im/bw/send_msg.gif(.*?)>Chat Settings</div><div"];
			 */
			//Number of friends online
			NSArray *tempArray = [RecievedData arrayOfCaptureComponentsMatchedByRegex:@"(?s)Spaz List [(]([0-9]*)[)] <div"];
			//Array of friends online
			NSArray *tempArray2 = [RecievedData arrayOfCaptureComponentsMatchedByRegex:@"(?s)<BR><a href=/message/send_message.aspx[?]member_name=([^>]*)><img src=/im/bw/send_msg.gif"];
			NSString *tempString = @"";

			//Show number of friends online
			tempString = [NSString stringWithFormat:@"%@%@%@", @"<h1>Online: ", [[tempArray objectAtIndex:0] objectAtIndex:1], @"</h1><br /><br />"];
			i = 0;
			while (i < [[[tempArray objectAtIndex:0] objectAtIndex:1] integerValue])
			{
				tempString = [NSString stringWithFormat:@"%@%@%@%@", tempString, @"<h2>", [[tempArray2 objectAtIndex:i] objectAtIndex:1], @" (msg / alert / view) <input type=\"checkbox\" name=\"\" value=\"\" /></h2>"];
				i++;
			}
		
			//Show the data in the web view object
			[FriendListWeb loadHTMLString:tempString baseURL:nil];
		}
	}
	else if (LoginMenuView.superview)
	{
		UpdateInfo.text = RecievedData;
	}
	
	//Disable loading overlay
	[self LoadingOverlay:2];
	
	//We are no longer processing a HTTP request, so update the variable
	HTTPProgress = FALSE;
	
	[URLConnection release];
}

-(NSString *)ChangeDate:(NSString *)StrDate
{
	//Change strings from the normal DD.MM.YY format to DD/MM/YYYY formats
	if ([StrDate isEqualToString:@"online"])
	{
		return @"sorttable_customkey=\"20990101\">Now!";
	}
	else
	{
		return [NSString stringWithFormat:@"sorttable_customkey=\"%@%@%@%@\">%@%@%@", @"20", [StrDate substringWithRange:NSMakeRange(6, 2)], [StrDate substringWithRange:NSMakeRange(3, 2)], [StrDate substringWithRange:NSMakeRange(0, 2)], [[StrDate stringByReplacingOccurrencesOfString:@"." withString:@"/"] substringWithRange:NSMakeRange(0, 6)], @"20", [StrDate substringWithRange:NSMakeRange(6, 2)]];
	}
}

-(NSString *)LargerPics:(NSString *)PicUrl
{
	//Changes FP images from being all types of sizes to being large images, or just returns the image URL if it's not a valid profile picture
	NSArray *PicPieces = [PicUrl arrayOfCaptureComponentsMatchedByRegex:@"http://images.faceparty.com/([a-zA-Z]*)([/][a-zA-Z]*)?/([0-9]*)/(.*?)_(.*?).jpg"];
	if ([PicPieces count] > 0)
	{
		//Enlargeable pic, return the new URL!
		return [NSString stringWithFormat:@"http://images.faceparty.com/pb/%@/images/%@_%@.jpg", [[PicPieces objectAtIndex:0] objectAtIndex:3], [[PicPieces objectAtIndex:0] objectAtIndex:4], [[PicPieces objectAtIndex:0] objectAtIndex:5]];
	}
	else
	{
		//Not a valid enlargeable image, return provided URL
		return PicUrl;
	}
}

//debug ONLY
-(IBAction)zoomchanged
{
	if (zoomdebug.value > 1)
	{
		GossipWeb.scalesPageToFit = TRUE;
	}
	else
	{
		GossipWeb.scalesPageToFit = FALSE;
	}

}
-(IBAction)postthread
{
	//Post a new thread
	//[self performSelector:@selector(DoWeb:) withObject:[NSArray arrayWithObjects:@"http://www.faceparty.com/gossip/addtopic.aspx", [NSString stringWithFormat:@"%@%@%@%@", @"action=addTopic&cat=9&topTags=FP%20Light%2C%20v0.8a%20by%20thedjnK.&topTitle=", [self URLencode:threadname.text], @"&topSum=", [self URLencode:threadcontent.text]], nil] afterDelay:0];
	//Post a reply
	//[self performSelector:@selector(DoWeb:) withObject:[NSArray arrayWithObjects:@"http://www.faceparty.com/gossip/thread.aspx?topic=854338&page=1", [NSString stringWithFormat:@"%@%@", @"action=addPost&txtPost=", [self URLencode:threadcontent.text]], nil] afterDelay:0];
	//Change password
	//[self performSelector:@selector(DoWeb:) withObject:[NSArray arrayWithObjects:@"http://www.faceparty.com/account/change_pass.aspx", [NSString stringWithFormat:@"%@%@%@%@%@%@", @"action=save&cur=", [self URLencode:threadname.text], @"&new=", [self URLencode:threadcontent.text], @"&con=", [self URLencode:threadcontent.text]], nil] afterDelay:0];
}

-(NSString*)NormaliseTime:(NSString*)ThreadTime
{
	if (NormaliseTimeActive == TRUE)
	{
		if ([ThreadTime isEqualToString:@"about a minute"])
		{
			//Just get the current time - 15 seconds!
			NSDateFormatter *TimeFormat = [[NSDateFormatter alloc] init];
			[TimeFormat setDateFormat:@"HH:mm"];
			NSTimeInterval TimeAgo = 20;
			NSDate *GetTime = [[NSDate alloc] initWithTimeIntervalSinceNow:-TimeAgo];
			ThreadTime = [NSString stringWithFormat:@"%@", [TimeFormat stringFromDate:GetTime]];

			//Free up excess memory
			[TimeFormat release];
			[GetTime release];
		}
		else
		{
			NSArray *SplitTime = [[NSArray alloc] initWithArray:[ThreadTime arrayOfCaptureComponentsMatchedByRegex:@"([0-9]*) ([a-zA-Z]*)"]];
			if (SplitTime.count > 0)
			{
				NSDateFormatter *TimeFormat = [[NSDateFormatter alloc] init];
				NSTimeInterval TimeAgo;

				if ([[[SplitTime objectAtIndex:0] objectAtIndex:2] isEqualToString:@"mins"])
				{
					TimeAgo = [[[SplitTime objectAtIndex:0] objectAtIndex:1] integerValue] *60;
					[TimeFormat setDateFormat:@"HH:mm"];
				}
				else if ([[[SplitTime objectAtIndex:0] objectAtIndex:2] isEqualToString:@"hours"])
				{
					TimeAgo = [[[SplitTime objectAtIndex:0] objectAtIndex:1] integerValue]*3600;
					[TimeFormat setDateFormat:@"HH:00"];
				}
				else if ([[[SplitTime objectAtIndex:0] objectAtIndex:2] isEqualToString:@"days"])
				{
					TimeAgo = [[[SplitTime objectAtIndex:0] objectAtIndex:1] integerValue]*31536000;
					if ([[[SplitTime objectAtIndex:0] objectAtIndex:1] integerValue] > 365)
					{
						[TimeFormat setDateFormat:@"(dd/MM/YYYY)"];
					}
					else
					{
						[TimeFormat setDateFormat:@"(dd/MM)"];
					}
				}
				NSDate *GetTime = [[NSDate alloc] initWithTimeIntervalSinceNow:-TimeAgo];
				ThreadTime = [NSString stringWithFormat:@"%@", [TimeFormat stringFromDate:GetTime]];

				//Freeing up memory
				[SplitTime release];
				[TimeFormat release];
				[GetTime release];
			}
		}
	}
	return ThreadTime;
}

-(BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType 
{
	/* */
	//Check which webview object it was that triggered the action
	if (webView.tag == 2)
	{
		if(navigationType == UIWebViewNavigationTypeLinkClicked)
		{
			NSURL *urla = request.URL;
			
			//Messaging
			[viewMessagesWeb loadHTMLString:[NSString stringWithFormat:@"%@%@%@%@%@", @"You clicked a link to ", urla.lastPathComponent, @"\?", urla.query, @", foo!"] baseURL:nil];
			
			return FALSE;
		}
		else
		{
			return TRUE;
		}

	}
	else if (webView.tag == 3)
	{
		//Gossip view's webview
		if(navigationType == UIWebViewNavigationTypeLinkClicked || navigationType == UIWebViewNavigationTypeFormSubmitted)
		{
			NSURL *url = request.URL;
			NSArray *tempArray = [[NSString stringWithFormat:@"%@", request.URL] arrayOfCaptureComponentsMatchedByRegex:@"([^:]*):([^:]*)"];
			
			if (tempArray.count < 1)
			{
				//This is a problem...
			}
			else
			{
				if ([[[tempArray objectAtIndex:0] objectAtIndex:1] isEqualToString:@"thread"])
				{
					//Go to specified thread
					tempArray = [[[tempArray objectAtIndex:0] objectAtIndex:2] arrayOfCaptureComponentsMatchedByRegex:@"([^[.]]*)[.]([^[.]]*)"];
					URLRequest = @"thread";
					CurrentThread = [[[tempArray objectAtIndex:0] objectAtIndex:1] integerValue];
					CurrentThreadPage = [[[tempArray objectAtIndex:0] objectAtIndex:2] integerValue];
					[URLRequest retain];
					[self DoWeb:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@%@%@%@", @"http://www.faceparty.com/gossip/thread.aspx?topic=", [[tempArray objectAtIndex:0] objectAtIndex:1], @"&page=", [[tempArray objectAtIndex:0] objectAtIndex:2]], @"", nil]];
				}
				else if ([[[tempArray objectAtIndex:0] objectAtIndex:1] isEqualToString:@"reply"])
				{
					NSLog(@"OH KAI");
					NSLog([[tempArray objectAtIndex:0] objectAtIndex:1]);
					NSLog([[tempArray objectAtIndex:0] objectAtIndex:2]);
				}
			}

//			[self PostReply];
//			[GossipWeb loadHTMLString:[NSString stringWithFormat:@"%@%@", @"<h1>you are teh clickz0r on teh: ", url.lastPathComponent] baseURL:nil];
//			[webView stopLoading];
			
			//Splicing up a fuse and controlling the cat.
		}
			return TRUE;
	}
	else if (webView.tag == 4)
	{
		//Friend list web view
		if(navigationType == UIWebViewNavigationTypeLinkClicked || navigationType == UIWebViewNavigationTypeFormSubmitted)
		{
//TESTING: Load image in popup view
			// get the view that's currently showing
			UIView *currentView = self.view;
			// get the the underlying UIWindow, or the view containing the current view view
			UIView *theWindow = [currentView superview];
			
			// remove the current view and replace with myView1
			//[currentView removeFromSuperview];
			[theWindow addSubview:LoaderParentView];
			
			// set up an animation for the transition between the views	
			CATransition *animation = [CATransition animation];
			animation.duration = 0.50;
			animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
			animation.type = kCATransitionFade;
			animation.delegate = self;
			[theWindow.layer addAnimation:animation forKey:nil];
			//This messes up the initial login view for some queer reason
			//		currentView.hidden = YES;
			LoaderParentView.hidden = NO;
			
			[theWindow addSubview:ImageViewingView];
			ImageViewingView.hidden = FALSE;
			
			//Round the edges of the view
			ImageViewingView.layer.cornerRadius = 10;
			
			//Start the animating loader from animated
			[LoaderAnimation startAnimating];
			
			//Position the frame into the middle
			ImageViewingView.layer.position = CGPointMake(320/2, 0);
			ImageViewingView.transform = CGAffineTransformMakeTranslation(0, 0);
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:1.2];
			ImageViewingView.transform = CGAffineTransformMakeTranslation(0, 180);
			ImageViewingView.alpha = 1.0;
			[UIView commitAnimations];
//moar testing;
			NSURL *url = request.URL;
			NSData *urlData = [NSData dataWithContentsOfURL:url];
			UIImage *image = [UIImage imageWithData:urlData];
			ImageViewingImageView.image = image;
			
			//We don't want it to go the link itself.
			return FALSE;
		}
	}
	else
	{
		//This should never run.
		return TRUE;
	}
}

-(IBAction)LoginBtnClick
{
	/* */
	
	//Withdraw keyboard
	if ([Username isFirstResponder])
	{
		[Username resignFirstResponder];
	}
	else if ([Password isFirstResponder])
	{
		[Password resignFirstResponder];
	}
	
	//Quick check for banned usernames
	if ([[[Username text] lowercaseString] isEqualToString:@"t1m"] || [[[Username text] lowercaseString] isEqualToString:@"m_fox"] || [[[Username text] lowercaseString] isEqualToString:@"foxy1985xx"])
	{
		[self FrameTransition:BannedView];
	}
	else
	{
		//No erros as of yet
		BOOL Error = FALSE;
	
		//Check the length of the usernamd and password fields
		if ([Username text].length < 1)
		{
			//Username too short
			Username.backgroundColor = [UIColor colorWithRed:0.967 green:0.325 blue:0.36 alpha:0.9];
			Username.textColor = [UIColor colorWithRed:0.967 green:0.325 blue:0.36 alpha:0.9];
			Username.font = [UIFont boldSystemFontOfSize:12];
		
			//Mark that an error has occured
			Error = TRUE;
		}
		else if ([Username text].length > 18)
		{
			//Username too long
			Username.backgroundColor = [UIColor colorWithRed:0.967 green:0.325 blue:0.36 alpha:0.9];
			Username.textColor = [UIColor colorWithRed:0.967 green:0.325 blue:0.36 alpha:0.9];
			Username.font = [UIFont boldSystemFontOfSize:12];
		
			//Mark that an error has occured
			Error = TRUE;
		}
		else
		{
			//So far so good for now
			Username.backgroundColor = [UIColor whiteColor];
			Username.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
			Username.font = [UIFont systemFontOfSize:12];
		}
		
		if ([Password text].length < 4)
		{
			//Password too short
			Password.backgroundColor = [UIColor colorWithRed:0.967 green:0.325 blue:0.36 alpha:0.9];
			Password.textColor = [UIColor colorWithRed:0.967 green:0.325 blue:0.36 alpha:0.9];
			Password.font = [UIFont boldSystemFontOfSize:12];
		
			//Mark that an error has occured
			Error = TRUE;
		}
		else if ([Password text].length > 15)
		{
			//Password too long
			Password.backgroundColor = [UIColor colorWithRed:0.967 green:0.325 blue:0.36 alpha:0.9];
			Password.textColor = [UIColor colorWithRed:0.967 green:0.325 blue:0.36 alpha:0.9];
			Password.font = [UIFont boldSystemFontOfSize:12];
		
			//Mark that an error has occured
			Error = TRUE;
		}
		else
		{
			//Looks good for now
			Password.backgroundColor = [UIColor whiteColor];
			Password.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
			Password.font = [UIFont systemFontOfSize:12];
		}

		//Only attempt a login if no error has occured
		if (Error == FALSE)
		{
			//Disable input to both the username and password fields whilst logging in, and the login button
			[Username setUserInteractionEnabled:NO];
			[Password setUserInteractionEnabled:NO];
			LoginBtn.enabled = FALSE;
		
			//Run the function to login
			[self DoWeb:[NSArray arrayWithObjects:@"http://www.faceparty.com/account/log_in.aspx", [NSString stringWithFormat:@"%@%@%@%@", @"li_mn=", Username.text, @"&li_pwd=", Password.text], nil]];
		
			//Run the next part until a reply is recieved
			[NSThread detachNewThreadSelector:@selector(HTTP_Login) toTarget:self withObject:nil];
		}
	}
}

-(void)PostReply
{
	/* */

	NSString *Reply = [[NSString alloc] initWithString:[GossipWeb stringByEvaluatingJavaScriptFromString:@"ThreadReply.value"]];
	[self ShowAlert:[NSArray arrayWithObjects:@"Boo Hoo! ~ ", Reply, nil]];
	
	//Harvesting grain for my daily cerial intake.
	[Reply release];
}

-(void)ShowAlert:(NSArray*) Params
{
	/* */

	//Split the array into parameters
	NSString* AlertTitle = [[NSString alloc] initWithString:[Params objectAtIndex:0]];
	NSString* AlertMessage = [[NSString alloc] initWithString:[Params objectAtIndex:1]];
	
	//Format the alert box for displaying data
	UIAlertView *AlertBox = [[UIAlertView alloc] initWithTitle:AlertTitle message:AlertMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	
	//Show the alert box
	[AlertBox show];
	
	//Free up memory
	[AlertBox release];
	if (AlertTitle)
	{
		[AlertTitle release];
	}
	if (AlertMessage)
	{
		[AlertMessage release];
	}
}

-(void)LoadingOverlay:(NSInteger)Action
{
	/* */
	if (Action == 2)
	{
		// get the view that's currently showing
		UIView *currentView = self.view;
		// get the the underlying UIWindow, or the view containing the current view view
		UIView *theWindow = [currentView superview];

		//Position the frame into the middle
		LoaderView.transform = CGAffineTransformMakeScale(1,1);
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.50];
		LoaderView.transform = CGAffineTransformMakeScale(0.1,0.1);
		LoaderView.alpha = 1.0;
		[UIView commitAnimations];

		// set up an animation for the transition between the views	
		CATransition *animation = [CATransition animation];
		animation.duration = 0.50;
		animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
		animation.type = kCATransitionFade;
		animation.delegate = self;
		[theWindow.layer addAnimation:animation forKey:nil];
		//wait here
		[NSThread sleepForTimeInterval:1.0];
		LoaderParentView.hidden = YES;
		LoginView.hidden = NO;
		if (LoaderParentView.superview)
		{
			[LoaderParentView removeFromSuperview];
		}
		
		//Stop the animating loader
		[LoaderAnimation stopAnimating];
		
		LoaderView.hidden = TRUE;
		if (LoaderView.superview)
		{
			[LoaderView removeFromSuperview];
		}
	}
	else
	{		
		// get the view that's currently showing
		UIView *currentView = self.view;
		// get the the underlying UIWindow, or the view containing the current view view
		UIView *theWindow = [currentView superview];
		
		// remove the current view and replace with myView1
		//[currentView removeFromSuperview];
		[theWindow addSubview:LoaderParentView];
		
		// set up an animation for the transition between the views	
		CATransition *animation = [CATransition animation];
		animation.duration = 0.50;
		animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
		animation.type = kCATransitionFade;
		animation.delegate = self;
		[theWindow.layer addAnimation:animation forKey:nil];
		//This messes up the initial login view for some queer reason
//		currentView.hidden = YES;
		LoaderParentView.hidden = NO;
		LoaderParentView.layer.position = CGPointMake(320/2, 500/2);

		[theWindow addSubview:LoaderView];
		LoaderView.hidden = FALSE;
		
		//Round the edges of the view
		LoaderView.layer.cornerRadius = 10;
		
		//Start the animating loader from animated
		[LoaderAnimation startAnimating];

		//Position the frame into the middle
		LoaderView.layer.position = CGPointMake(320/2, 480/2);
		LoaderView.transform = CGAffineTransformMakeScale(0.2,0.2);
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.50];
		LoaderView.transform = CGAffineTransformMakeScale(1,1);
		LoaderView.alpha = 1.0;
		[UIView commitAnimations];
	}
}

-(IBAction)GotoGossipBtnClicked
{
	[self FrameTransition:GossipView];
	GossipWeb.dataDetectorTypes = UIDataDetectorTypeNone;
	URLRequest = @"";
	[URLRequest retain];
	[self DoWeb:[NSArray arrayWithObjects:@"http://www.faceparty.com/gossip/default.aspx", @"", nil]];
}

-(IBAction)LogoutBtnClicked
{
	/* Log the user out, well, just remove the cookies. No point in sending a HTTP request as the session still remains active on FP, hah! */

	//Remove cookies and create a new blank array
	if (CookieData)
	{
		i = [CookieData count];
		while (i > 0)
		{
			[[CookieData objectAtIndex:(i-1)] release];
			[CookieData removeObjectAtIndex:(i-1)];
			i--;
		}
		[CookieData release];
		CookieData = [[NSMutableArray alloc] init];
	}
	
	//Remove pest-list
	if (PestList)
	{
		[PestList release];
	}
	
	//Make sure the password box is blank
	Password.text = @"";
	
	//Clear other variables and objects
	[GossipWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
	[viewMessagesWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
	
	//Enable user-interaction for the login view items
	[Username setUserInteractionEnabled:TRUE];
	[Password setUserInteractionEnabled:TRUE];
	
	//Enable the login button
	LoginBtn.enabled = TRUE;
	
	//Make the textfield backgrounds clear
	Username.backgroundColor = [UIColor whiteColor];
	Username.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
	Username.font = [UIFont systemFontOfSize:12];
	
	//Make the password backgrounds clear
	Password.backgroundColor = [UIColor whiteColor];
	Password.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
	Password.font = [UIFont systemFontOfSize:12];
	
	//Reset where the Picture Selector was, just in case there are sensitive items there...
	PicTester.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
	PicTester.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	
	//Return back to login frame.
	[self FrameTransition:LoginView];
}

-(IBAction)NewMessageBackBtnClicked
{
	//Only run if there is no discard warning already displayed
	if (![LoaderParentView superview] && ![LoaderView superview] && ![UnsavedMessageView superview])
	{
		/* Show the popup warning the user about unsaved messages if there is any text entered */
		if (NewMessageContent.text.length > 1)
		{
			//There is text, so warn the user
//disable the other input boxes here
			[NewMessageContent resignFirstResponder];
			[NewMessageContent setUserInteractionEnabled:FALSE];
		
			// get the view that's currently showing
			UIView *currentView = self.view;
			// get the the underlying UIWindow, or the view containing the current view view
			UIView *theWindow = [currentView superview];
		
			// remove the current view and replace with myView1
			//[currentView removeFromSuperview];
			[theWindow addSubview:LoaderParentView];
		
			// set up an animation for the transition between the views	
			CATransition *animation = [CATransition animation];
			animation.duration = 0.50;
			animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
			animation.type = kCATransitionFade;
			animation.delegate = self;
			[theWindow.layer addAnimation:animation forKey:nil];
			//This messes up the initial login view for some queer reason
			//		currentView.hidden = YES;
			LoaderParentView.hidden = NO;
		
			[theWindow addSubview:UnsavedMessageView];
			UnsavedMessageView.hidden = FALSE;
		
			//Round the edges of the view
			UnsavedMessageView.layer.cornerRadius = 10;
		
			//Start the animating loader from animated
			[LoaderAnimation startAnimating];
		
			//Position the frame into the middle
			UnsavedMessageView.layer.position = CGPointMake(320/2, -60);
			UnsavedMessageView.transform = CGAffineTransformMakeTranslation(0, 0);
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:1.2];
			UnsavedMessageView.transform = CGAffineTransformMakeTranslation(0, 180);
			UnsavedMessageView.alpha = 1.0;
			[UIView commitAnimations];
		}
		else
		{
			//No text, so just go back
			[self RadicalBack];
		}
	}
}

-(IBAction)NewMessageBtnClicked
{
	/* Go to the new message view */
	[self FrameTransition:NewMessageView];
	
	NewMessageContent.backgroundColor = [UIColor clearColor];
	NewMessageContent.contentSize = CGSizeMake(320, 720);
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector (keyboardDidShow:)
												 name: UIKeyboardDidShowNotification object:nil];	
}

-(IBAction)MessageWarningCancelClicked
{
	// get the view that's currently showing
	UIView *currentView = self.view;
	// get the the underlying UIWindow, or the view containing the current view view
	UIView *theWindow = [currentView superview];
	
	//Position the frame into the middle
	UnsavedMessageView.transform = CGAffineTransformMakeTranslation(0, 0);
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.50];
	UnsavedMessageView.transform = CGAffineTransformMakeTranslation(0, -180);
	UnsavedMessageView.alpha = 1.0;
	[UIView commitAnimations];
	
	// set up an animation for the transition between the views	
	CATransition *animation = [CATransition animation];
	animation.duration = 0.50;
	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	animation.type = kCATransitionFade;
	animation.delegate = self;
	[theWindow.layer addAnimation:animation forKey:nil];
	LoaderParentView.hidden = YES;
	NewMessageView.hidden = NO;
	if (LoaderParentView.superview)
	{
		[LoaderParentView removeFromSuperview];
	}
	
	UnsavedMessageView.hidden = TRUE;
	if (UnsavedMessageView.superview)
	{
		[UnsavedMessageView removeFromSuperview];
	}
}

-(IBAction)MessageWarningDiscardClicked
{
	// get the view that's currently showing
	UIView *currentView = self.view;
	// get the the underlying UIWindow, or the view containing the current view view
	UIView *theWindow = [currentView superview];
	
	//Position the frame into the middle
	UnsavedMessageView.transform = CGAffineTransformMakeTranslation(0, 0);
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.50];
	UnsavedMessageView.transform = CGAffineTransformMakeTranslation(0, -180);
	UnsavedMessageView.alpha = 1.0;
	[UIView commitAnimations];
	
	// set up an animation for the transition between the views	
	CATransition *animation = [CATransition animation];
	animation.duration = 0.50;
	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	animation.type = kCATransitionFade;
	animation.delegate = self;
	[theWindow.layer addAnimation:animation forKey:nil];
	LoaderParentView.hidden = YES;
	NewMessageView.hidden = NO;
	if (LoaderParentView.superview)
	{
		[LoaderParentView removeFromSuperview];
	}
	
	UnsavedMessageView.hidden = TRUE;
	if (UnsavedMessageView.superview)
	{
		[UnsavedMessageView removeFromSuperview];
	}
	
	//And go back to the previous view
	[self performSelector:@selector(RadicalBack) withObject:nil afterDelay:0.5];
}

-(void)OpenDatabase
{
	sqlite3_open([[NSString stringWithFormat:@"%@/test.sqlite", [[NSBundle mainBundle] resourcePath]] UTF8String], &database);
	NSLog(@"OK");
}

-(void)CloseDatabase
{
	sqlite3_close(database);
}

-(void)LoadSettings
{
	//Load all settings from the configuration
	if (sqlite3_prepare_v2(database, [[NSString stringWithFormat:@"SELECT * FROM `storage`"] UTF8String], -1, &runstatement, NULL) == SQLITE_OK)
	{
		//Step through all returned rows of data
		while (sqlite3_step(runstatement) == SQLITE_ROW)
		{
/*
 add the rest of the storage contents to this
 */
			if ([[NSString stringWithUTF8String:(char *)sqlite3_column_text(runstatement, 0)] isEqualToString:@"Username"])
			{
				Username.text = [NSString stringWithUTF8String:(char *)sqlite3_column_text(runstatement, 1)];
			}
			else if ([[NSString stringWithUTF8String:(char *)sqlite3_column_text(runstatement, 0)] isEqualToString:@"Password"])
			{
				Password.text = [NSString stringWithUTF8String:(char *)sqlite3_column_text(runstatement, 1)];
			}

//			if (sqlite3_column_text(runstatement, 1) != NULL)
//			{
//				NSLog([NSString stringWithUTF8String:(char *)sqlite3_column_text(runstatement, 1)]);
//			}
		}
	}
	
	//Free up the result
	sqlite3_reset(runstatement);
	sqlite3_finalize(runstatement);
}

-(void)iclickit
{
	/*
	//Run the statement
	sqlite3_prepare_v2(database, [[NSString stringWithFormat:@"SELECT * FROM login"] UTF8String], -1, &runstatement, NULL);
//	NSLog([NSString stringWithFormat:@"ROWS: %d", sqlite3_column_count(init_statement)]);
	if (sqlite3_step(runstatement) == SQLITE_ROW)
	{
		NSLog([NSString stringWithUTF8String:(char *)sqlite3_column_text(runstatement, 0)]);
		NSLog([NSString stringWithUTF8String:(char *)sqlite3_column_text(runstatement, 1)]);
		
		Username.text = [NSString stringWithUTF8String:(char *)sqlite3_column_text(runstatement, 0)];
		Password.text = [NSString stringWithUTF8String:(char *)sqlite3_column_text(runstatement, 1)];
	}
	else
	{
	}*/
	
	/*
	NSLog(@"P1:");
	NSLog([NSString stringWithFormat:@"%d", sqlite3_prepare_v2(database, [[NSString stringWithFormat:@"SELECT * FROM `storage`"] UTF8String], -1, &runstatement, NULL)]);
	NSLog(@"P2:");
	while(sqlite3_step(runstatement) == SQLITE_ROW)
	{
		NSLog([NSString stringWithUTF8String:(char *)sqlite3_column_text(runstatement, 0)]);
		if (sqlite3_column_text(runstatement, 1) != NULL)
		{
			NSLog([NSString stringWithUTF8String:(char *)sqlite3_column_text(runstatement, 1)]);
		}
	}*/
	
	
	//	NSLog([NSString stringWithFormat:@"ROWS: %d", sqlite3_column_count(runstatement)]);
//	NSLog([NSString stringWithFormat:@"%d-%d-%d-%d:%d", SQLITE_OK, SQLITE_EMPTY, SQLITE_ERROR, SQLITE_MISUSE, sqlite3_step(runstatement)]);
/*	if (sqlite3_step(runstatement) == SQLITE_ROW)
	{
		NSLog([NSString stringWithUTF8String:(char *)sqlite3_column_text(runstatement, 0)]);
		NSLog([NSString stringWithUTF8String:(char *)sqlite3_column_text(runstatement, 1)]);
	}*/
	
//	sqlite3_reset(runstatement);
//	sqlite3_finalize(runstatement);
	
	// get the view that's currently showing
	UIView *currentView = self.view;
	// get the the underlying UIWindow, or the view containing the current view view
	UIView *theWindow = [currentView superview];
	
/////
	[theWindow addSubview:LoaderParentView];
	LoaderParentView.hidden = NO;
	LoaderParentView.layer.position = CGPointMake(320/2, 500/2);
	
	CATransition *animation = [CATransition animation];
	animation.duration = 0.50;
	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	animation.type = kCATransitionFade;
	animation.delegate = self;
	[theWindow.layer addAnimation:animation forKey:nil];
/////
	
	//Decide what method to use to get the picture
//also check database/var here to see if it's set to ignore camera maybe?
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == YES)
	{
		//Show alternative selection menu here
//or check if the setting is to skip camera mode or not...
		[theWindow addSubview:ImageTypeSelectionView];

		//Positioning bug-fix!
		ImageTypeSelectionView.layer.position = CGPointMake(320/2, 460/2+6);
		
		//Position the frame into the middle
		ImageTypeSelectionView.transform = CGAffineTransformMakeTranslation(0, 360);
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.50];
		ImageTypeSelectionView.transform = CGAffineTransformMakeTranslation(0, 180);
		ImageTypeSelectionView.alpha = 1.0;
		[UIView commitAnimations];
	}
	else
	{
		//Just go to the pic chooser
		[theWindow addSubview:PicTester.view];
		
		PicTester.delegate = self;
		//Positioning bug-fix!
		PicTester.view.layer.position = CGPointMake(320/2, 460/2+10);
		
		CATransition *animation = [CATransition animation];
		animation.duration = 0.75;
		animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
		animation.type = kCATransitionPush;
		animation.subtype = kCATransitionFromRight;
		animation.delegate = self;
		[theWindow.layer addAnimation:animation forKey:nil];
	}
}

-(IBAction)GallerySelectionButtonClicked
{
	// get the view that's currently showing
	UIView *currentView = self.view;
	// get the the underlying UIWindow, or the view containing the current view view
	UIView *theWindow = [currentView superview];
/////
	[theWindow addSubview:LoaderParentView];
	LoaderParentView.hidden = NO;
	LoaderParentView.layer.position = CGPointMake(320/2, 500/2);
	
	CATransition *animation = [CATransition animation];
	animation.duration = 0.50;
	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	animation.type = kCATransitionFade;
	animation.delegate = self;
	[theWindow.layer addAnimation:animation forKey:nil];
/////
	[theWindow addSubview:GallerySelectionControllerView];
	
	GallerySelectionControllerView.layer.position = CGPointMake(320/2, 426);
	GallerySelectionController.frame = CGRectMake(0, 0, 320, 162);
	
	GallerySelectionControllerView.transform = CGAffineTransformMakeTranslation(0, 180);
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.50];
	GallerySelectionControllerView.transform = CGAffineTransformMakeTranslation(0, 0);
	GallerySelectionControllerView.alpha = 1.0;
	[UIView commitAnimations];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
	if (image.size.height < 120.0 || image.size.width < 120.0)
	{
		[self performSelector:@selector(ShowAlert:) withObject:[NSArray arrayWithObjects:@"Error Uploading", @"The selected picture does not meet the minimum 120x120 pixel requirement size for Faceparty.\r\nPlease choose another picture that has sufficient size.", nil] afterDelay:0.0];
	}
	else
	{
//		[self performSelectorOnMainThread:@selector(DoImageWeb:) withObject:[NSArray arrayWithObjects:@"", @"", nil] waitUntilDone:NO];
//WORX:		[self performSelectorOnMainThread:@selector(DoImageWeb:) withObject:UIImageJPEGRepresentation(image, 80) waitUntilDone:NO];
//		[picker dismissModalViewControllerAnimated:YES];
//		[picker.view removeFromSuperview];
		[ImageUploadPreview setImage:image forState:UIControlStateNormal];
		UploadImage = [UIImage alloc];
		UploadImage = UIImageJPEGRepresentation(image, 80);
		[UploadImage retain];
		[self FrameTransition:ImageUploadView];
		
		//Remove the view fully in a second after the view animation has finished to stop it just vanishing oddly.
		[self performSelector:@selector(RemoveFromSuperViewDelayed:) withObject:PicTester.view afterDelay:1.0];
		
//		[picker release];
	}
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	//Cancel clicked, so just return to previous view
	[self FrameTransition:ImageUploadView];
	
	//Remove the view fully in a second after the view animation has finished to stop it just vanishing oddly.
	[self performSelector:@selector(RemoveFromSuperViewDelayed:) withObject:PicTester.view afterDelay:1.0];
}

-(IBAction)GoToImageUpload
{
	//Go to the image upload view, simple function, honest.
	[self FrameTransition:ImageUploadView];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{	
	return 1;
}

-(NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
	//Eh ?
	return [GalleryNames count];
}

-(NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	return [[GalleryNames objectAtIndex:row] objectAtIndex:1];
}

-(void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	//When the selection of the picker object is changed
	if (row == 0)
	{
		//The first result is always a new gallery
		[ImageGallery setUserInteractionEnabled:YES];
	}
	else
	{
		//Else it's an existing gallery
		ImageGallery.text = @"";
		[ImageGallery setUserInteractionEnabled:NO];
	}
	NSLog(@"Index of selected item: %i (%@)", row, [[GalleryNames objectAtIndex:row] objectAtIndex:0]);
}

-(IBAction)GallerySelectionOKButtonClicked
{
	//Hide the gallery selection view! With animation, that is
	UIView *currentView = self.view;
	// get the the underlying UIWindow, or the view containing the current view view
	UIView *theWindow = [currentView superview];
	
	//Make the 'loader' background fade out if it's shown
	if (LoaderParentView.superview)
	{
		LoaderParentView.alpha = LoaderParentView.alpha;
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.50];
		LoaderParentView.alpha = 0.0;
		[UIView commitAnimations];
	}
	
	//Parts for the movement animation
	GallerySelectionControllerView.transform = CGAffineTransformMakeTranslation(0, 0);
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.50];
	GallerySelectionControllerView.transform = CGAffineTransformMakeTranslation(0, 180);
	GallerySelectionControllerView.alpha = 1.0;
	[UIView commitAnimations];
	
	//Remove the view fully in a second after the view animation has finished to stop it just vanishing oddly.
	[self performSelector:@selector(RemoveFromSuperViewDelayed:) withObject:GallerySelectionControllerView afterDelay:1.0];
	[self performSelector:@selector(RemoveFromSuperViewDelayed:) withObject:LoaderParentView afterDelay:1.2];
}

-(void)RemoveFromSuperViewDelayed:(UIView *)TheView
{
	//This just removes a view from the superview, and is designed to run after a specified time (required for the animation to complete)
	[TheView removeFromSuperview];
	
	//Also replace the alpha value if this is the loaderparent view
	if (TheView == LoaderParentView)
	{
		LoaderParentView.alpha = 0.49;
	}
}

-(void)DeleteView:(UIView *)TheView
{
	//Deletes the specified view!
	[TheView release];
}

-(IBAction)ImageSourceCameraButtonClicked
{
	//Go to the camera-feed input
	UIView *currentView = self.view;
	// get the the underlying UIWindow, or the view containing the current view view
	UIView *theWindow = [currentView superview];
	
	//Remove the overlay
	if (LoaderParentView.superview)
	{
		[LoaderParentView removeFromSuperview];
	}
	
	//Remove the view fully in a second after the view animation has finished to stop it just vanishing oddly.
	[self performSelector:@selector(RemoveFromSuperViewDelayed:) withObject:ImageTypeSelectionView afterDelay:1.0];
	
	//Just go to the pic chooser
	[theWindow addSubview:PicTester.view];
	
	//Change the source type
	PicTester.sourceType = UIImagePickerControllerSourceTypeCamera;
	
	PicTester.delegate = self;
	//Positioning bug-fix!
	PicTester.view.layer.position = CGPointMake(320/2, 460/2+10);
	
	CATransition *animation = [CATransition animation];
	animation.duration = 0.75;
	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	animation.type = kCATransitionPush;
	animation.subtype = kCATransitionFromRight;
	animation.delegate = self;
	[theWindow.layer addAnimation:animation forKey:nil];
}

-(IBAction)ImageSourceImageButtonClicked
{
	//Go to the image selection input
	UIView *currentView = self.view;
	// get the the underlying UIWindow, or the view containing the current view view
	UIView *theWindow = [currentView superview];
	
	//Remove the overlay
	if (LoaderParentView.superview)
	{
		[LoaderParentView removeFromSuperview];
	}
	
	//Remove the view fully in a second after the view animation has finished to stop it just vanishing oddly.
	[self performSelector:@selector(RemoveFromSuperViewDelayed:) withObject:ImageTypeSelectionView afterDelay:1.0];
	
	//Just go to the pic chooser
	[theWindow addSubview:PicTester.view];
	
	//Change the source type
	PicTester.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	
	PicTester.delegate = self;
	//Positioning bug-fix!
	PicTester.view.layer.position = CGPointMake(320/2, 460/2+10);
	
	CATransition *animation = [CATransition animation];
	animation.duration = 0.75;
	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	animation.type = kCATransitionPush;
	animation.subtype = kCATransitionFromRight;
	animation.delegate = self;
	[theWindow.layer addAnimation:animation forKey:nil];
}

-(IBAction)UploadImageBtnClicked
{
	[self performSelectorOnMainThread:@selector(DoImageWeb) withObject:nil	waitUntilDone:NO];
	
	//Go to the image selection input
	UIView *currentView = self.view;
	// get the the underlying UIWindow, or the view containing the current view view
	UIView *theWindow = [currentView superview];
	
	for (int i = 0; i < [[theWindow subviews] count]; i++ )
	{
		NSLog(@"VIEW: %i :", i);
		NSLog(@" -> %i", [[[theWindow subviews] objectAtIndex:i] tag]);
	}
}

-(IBAction)RadicalBack
{
	//Only run if there is no loading screen going on (which would mess up the ordering system anyway)
	if (![LoaderParentView superview] && ![LoaderView superview] && ![UnsavedMessageView superview])
	{
		//Go to the image selection input
		UIView *currentView = self.view;
		// get the the underlying UIWindow, or the view containing the current view view
		UIView *theWindow = [currentView superview];
	
		//Remove the view fully in a second after the view animation has finished to stop it just vanishing oddly.
		[self performSelector:@selector(RemoveFromSuperViewDelayed:) withObject:[[theWindow subviews] objectAtIndex:([[theWindow subviews] count]-1)] afterDelay:0.85];
		[self FrameTransition:[[theWindow subviews] objectAtIndex:([[theWindow subviews] count]-2)]];
	}
}

-(IBAction)GetGalleries
{
	
}

-(IBAction)ViewThreadsBtnClicked
{
	//Go back to listing gossip threads
	if ([URLRequest isEqualToString:@""] == FALSE)
	{
		URLRequest = @"";
		[URLRequest retain];
		[self DoWeb:[NSArray arrayWithObjects:@"http://www.faceparty.com/gossip/default.aspx", @"", nil]];
	}
}

-(IBAction)RefreshThreadBtnClicked
{
	//What view are we in?
	if (GossipView.superview)
	{
		//Refresh the current page in the gossip view
		if ([URLRequest isEqualToString:@""])
		{
			[self DoWeb:[NSArray arrayWithObjects:@"http://www.faceparty.com/gossip/default.aspx", @"", nil]];
		}
		else if ([URLRequest isEqualToString:@"thread"])
		{
			[self DoWeb:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@%D%@%D", @"http://www.faceparty.com/gossip/thread.aspx?topic=", CurrentThread, @"&page=", CurrentThreadPage], @"", nil]];
		}
		else
		{
			NSLog(@"THIS SHOULD NOT OCCUR, EVER, OK?");
		}
	}
	else if (FriendListView.superview)
	{
		//Update the online spaz list.
		[self DoWeb:[NSArray arrayWithObjects:@"http://www.faceparty.com/grimrita/", @"", nil]];
	}
	else
	{
		NSLog(@"ERROR: REFRESH BTN CLICKED ON NO VIEW");
	}
}

-(IBAction)ActionBtnClicked
{
	//When the middle action button on a view is pressed
	if (GossipView.superview)
	{
		NSLog(@"show_menu_now[gossip]");
	}
	else if (FriendListView.superview)
	{
//TESTING:
		UIView *currentView = self.view;
		// get the the underlying UIWindow, or the view containing the current view view
		UIView *theWindow = [currentView superview];
		
		/////
		[theWindow addSubview:LoaderParentView];
		LoaderParentView.hidden = NO;
		LoaderParentView.layer.position = CGPointMake(320/2, 500/2);
		
		CATransition *animation = [CATransition animation];
		animation.duration = 0.50;
		animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
		animation.type = kCATransitionFade;
		animation.delegate = self;
		[theWindow.layer addAnimation:animation forKey:nil];
		
		[theWindow addSubview:FriendActionView];
		
		//Positioning bug-fix!
		FriendActionView.layer.position = CGPointMake(320/2, 460/2+6);
		
		//Position the frame into the middle
		FriendActionView.transform = CGAffineTransformMakeTranslation(0, 400);
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.50];
		FriendActionView.transform = CGAffineTransformMakeTranslation(0, 112);
		FriendActionView.alpha = 1.0;
		[UIView commitAnimations];
	}
	else
	{
		NSLog(@"show_menu_now[ERROR?]");
	}
}

-(IBAction)FriendsBtnClicked
{
	//When the 'Friends' button is clicked on the login menu
	[self FrameTransition:FriendListView];
//	FriendListWeb.dataDetectorTypes = UIDataDetectorTypeNone;
	URLRequest = @"all_p1";
	[URLRequest retain];
//	[self DoWeb:[NSArray arrayWithObjects:@"http://www.faceparty.com/grimrita/", @"", nil]];
	[self DoWeb:[NSArray arrayWithObjects:@"http://www.faceparty.com/account/buddy_list.aspx?page=1", @"", nil]];
}

-(IBAction)CloseImageViewingView
{
	//
	// get the view that's currently showing
	UIView *currentView = self.view;
	// get the the underlying UIWindow, or the view containing the current view view
	UIView *theWindow = [currentView superview];
	
	//Position the frame into the middle
	ImageViewingView.transform = CGAffineTransformMakeTranslation(0, 0);
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.50];
	ImageViewingView.transform = CGAffineTransformMakeTranslation(0, -180);
	ImageViewingView.alpha = 1.0;
	[UIView commitAnimations];
	
	// set up an animation for the transition between the views	
	CATransition *animation = [CATransition animation];
	animation.duration = 0.50;
	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	animation.type = kCATransitionFade;
	animation.delegate = self;
	[theWindow.layer addAnimation:animation forKey:nil];
	LoaderParentView.hidden = YES;
//	NewMessageView.hidden = NO;
	if (LoaderParentView.superview)
	{
		[LoaderParentView removeFromSuperview];
	}
	
	ImageViewingView.hidden = TRUE;
	if (ImageViewingView.superview)
	{
		[ImageViewingView removeFromSuperview];
	}
}

-(IBAction)LoadOnlineFriendsBtnClicked
{
	//Button click that loads only a brief list of online users
	URLRequest = @"";
	[URLRequest retain];
	[self DoWeb:[NSArray arrayWithObjects:@"http://www.faceparty.com/grimrita/", @"", nil]];
	[self HideActionView];
}

-(IBAction)LoadAllFriendsBtnClicked
{
	//Load all the friends which is slow and data-intensive
	URLRequest = @"all_p1";
	[URLRequest retain];
	[self DoWeb:[NSArray arrayWithObjects:@"http://www.faceparty.com/account/buddy_list.aspx?page=1", @"", nil]];
	[self HideActionView];
}

-(IBAction)LoadPestListBtnClicked
{
	//Load a list of the pest list
//TODO: Load from memory if block list blocking mode is active?
}

-(IBAction)AddFriendBtnClicked
{
	//Add a new friend to the buddy list
}

-(IBAction)AddPestBtnClicked
{
	//Add a new pest to the pest list and block those bad gossip posts! (or something ;p)
}

-(void)HideActionView
{
	//Hide's the action view that is visibile, if it is visisble. Saves lots of repetitive code in above functions.
	UIView *currentView = self.view;
	// get the the underlying UIWindow, or the view containing the current view view
	UIView *theWindow = [currentView superview];
	
	//Remove the overlay
	if (LoaderParentView.superview)
	{
		[LoaderParentView removeFromSuperview];
	}

	//Position the frame into the middle
	FriendActionView.transform = CGAffineTransformMakeTranslation(0, 122);
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1.00];
	FriendActionView.transform = CGAffineTransformMakeTranslation(0, 400);
	FriendActionView.alpha = 0.25;
	[UIView commitAnimations];
	
	//Remove the view after a delay
	[self performSelector:@selector(RemoveFromSuperViewDelayed:) withObject:FriendActionView afterDelay:1.5];
}

@end
