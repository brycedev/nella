#import <Preferences/Preferences.h>
#import "Preferences/PSListController.h"
#import "Preferences/PSTableCell.h"
#import <Twitter/TWTweetComposeViewController.h>
#import <MessageUI/MFMailComposeViewController.h>


@interface PSTableCell (Nella)
@property (nonatomic, retain) UIView *backgroundView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end

@interface NellaHeaderCell : PSTableCell  {
	UILabel *tweakName;
}
@end

@interface PSListController (Nella)
    - (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion;
    - (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion;
    - (UINavigationController*)navigationController;
    - (void)viewWillAppear:(BOOL)animated;
@end

@interface NellaListController: PSListController <MFMailComposeViewControllerDelegate>
    
@end
    
@interface NellaBackgroundController : PSListController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
    //- (void)chooseBackgroundImage;
@end
    
@interface NellaButtonController : PSListController

@end
    
@interface NellaMiscController : PSListController

@end
