//#import "TabBarCell.mm"
#import "common.h"
#include <substrate.h>

@interface UITabBarItem (UITabBarItem_Private)
	- (id)_internalTemplateImages;
	- (id)_internalTemplateImage;
	- (void)_setInternalTemplateImage:(id)arg1;
	- (id)_internalTitle;
	- (void)_setInternalTitle:(id)arg1;
	@property(nonatomic) SEL action;
	@property(nonatomic) id target;
	@property(retain, nonatomic) UIImage *unselectedImage;
	@property(nonatomic) _Bool animatedBadge;
	@property(nonatomic) _Bool viewIsCustom;
	@property(retain, nonatomic) UIView *view;
	- (long long)systemItem;
	- (_Bool)isSystemItem;
@end

@interface TabBarCell : PSTableCell{
	UITabBar *_tabbar;
}

	//- (void)setTabTint:(UIColor *)color forItem:(int)item;
@end