#include "NellaBackgroundCell.h"

@implementation NellaBackgroundCell

- (id)initWithSpecifier:(PSSpecifier *)specifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell" specifier:specifier];
        if (self) {
            CGFloat width = [[UIScreen mainScreen] bounds].size.width;
            iv = [[UIImageView alloc] initWithFrame: CGRectMake(0,0,width,100)];
            [self addSubview: iv];
        }
    return self;
}

- (CGFloat)preferredHeightForWidth:(CGFloat)arg1 {
    return 100.0f;
}

@end
