#import "Headers.h"

extern "C" UIColor *colorFromDefaultsWithKey(NSString *defaults, NSString *key, NSString *fallback);


%hook ProgressController 
    
    /*
    - (void)viewDidAppear:(BOOL)animated {
	   %orig;

    }
    */
    - (void)webView:(id)arg1 didReceiveTitle:(id)arg2 forFrame:(id)arg3 {
    
        if(enabled) {
        
            if(autoFinish){
            
                 if( [arg2 caseInsensitiveCompare:@"complete"] == NSOrderedSame ) {

                     timerLabel = [[UILabel alloc] initWithFrame: CGRectMake(0.0, 0.0, [self view].bounds.size.width , 80.0)];
                     timerLabel.backgroundColor = [UIColor blackColor];
                     timerLabel.textColor = [UIColor whiteColor];
                     timerLabel.textAlignment = NSTextAlignmentCenter;
                     [timerLabel setFont:[UIFont systemFontOfSize: 28]];
                     timerLabel.center = [self view].center;
                     timerLabel.userInteractionEnabled = YES;
                     timerLabel.text = [NSString stringWithFormat:@"[ %i ]", autoFinishWaitTime];
                     UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
                     [timerLabel addGestureRecognizer: tapGesture];
                     
                     [[self view] addSubview: timerLabel];
                 
                    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(testAutoFinish:) userInfo:nil repeats:YES];
                
                }
            }
        
        }
        
        %orig;
        
    }
    
    - (void)webView:(id)arg1 didFinishLoadForFrame:(id)arg2 {

        %orig;
        webView = arg1;
        didStopTimer = NO;

        if(enabled){
            
            // set the background image from url if enabled
            
            if(bgImageURLEnabled && [self isValidImageURL: bgURL]) {
            
                NSString *bjs = @"var body=document.querySelector('body');body.style.background= 'transparent'";
                [arg1 stringByEvaluatingJavaScriptFromString:bjs];
                NSString *bjs2 = @"var body=document.querySelector('body');body.style.backgroundColor= 'transparent' ";
                [arg1 stringByEvaluatingJavaScriptFromString:bjs2];
                self.view.backgroundColor = [UIColor colorWithPatternImage:[self imageResize : [UIImage imageWithContentsOfFile: WALL_PATH] andResizeTo:self.view.frame.size]];
                [self.view.layer setOpaque:NO];
                self.view.opaque = NO;
                
            }
            
            // set the background color if enabled
            
            if(bgColorEnabled && !bgImageURLEnabled){
            
                NSString *bgColorString = [self colorToWeb: bgColor];
            
                NSString *colorJS = @"var body = document.querySelector('body');body.style.backgroundColor =";
                NSString* appendColor = [NSString stringWithFormat:@"'%@'", bgColorString];
                NSString* colorStringToInject = [NSString stringWithFormat:@"%@%@", colorJS, appendColor];

                [arg1 stringByEvaluatingJavaScriptFromString:colorStringToInject];
            
            }
            
            // set the border radius if border is enabled
            
            if(roundf(borderRadius) != 10 && (!noBorder)){
            
                NSString *br = [NSString stringWithFormat:@"%g", roundf(borderRadius)];
            
                NSString *brValue = [NSString stringWithFormat:@"'%@px';" , br];
            
                NSString *buttonJS = @"var button = document.querySelector('#button');button.style.borderRadius =";
                
                NSString *buttonJSToInject = [NSString stringWithFormat:@"%@%@", buttonJS, brValue];
                
                [arg1 stringByEvaluatingJavaScriptFromString:buttonJSToInject];
            
            }
            
            // set the border color if border is enabled
            
            if(!noBorder){
            
                NSString *borderColorString = [self colorToWeb: borderColor];
            
                NSString *bColorJS = @"var button = document.querySelector('#button');button.style.borderColor =";
                NSString* appendColor = [NSString stringWithFormat:@"'%@'", borderColorString];
                NSString* borderColorStringToInject = [NSString stringWithFormat:@"%@%@", bColorJS, appendColor];

                [arg1 stringByEvaluatingJavaScriptFromString:borderColorStringToInject];
            
            }
            
            // set the button text color
            
            NSString *buttonTextColorString = [self colorToWeb: buttonTextColor];
            NSString *buttonTextJS = @"var button = document.querySelector('#button');button.style.color =";
            NSString *appendColor = [NSString stringWithFormat:@"'%@'", buttonTextColorString];
            NSString *buttonColorStringToInject = [NSString stringWithFormat:@"%@%@", buttonTextJS, appendColor];

            [arg1 stringByEvaluatingJavaScriptFromString:buttonColorStringToInject];
            
            
            // hide the border if border is disabled
            
            if(noBorder){
            
                NSString *noBorderJs = @"var button = document.querySelector('#button');button.style.borderColor = 'transparent';";
                
                [arg1 stringByEvaluatingJavaScriptFromString:noBorderJs];

            }
            
        }
        
    }
    
    %new
    
    - (void)testAutoFinish:(NSTimer *)timer {
        
        
        if(!didStopTimer){
            
            if(autoFinishWaitTime == 0){
        
                [timer invalidate];
                [webView stringByEvaluatingJavaScriptFromString: @"finish();"];

            }
            
            else {

                autoFinishWaitTime = autoFinishWaitTime - 1;
                timerLabel.text = [NSString stringWithFormat:@"[ %i ]", autoFinishWaitTime];

            }
            
        }
        
        else {
            
            [timer invalidate];
            
        }
        
    }
    
    %new
    
    - (BOOL)isHex:(NSString *)string {

        NSCharacterSet* nonHex = [[NSCharacterSet characterSetWithCharactersInString: @"#0123456789ABCDEFabcdef"]invertedSet];
        NSRange nonHexRange = [string rangeOfCharacterFromSet: nonHex];
        BOOL isHex = (nonHexRange.location == NSNotFound);
        
        return isHex;
    }
    
    %new
    
    - (NSString*)colorToWeb:(UIColor*)color {
        
        NSString *webColor = nil;

        if (color && CGColorGetNumberOfComponents(color.CGColor) == 4) {

            const CGFloat *components = CGColorGetComponents(color.CGColor);

            CGFloat red, green, blue;

            red = roundf(components[0] * 255.0);
            green = roundf(components[1] * 255.0);
            blue = roundf(components[2] * 255.0);

            webColor = [[NSString alloc]initWithFormat:@"#%02x%02x%02x", (int)red, (int)green, (int)blue];
        }

        return webColor;
    }

    %new

    - (void)handleTap:(UITapGestureRecognizer *)sender {

            didStopTimer = YES;
            
            [timerLabel removeFromSuperview];

    }

    %new
        
    -(UIImage *)imageResize :(UIImage*)img andResizeTo:(CGSize)newSize {
        
        CGFloat scale = [[UIScreen mainScreen]scale];

        //UIGraphicsBeginImageContext(newSize);
        UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
        [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
        UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
        
    }

    %new
    
    - (BOOL)isValidImageURL:(NSString *)string {
    
        if([string hasPrefix:@"http://"] || [string hasPrefix:@"www."] || [string hasPrefix:@"https://"]){

            if([string hasSuffix:@".jpeg"] || [string hasSuffix:@".jpg"] || [string hasSuffix:@".png"] || [string hasSuffix:@".gif"]){

                return YES;

            }

        }
    
        return NO;
        
    }

%end

static void downloadWallpaperFromURL() {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString* wallTextPath = @"/var/mobile/Library/Nella/wall.txt";
    [fileManager removeItemAtPath: wallTextPath error:nil];
    
    NSString *string = bgURL;
    
    if([string hasPrefix:@"http://"] || [string hasPrefix:@"www."] || [string hasPrefix:@"https://"]){

        if([string hasSuffix:@".jpeg"] || [string hasSuffix:@".jpg"] || [string hasSuffix:@".png"] || [string hasSuffix:@".gif"]){
            
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString: bgURL]];
            [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]
                completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                    if ( !error ) {
                        UIImage *image = [UIImage imageWithData:data];
                        [UIImageJPEGRepresentation(image, 1.0) writeToFile: WALL_PATH atomically:YES];
                    } 
                }];   
            
        }
        
    }
    
    [bgURL writeToFile: wallTextPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
}

static void setupPaths(){

    NSString* nellaPath = @"/var/mobile/Library/Nella";
    NSString* wallTextPath = @"/var/mobile/Library/Nella/wall.txt";
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: nellaPath]){
    
        [fileManager createDirectoryAtPath:nellaPath withIntermediateDirectories:YES attributes:nil error:nil];
        
    }
    
    if (![fileManager fileExistsAtPath: wallTextPath]){
    
        [fileManager createFileAtPath: wallTextPath contents:nil attributes:nil];
        
    }

}

static void loadPrefs(){

    NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:PREF_PATH];
    
    if(prefs){
        
        NSString* wallTextPath = @"/var/mobile/Library/Nella/wall.txt";
        
        NSString *oldURL = [NSString stringWithContentsOfFile: wallTextPath encoding:NSUTF8StringEncoding error:nil];
    
        enabled = ([prefs objectForKey:@"kEnabled"] ? [[prefs objectForKey:@"kIsEnabled"] boolValue] : enabled);
        noBorder = ([prefs objectForKey:@"kNoBorder"] ? [[prefs objectForKey:@"kNoBorder"] boolValue] : noBorder);
        autoFinish = ([prefs objectForKey:@"kAutoFinish"] ? [[prefs objectForKey:@"kAutoFinish"] boolValue] : autoFinish);
        bgImageURLEnabled = ([prefs objectForKey:@"kBGURLIsEnabled"] ? [[prefs objectForKey:@"kBGURLIsEnabled"] boolValue] : bgImageURLEnabled);
        
        NSString *possibleURL = ([prefs objectForKey:@"kBGURL"]);
        
        bgURL = possibleURL;
        
        if( !([possibleURL isEqualToString: oldURL]) && !([possibleURL isEqualToString: @""])){
            
            bgURL = possibleURL;
            downloadWallpaperFromURL();
            
        }
        
        autoFinishWaitTime = ([prefs objectForKey:@"kFinishDelay"] ? [[prefs objectForKey:@"kFinishDelay"] intValue]: autoFinishWaitTime);
        borderRadius = ([prefs objectForKey:@"kBorderRadius"] ? [[prefs objectForKey:@"kBorderRadius"] floatValue]: borderRadius);

        bgColorEnabled = ([prefs objectForKey:@"kBGColorEnabled"] ? [[prefs objectForKey:@"kBGColorEnabled"]boolValue]: bgColorEnabled);
        bgColor = colorFromDefaultsWithKey(@"com.brycedev.nella", @"kBGColor", @"#000");
        
        borderColor = colorFromDefaultsWithKey(@"com.brycedev.nella", @"kBorderColor", @"#fff");
        
        buttonTextColor = colorFromDefaultsWithKey(@"com.brycedev.nella", @"kButtonTextColor", @"#fff");

        
    }
    
    [prefs release];
    
}

static void loadprefsfromsettings(){
    
    loadPrefs();
    
}

%ctor {
    
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadprefsfromsettings, CFSTR("com.brycedev.nella/prefschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    setupPaths();
    loadPrefs();

}

