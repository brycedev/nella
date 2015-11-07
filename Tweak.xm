#import "BDSettingsManager.h"

@interface NSObject (SpringBoard)
- (instancetype)sharedInstance;
@end

@interface ProgressController : UIViewController
- (void)webView:(UIWebView *)webView didFinishLoadForFrame:(id)frame;
- (NSString *)colorToWeb:(UIColor *)arg1;
- (void)webView:(UIWebView *)webView didReceiveTitle:(NSString *)title forFrame:(id)frame;
- (void)didStartLoading;
@end

UIWebView *wv;

%hook ProgressController

- (void)webView:(UIWebView *)webView didReceiveTitle:(NSString *)title forFrame:(id)frame {
    %orig;
    if([[BDSettingsManager sharedManager] enabled] && [[BDSettingsManager sharedManager] autoFinish]) {
        if( [title caseInsensitiveCompare:@"complete"] == NSOrderedSame ) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [webView stringByEvaluatingJavaScriptFromString: @"finish();"];
            });
        }
    }
}

- (void)webView:(UIWebView *)webView didFinishLoadForFrame:(id)frame {
    %orig;
    if([[BDSettingsManager sharedManager] enabled]){
        if([[BDSettingsManager sharedManager] borderRadius] != 10 && (![[BDSettingsManager sharedManager] noBorder])){
            NSString *br = [NSString stringWithFormat:@"%li", (long)[[BDSettingsManager sharedManager] borderRadius]];
            NSString *brValue = [NSString stringWithFormat:@"'%@px';" , br];
            NSString *buttonJS = @"var button = document.querySelector('#button');button.style.borderRadius =";
            NSString *buttonJSToInject = [NSString stringWithFormat:@"%@%@", buttonJS, brValue];
            [webView stringByEvaluatingJavaScriptFromString:buttonJSToInject];
        }
        if([[BDSettingsManager sharedManager] noBorder]){
            NSString *noBorderJs = @"var button = document.querySelector('#button');button.style.borderColor = 'transparent';";
            [webView stringByEvaluatingJavaScriptFromString:noBorderJs];
        }
    }
}

%end

%ctor {
    [BDSettingsManager sharedManager];
}
