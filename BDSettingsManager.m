#import "BDSettingsManager.h"

@implementation BDSettingsManager

+ (instancetype)sharedManager {
    static dispatch_once_t p = 0;
    __strong static id _sharedSelf = nil;
    dispatch_once(&p, ^{
        _sharedSelf = [[self alloc] init];
    });
    return _sharedSelf;
}

void prefschanged(CFNotificationCenterRef center, void * observer, CFStringRef name, const void * object, CFDictionaryRef userInfo) {
    [[BDSettingsManager sharedManager] updateSettings];
}

- (id)init {
    if (self = [super init]) {
        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, prefschanged, CFSTR("com.brycedev.nella.prefschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
        [self updateSettings];

    }
    return self;
}

- (void)updateSettings {
    self.settings = nil;
    CFPreferencesAppSynchronize(CFSTR("com.brycedev.nella"));
    CFStringRef appID = CFSTR("com.brycedev.nella");
    CFArrayRef keyList = CFPreferencesCopyKeyList(appID , kCFPreferencesCurrentUser, kCFPreferencesAnyHost) ?: CFArrayCreate(NULL, NULL, 0, NULL);
    self.settings = (NSDictionary *)CFPreferencesCopyMultiple(keyList, appID , kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
    CFRelease(keyList);
    HBLogInfo(@"the settings are : %@", self.settings);
}

- (BOOL)enabled {
    return self.settings[@"enabled"] ? [self.settings[@"enabled"] boolValue] : YES;
}

- (BOOL)noBorder {
    return self.settings[@"noBorder"] ? [self.settings[@"noBorder"] boolValue] : NO;
}

- (BOOL)autoFinish {
    return self.settings[@"autoFinish"] ? [self.settings[@"autoFinish"] boolValue] : NO;
}

- (NSInteger)borderRadius {
    return self.settings[@"borderRadius"] ? [self.settings[@"borderRadius"] integerValue] : 10;
}

- (NSString*)borderColor {
    return self.settings[@"borderColor"] ? self.settings[@"borderColor"] : @"#ffffff";
}

- (NSString*)textColor {
    return self.settings[@"textColor"] ? self.settings[@"textColor"] : @"#ffffff";
}

- (NSString*)backgroundColor {
    return self.settings[@"backgroundColor"] ? self.settings[@"backgroundColor"] : @"#ffffff";
}

@end
