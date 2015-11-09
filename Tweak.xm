#import "BDSettingsManager.h"

@interface ProgressController : UIViewController
- (void)webView:(UIWebView *)webView didFinishLoadForFrame:(id)frame;
- (void)webView:(UIWebView *)webView didReceiveTitle:(NSString *)title forFrame:(id)frame;
@end

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
        if(![[BDSettingsManager sharedManager] noBorder]){
            NSString *borderColorJS = [NSString stringWithFormat:@"var button = document.querySelector('#button');button.style.borderColor = '%@';", [[BDSettingsManager sharedManager] borderColor]];
            [webView stringByEvaluatingJavaScriptFromString:borderColorJS];
            NSString *textColorJS = [NSString stringWithFormat:@"var button = document.querySelector('#button');button.style.color = '%@';", [[BDSettingsManager sharedManager] textColor]];
            [webView stringByEvaluatingJavaScriptFromString:textColorJS];
        }
        NSString *backgroundColorJS = [NSString stringWithFormat: @"var body=document.querySelector('body');body.style.backgroundColor= '%@'", [[BDSettingsManager sharedManager] backgroundColor]] ;
        [webView stringByEvaluatingJavaScriptFromString:backgroundColorJS];
    }
}

%end

%ctor {
    [BDSettingsManager sharedManager];
}
