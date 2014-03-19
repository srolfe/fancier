@interface Fancier : NSObject{
	NSDictionary *config;
}

	+ (Fancier *)sharedInstance;
	- (void)loadConfiguration;
	- (UIColor *)getColorForPath:(NSString *)path;
@end

// UIView categories
@interface UIView (Fancier)
	@property (nonatomic) BOOL isFancierInstance;
@end

@interface UINavigationBar (Fancier)
	- (void)loadColors;
@end

@interface UITabBar (Fancier)
	- (void)loadColors;
@end
	
@interface UITableView (Fancier)
	- (void)loadColors;
@end
	
@interface UITableViewCell (Fancier)
	- (void)loadColors;
@end

// Private API
@interface UITabBarItem (UITabBarItem_Private)
	@property(retain, nonatomic) UIImage *unselectedImage;
@end

// Helper class
@interface UIImage(Overlay)
@end
	
@implementation UIImage(Overlay)
- (UIImage *)imageWithColor:(UIColor *)color1
{
        UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextTranslateCTM(context, 0, self.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextSetBlendMode(context, kCGBlendModeNormal);
        CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
        CGContextClipToMask(context, rect, self.CGImage);
        [color1 setFill];
        CGContextFillRect(context, rect);
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
}
@end

@interface _UIBackdropView : UIView
	@property(retain, nonatomic) UIImage *colorTintMaskImage;
@end

@interface UIKBBackdropView : _UIBackdropView
@end
	
@interface UIKBBackgroundView : UIView
@end
	
@interface UIKBRenderConfig
	+ (id)darkConfig;
@end