#import "Global.h"
#include "NellaBackgroundController.h"

UIColor *originalTint;
UIWindow *settingsView;

PSSpecifier *bgSpecifier;

@implementation NellaBackgroundController

- (id)specifiers {
    if (_specifiers == nil) {
        _specifiers = [[self loadSpecifiersFromPlistName:@"NellaBackgroundPrefs" target:self] retain];
        for(PSSpecifier *spec in _specifiers){
            HBLogInfo(@"the current spec is : %@", spec);
        }
    }
    return _specifiers;
}

- (void)loadView {
	[super loadView];
	[UISwitch appearanceWhenContainedIn: self.class, nil].onTintColor = NELLA_BLUE;
	[UISegmentedControl appearanceWhenContainedIn: self.class, nil].tintColor = NELLA_BLUE;
}

- (void)viewWillAppear:(BOOL)animated {
	settingsView = [[UIApplication sharedApplication] keyWindow];
	originalTint = settingsView.tintColor;
	settingsView.tintColor = NELLA_BLUE;
}

- (void)viewWillDisappear:(BOOL)animated {
	settingsView.tintColor = originalTint;
}

- (void)selectPhoto {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self.navigationController presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    HBLogInfo(@"the chosen image : %@", chosenImage);
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
