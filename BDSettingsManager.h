@interface BDSettingsManager : NSObject

@property (nonatomic, copy) NSDictionary *settings;
@property (nonatomic, readonly) BOOL enabled;
@property (nonatomic, readonly) BOOL noBorder;
@property (nonatomic, readonly) BOOL autoFinish;
@property (nonatomic, readonly) NSInteger borderRadius;

+ (instancetype)sharedManager;
- (void)updateSettings;

@end
