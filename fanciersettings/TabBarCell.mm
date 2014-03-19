#import "TabBarCell.h"

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

@implementation TabBarCell
	- (id)initWithSpecifier:(PSSpecifier *)specifier{
	    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tabCell" specifier:specifier];
	    if (self) {
			self.autoresizingMask = UIViewAutoresizingFlexibleHeight;
			self.clipsToBounds = YES;
			
			CGRect frame=[self frame];
			_tabbar = [[UITabBar alloc] init];
			[_tabbar setFrame:CGRectMake(frame.origin.x,frame.origin.y+22,frame.size.width,frame.size.height)];
			UITabBarItem *favorites=[[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:nil];
			[_tabbar setItems:[NSArray arrayWithObjects:
				favorites,
				[[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:nil],
				[[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:nil],
				[[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMore tag:nil],
				nil
			] animated:NO];
			[_tabbar setSelectedItem:favorites];
			
			[self addSubview:_tabbar];
		}
	
		return self;
	}

	- (float)preferredHeightForWidth:(float)arg1{
	    return 66.f;
	}
@end