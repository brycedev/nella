#define PREF_PATH @"/var/mobile/Library/Preferences/com.brycedev.nella.plist"
#define WALL_PATH @"/var/mobile/Library/Nella/userwallpaper.jpg"

static BOOL enabled = YES;

//background components

static BOOL bgImageURLEnabled = NO;
static BOOL bgColorEnabled = YES;
static UIColor * bgColor;

static NSString * bgURL = @"";

//button components

static UIColor * borderColor;
static UIColor * buttonTextColor;
static float borderRadius = 7.0;
static BOOL noBorder = NO;

//misc components

static BOOL autoFinish = YES;
static int autoFinishWaitTime = 4;

//globals

UIImage *sbImage;
UIImage *userImage;
UIWebView *webView;
UILabel *timerLabel;
NSTimer *delayTimer;
BOOL didStopTimer;

@interface NSObject (SpringBoard)

    - (instancetype)sharedInstance;
    
@end

@interface ProgressController : UIViewController

    - (void)webView:(id)arg1 didFinishLoadForFrame:(id)arg2;
    - (BOOL)isHex:(NSString *)arg1;
    - (NSString *)colorToWeb:(UIColor *)arg1;
    - (void)webView:(id)arg1 didReceiveTitle:(id)arg2 forFrame:(id)arg3;
    - (void)didStartLoading;
    - (void)setNavigationBarTintColor:(id)arg1;
    - (void)handleTap:(UITapGestureRecognizer *)arg1;
    - (UIImage *)imageResize :(UIImage*)arg1 andResizeTo:(CGSize)arg2;
    - (BOOL)isValidImageURL : (NSString *)arg1;
    
@end
