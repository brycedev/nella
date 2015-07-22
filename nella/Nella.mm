#include "Headers.h"

@implementation NellaListController 

    - (id)specifiers {
        
        if (_specifiers == nil) {
            
            _specifiers = [[self loadSpecifiersFromPlistName:@"Nella" target:self] retain];

        }

        return _specifiers;
        
    }

    - (void)openSupportMail {
        
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        [mailer setSubject:@"Tweak Support - Nella"];
        [mailer setToRecipients:[NSArray arrayWithObjects:@"bryce@brycedev.com", nil]];
        [self.navigationController presentViewController:mailer animated:YES completion:nil];
        mailer.mailComposeDelegate = self;
        [mailer release];
        
    }

    - (void)openSupportTwitter {
        
        NSString *user = @"thebryc3isright";

        if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetbot:"]])
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tweetbot:///user_profile/" stringByAppendingString:user]]];

        else if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitterrific:"]])
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"twitterrific:///profile?screen_name=" stringByAppendingString:user]]];

        else if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetings:"]])
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tweetings:///user?screen_name=" stringByAppendingString:user]]];

        else if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter:"]])
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"twitter://user?screen_name=" stringByAppendingString:user]]];

        else
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"https://mobile.twitter.com/" stringByAppendingString:user]]];
        
    }

    - (void)openDonateBitcoin {
        
        UIPasteboard *appPasteBoard = [UIPasteboard generalPasteboard];
        appPasteBoard.persistent = YES;
        [appPasteBoard setString: @"1PiVT3TfzvtLpQmmFyxHtdMVzyDGhE1sN"];

        if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"bitcoin:"]])
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"bitcoin:"]];

    }

    - (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
        
        [self dismissViewControllerAnimated: YES completion: nil];
        
    }


@end

@implementation NellaBackgroundController

    - (id)specifiers {
        
        if (_specifiers == nil) {
            
            _specifiers = [[self loadSpecifiersFromPlistName:@"NellaBackgroundPrefs" target:self] retain];

        }

        return _specifiers;
        
    }

    - (void)viewWillAppear:(BOOL)animated {
        
        [self clearCache];
        [self reload];  
        [super viewWillAppear:animated];
    }

    /*
    - (void)chooseBackgroundImage {

        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.allowsEditing = YES;
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

        [self.navigationController presentViewController:imagePicker animated:YES completion: nil];
        [imagePicker release];
    }

    - (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

        NSString *path = [NSString stringWithFormat:@"/var/mobile/Library/Nella/wallpaper.png"];
        UIImage *picture = info[UIImagePickerControllerEditedImage];
        NSData *imageData = UIImagePNGRepresentation(picture);
        [imageData writeToFile:path atomically:YES];
        [self dismissViewControllerAnimated: YES completion: nil];

    }
    */
@end

@implementation NellaButtonController

    - (id)specifiers {
        
        if (_specifiers == nil) {
            
            _specifiers = [[self loadSpecifiersFromPlistName:@"NellaButtonPrefs" target:self] retain];

        }

        return _specifiers;
        
    }

    - (void)viewWillAppear:(BOOL)animated {
        
        [self reload];  
        [super viewWillAppear:animated];
    
    }

@end

@implementation NellaMiscController

    - (id)specifiers {
        
        if (_specifiers == nil) {
            
            _specifiers = [[self loadSpecifiersFromPlistName:@"NellaMiscPrefs" target:self] retain];

        }

        return _specifiers;
        
    }

@end
    
@implementation NellaHeaderCell

    - (id)initWithSpecifier:(PSSpecifier *)specifier {
            
        self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell" specifier:specifier];
            
            if (self) {
                
                int width = [[UIScreen mainScreen] bounds].size.width;

                CGRect frame = CGRectMake(0, -15, width, 70);


                tweakName = [[UILabel alloc] initWithFrame: frame];
                [tweakName setNumberOfLines:1];
                tweakName.font = [UIFont fontWithName:@"HelveticaNeue-Ultralight" size:56];
                [tweakName setText:@"Nella"];
                [tweakName setBackgroundColor: [UIColor clearColor]];
                tweakName.textColor = [UIColor colorWithRed: 0.0 green: 0.298 blue: 0.427 alpha: 1.0];
                tweakName.textAlignment = NSTextAlignmentCenter;


            [self addSubview:tweakName];

            }
            
        return self;
    
    }

    - (CGFloat)preferredHeightForWidth:(CGFloat)arg1 {
        
        return 70.f;
        
    }

@end