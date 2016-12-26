//
//  TestyViewController.h
//  Faceparty Light
//
//  Created by thedjnK on 17/08/2010.
//  Copyright © 2010, todo. All rights reserved.

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface FPLightViewController : UIViewController
{
	//Startup loader image
	IBOutlet UIView *startupImage;
	
	//Main menu view
	IBOutlet UIView *menuView;
	
	IBOutlet UITextView *results;
	IBOutlet UITextField *ques;
	
	IBOutlet UINavigationBar *Title;
	IBOutlet UITextField *Username;
	IBOutlet UITextField *Password;
	IBOutlet UIImageView *FPLightLogo;
	IBOutlet UIButton *LoginBtn;
	
	//Credits view
	IBOutlet UIView *CreditView;
	IBOutlet UIButton *CreditsBtn;
	IBOutlet UIBarButtonItem *CreditsCloseBtn;
	IBOutlet UINavigationBar *CreditsBar;
	
	//test?
	IBOutlet UIView *LoaderParentView;
	IBOutlet UIView *LoaderView;
	IBOutlet UIActivityIndicatorView *LoaderAnimation;
	
	//Gossip view
	IBOutlet UIView *GossipView;
	IBOutlet UIWebView *GossipWeb;
	IBOutlet UIBarButtonItem *newThread;
	//debug
	IBOutlet UISlider *zoomdebug;
	IBOutlet UITextField *threadname;
	IBOutlet UITextField *threadcontent;
	
	//Login view
	IBOutlet UIView *LoginView;
	
	//Logged-in menu view
	IBOutlet UIView *LoginMenuView;
	IBOutlet UIButton *MessagesBtn;
	IBOutlet UIButton *LogoutBtn_MainMenu;
	IBOutlet UINavigationBar *ohffs5;
	IBOutlet UIButton *ohffs6;
	IBOutlet UILabel *UpdateInfo;
//	IBOutlet UIButton *GotoGossipBtn;

	//The 'Hi, <username>.' labels
	IBOutlet UILabel *welcomeLbl_Menu;
	IBOutlet UILabel *settings_MainLbl_Menu;
	IBOutlet UILabel *settings_FPLbl_Menu;
	IBOutlet UILabel *settings_FPLightLbl_Menu;
	IBOutlet UILabel *settings_PasswordLbl_Menu;
	
	//Settings views
	IBOutlet UIView *Settings_Main;
	IBOutlet UIView *Settings_FPLight;
	IBOutlet UIView *Settings_FP;
	IBOutlet UIView *Settings_Password;
	
	//Messaging views
	IBOutlet UIView *NewMessageView;
	IBOutlet UIView *NewAlertView;
	IBOutlet UIView *ViewAlertsView;
	IBOutlet UIView *ViewMessagesView;
	IBOutlet UIView *MessagesView;
	IBOutlet UITextField *NewMessageContentBorder;
	IBOutlet UITextView *NewMessageContent;
	IBOutlet UIScrollView *NewMessageContentScroller;
	
	//Unsaved message warning view
	IBOutlet UIView *UnsavedMessageView;
	
	//Viewing messages view
	IBOutlet UIWebView *viewMessagesWeb;
	IBOutlet UINavigationItem *viewMessagesTitle;
	
	//Banned user view
	IBOutlet UIView *BannedView;
	IBOutlet UIWebView *BannedViewWeb;
	
	//SQLite 3 stuff
	sqlite3 *database;
	
	//pic picker stuff
	IBOutlet UIImagePickerController *PicTester;
	
	//Image upload view
	IBOutlet UIView *ImageUploadView;
	IBOutlet UIButton *ImageUploadPreview;
	IBOutlet UITextField *ImageTitle;
	IBOutlet UITextField *ImageDescription;
	IBOutlet UITextField *ImageGallery;
	IBOutlet UISegmentedControl *ImageGallerySelection;
	IBOutlet UIPickerView *GallerySelectionController;
	IBOutlet UIView *GallerySelectionControllerView;
	IBOutlet UIView *ImageTypeSelectionView;
	IBOutlet UISegmentedControl *AdultPublicSelector;
	
	//Friend list view
	IBOutlet UIView *FriendListView;
	IBOutlet UIWebView *FriendListWeb;
	
	//Image viewing pop-out view
	IBOutlet UIView *ImageViewingView;
	IBOutlet UIImageView *ImageViewingImageView;
	
	//Action pop-out views
	IBOutlet UIView *FriendActionView;
}






//Loading activity overlay
- (void)LoadingOverlay:(NSInteger)Action;

//Login button clicked on login view
- (IBAction)LoginBtnClick;
//Go to next input box with keyboard
- (IBAction)nextKeyboard;
//Keyboard has been closed
- (IBAction)closeKeyboard;


//? to all of these
- (void)showSplash;
- (void)showSplash2;
- (IBAction)CreditsBtnClick;
- (IBAction)CreditsBtnClick2;
- (IBAction)hideSplash;
- (IBAction)CreditsCloseBtnClick;
- (void)FrameTransition: (UIView*)NewView;
- (void)FrameTransition2: (NSArray*) Params;
- (void)FrameLoaded:(NSString*)FrameTag;
- (void)HTTP_Login;
- (void)nilFunction;
- (void)GetCookies;
- (NSString*)SendCookies;
- (void)PerformJavascript:(NSString*) Javascript;
- (void)DoWeb:(NSArray*) Params;
- (NSArray *)Arrayencode: (NSString *)String1 String2:(NSString *)String2;
- (NSString *)URLencode: (NSString *)EncString;
- (void)connection:(NSURLConnection *)theConnection didReceiveResponse:(NSURLResponse *)response;
- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)data;
- (void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error;
- (void)connectionDidFinishLoading:(NSURLConnection *)theConnection;
- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType;
- (void)PostReply;
- (void)ShowAlert:(NSArray*) Params;
- (void)GetMessages;
- (void)SetMessages;
- (IBAction)MessagesBtnClicked;
- (IBAction)ViewMessagesBtnClicked;
- (IBAction)ViewAlertsBtnClicked;
- (void)enableLoginBtn;
- (IBAction)ViewMessagesBackBtnClicked;
- (IBAction)GotoGossipBtnClicked;
- (IBAction)LogoutBtnClicked;
- (IBAction)NewMessageBackBtnClicked;
- (IBAction)NewMessageBtnClicked;
- (IBAction)MessageWarningCancelClicked;
- (IBAction)MessageWarningDiscardClicked;
- (NSString*)NormaliseTime:(NSString*)ThreadTime;
- (IBAction)ViewThreadsBtnClicked;
- (IBAction)RefreshThreadBtnClicked;
- (IBAction)ActionBtnClicked;

/*- (IBAction)BackBtnClicked;
- (IBAction)BackBtnClicked;*/

//debug for gossip web zoom
- (IBAction)zoomchanged;
- (IBAction)postthread;

- (IBAction)Next;

//sqlite 3 stuff
- (IBAction)iclickit;
- (void)OpenDatabase;
- (void)CloseDatabase;

//pic picker
- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
				  editingInfo:(NSDictionary *)editingInfo;
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
- (IBAction)GoToImageUpload;
- (IBAction)GallerySelectionButtonClicked;
- (IBAction)GallerySelectionOKButtonClicked;
- (IBAction)ImageSourceCameraButtonClicked;
- (IBAction)ImageSourceImageButtonClicked;
- (IBAction)UploadImageBtnClicked;

//test
- (IBAction)RadicalBack;
- (IBAction)FriendsBtnClicked;

//For closing the image viewer pop-out view
- (IBAction)CloseImageViewingView;

//For loading the friends list options
- (IBAction)LoadOnlineFriendsBtnClicked;
- (IBAction)LoadAllFriendsBtnClicked;
- (IBAction)LoadPestListBtnClicked;
- (IBAction)AddFriendBtnClicked;
- (IBAction)AddPestBtnClicked;

@end
