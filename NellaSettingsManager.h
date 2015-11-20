@interface NellaSettingsManager : NSObject

@property (nonatomic, copy) NSDictionary *settings;
@property (nonatomic, readonly) BOOL enabled;
@property (nonatomic, readonly) BOOL noBorder;
@property (nonatomic, readonly) BOOL autoFinish;
@property (nonatomic, readonly) NSInteger borderRadius;
@property (nonatomic, readonly) NSString* borderColor;
@property (nonatomic, readonly) NSString* textColor;
@property (nonatomic, readonly) NSString* backgroundColor;

+ (instancetype)sharedManager;
- (void)updateSettings;

@end
