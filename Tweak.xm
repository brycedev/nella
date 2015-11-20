#import "NellaSettingsManager.h"
#import <libcolorpicker.h>

@interface ProgressController : UIViewController
- (void)webView:(UIWebView *)webView didFinishLoadForFrame:(id)frame;
- (void)webView:(UIWebView *)webView didReceiveTitle:(NSString *)title forFrame:(id)frame;
@end

%hook ProgressController

- (void)webView:(UIWebView *)webView didReceiveTitle:(NSString *)title forFrame:(id)frame {
    %orig;
    if([[NellaSettingsManager sharedManager] enabled] && [[NellaSettingsManager sharedManager] autoFinish]) {
        if( [title caseInsensitiveCompare:@"complete"] == NSOrderedSame ) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [webView stringByEvaluatingJavaScriptFromString: @"finish();"];
            });
        }
    }
}

- (void)webView:(UIWebView *)webView didFinishLoadForFrame:(id)frame {
    %orig;
    if([[NellaSettingsManager sharedManager] enabled]){
        HBLogInfo(@"nella is enabled");
        if([[NellaSettingsManager sharedManager] borderRadius] != 10 && (![[NellaSettingsManager sharedManager] noBorder])){
            NSString *br = [NSString stringWithFormat:@"%li", (long)[[NellaSettingsManager sharedManager] borderRadius]];
            NSString *brValue = [NSString stringWithFormat:@"'%@px';" , br];
            NSString *buttonJS = @"var button = document.querySelector('#button');button.style.borderRadius =";
            NSString *buttonJSToInject = [NSString stringWithFormat:@"%@%@", buttonJS, brValue];
            [webView stringByEvaluatingJavaScriptFromString:buttonJSToInject];
        }
        if([[NellaSettingsManager sharedManager] noBorder]){
            NSString *noBorderJs = @"var button = document.querySelector('#button');button.style.borderColor = 'transparent';";
            [webView stringByEvaluatingJavaScriptFromString:noBorderJs];
        }
        if(![[NellaSettingsManager sharedManager] noBorder]){
            NSString *borderColorJS = [NSString stringWithFormat:@"var button = document.querySelector('#button');button.style.borderColor = '%@';", [[[NellaSettingsManager sharedManager] borderColor] substringToIndex:7]];
            HBLogInfo(@"border color js : %@", borderColorJS);
            [webView stringByEvaluatingJavaScriptFromString:borderColorJS];
            NSString *textColorJS = [NSString stringWithFormat:@"var button = document.querySelector('#button');button.style.color = '%@';", [[[NellaSettingsManager sharedManager] textColor] substringToIndex:7]];
            [webView stringByEvaluatingJavaScriptFromString:textColorJS];
        }
        NSString *backgroundColorJS = [NSString stringWithFormat: @"var body=document.querySelector('body');body.style.backgroundColor= '%@'", [[[NellaSettingsManager sharedManager] backgroundColor] substringToIndex:7]] ;
        [webView stringByEvaluatingJavaScriptFromString:backgroundColorJS];
    }
}

%end

%ctor {
    [NellaSettingsManager sharedManager];
}
