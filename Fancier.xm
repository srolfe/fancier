#include "Fancier.h"
#include "common.h"

@implementation Fancier
	
	- (id)init{
		self=[super init];
		if (self){
			[self loadConfiguration];
		}
		return self;
	}
	
	+ (Fancier *)sharedInstance{
		static dispatch_once_t p = 0;
		__strong static id _sharedObject = nil;
		
	    dispatch_once(&p, ^{
	        _sharedObject = [[self alloc] init];
	    });
		
	    return _sharedObject;
	}
	
	- (void)loadConfiguration{
		config=[[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.chewmieser.fancier.plist"];
		[[NSNotificationCenter defaultCenter] postNotificationName:@"com.chewmieser.fancier.reloadColors" object:nil];
	}
	
	- (UIColor *)getColorForPath:(NSString *)path{
		NSString *colorHex=[config objectForKey:path];
		if ([colorHex stringByReplacingOccurrencesOfString:@"#" withString:@""].length>=6 && [[config objectForKey:[NSString stringWithFormat:@"AO-%@",[[NSBundle mainBundle] bundleIdentifier]]] boolValue] != YES){
			unsigned int hexInt = 0;
			NSScanner *scanner = [NSScanner scannerWithString:colorHex];
			[scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
			[scanner scanHexInt:&hexInt];

			UIColor *color=UIColorFromRGB(hexInt);
			return color;
		}else{
			return nil;
		}
	}
	
	- (void)observeValueForKeyPath:(NSString *) keyPath ofObject:(id) object change:(NSDictionary *) change context:(void *) context{
		[self loadConfiguration];
	}
	
@end

static void PreferencesChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo){
	[[Fancier sharedInstance] loadConfiguration];
}	

__attribute__((constructor)) static void init() {
	[Fancier sharedInstance]; // Create our shared instance
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, PreferencesChanged, CFSTR("com.chewmieser.fancier.prefs-changed"), NULL, CFNotificationSuspensionBehaviorCoalesce);
}

// -- Allow isFancierInstance across UIView
static bool isFancierInstance;

@implementation UIView (Fancier)
	// Handle @property
	- (void)setIsFancierInstance:(BOOL)fancy{
		objc_setAssociatedObject(self, &isFancierInstance, [NSNumber numberWithBool:fancy], OBJC_ASSOCIATION_RETAIN);
	}

	- (BOOL)isFancierInstance{
		return [objc_getAssociatedObject(self, &isFancierInstance) boolValue];
	}
@end

// -- Handle Navigation Bar
@implementation UINavigationBar (Fancier)
	- (void)loadColors{
		if ([[Fancier sharedInstance] getColorForPath:@"global.nav.background"]!=nil){
			[self setBarTintColor:nil];
		}
		
		if ([[Fancier sharedInstance] getColorForPath:@"global.nav.title"]!=nil){
			[self setTitleTextAttributes:nil];
		}
		
		if ([[Fancier sharedInstance] getColorForPath:@"global.nav.items"]!=nil){
			[self setTintColor:nil];
		}
	}
@end

%hook UINavigationBar
	// Force color choices
	- (id)initWithFrame:(struct CGRect)arg1{
		UINavigationBar *obj=%orig;
		[obj setIsFancierInstance:NO];
		
		[obj loadColors];
		[[NSNotificationCenter defaultCenter] addObserver:obj selector:@selector(loadColors) name:@"com.chewmieser.fancier.reloadColors" object:nil];
		
		return obj;
	}
	
	// Background
	- (void)setBarTintColor:(UIColor *)arg1{
		UIColor *color=[[Fancier sharedInstance] getColorForPath:@"global.nav.background"];
		if (!color || self.isFancierInstance){
			if (arg1 == nil){
				return;
			}else{
				%orig;
			}
		}else{
			%orig(color);
		}
	}
	
	- (void)setTintColor:(UIColor *)arg1{
		UIColor *color=[[Fancier sharedInstance] getColorForPath:@"global.nav.items"];
		if (!color || self.isFancierInstance){
			if (arg1 == nil){
				return;
			}else{
				%orig;
			}
		}else{
			%orig(color);
		}
	}
	
	// Title
	- (void)setTitleTextAttributes:(NSDictionary *)dict{
		UIColor *color=[[Fancier sharedInstance] getColorForPath:@"global.nav.title"];
		if (!color || self.isFancierInstance){
			if (dict == nil){ return; }else{ %orig; }
		}else{
			if (dict == nil) dict=[[NSDictionary alloc] init];
			NSMutableDictionary *tmp=[dict mutableCopy];
			[tmp setObject:color forKey:NSForegroundColorAttributeName];
			dict=[tmp copy];
		
			%orig(dict);
		}
	}
%end

// -- Handle Tab Bar
@implementation UITabBar (Fancier)
	- (void)loadColors{
		if ([[Fancier sharedInstance] getColorForPath:@"global.tab.background"]!=nil){
			[self setBarTintColor:nil];
		}
		
		if ([[Fancier sharedInstance] getColorForPath:@"global.tab.selectedicons"]!=nil){
			[self setTintColor:nil];
		}
		
		[self setItems:self.items animated:NO];
	}
@end

%hook UITabBar
	// Force color choices
	- (id)initWithFrame:(struct CGRect)arg1{
		UITabBar *obj=%orig;
		[obj setIsFancierInstance:NO];
	
		[obj loadColors];
		[[NSNotificationCenter defaultCenter] addObserver:obj selector:@selector(loadColors) name:@"com.chewmieser.fancier.reloadColors" object:nil];
	
		return obj;
	}

	// Background
	- (void)setBarTintColor:(UIColor *)arg1{
		UIColor *color=[[Fancier sharedInstance] getColorForPath:@"global.tab.background"];
		if (!color || self.isFancierInstance){
			if (arg1 == nil){ return; }else{ %orig; }
		}else{
			%orig(color);
		}
	}

	// Selected Icons
	- (void)setTintColor:(UIColor *)arg1{
		UIColor *color=[[Fancier sharedInstance] getColorForPath:@"global.tab.selectedicons"];
		if (!color || self.isFancierInstance){
			if (arg1 == nil){ return; }else{ %orig; }
		}else{
			%orig(color);
		}
	}

	// Unselected Icons + Selected Icons 2
	- (void)setItems:(NSArray *)items animated:(BOOL)animated{
		%orig;
	
		UIColor *unselected=[[Fancier sharedInstance] getColorForPath:@"global.tab.icons"];
		UIColor *selected=[[Fancier sharedInstance] getColorForPath:@"global.tab.selectedicons"];
		if (!self.isFancierInstance){
			for (UITabBarItem *item in self.items){
				if (unselected!=nil){
					item.unselectedImage = [item.unselectedImage imageWithColor:unselected];
					[item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:unselected,NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
				}
			
				if (selected!=nil){
					[item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:selected,NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
				}
			}
		}
	}
%end

// -- Handle Table View
@implementation UITableView (Fancier)
	- (void)loadColors{
		if ([[Fancier sharedInstance] getColorForPath:@"global.table.background"]!=nil){
			[self setBackgroundColor:nil];
		}
		
		if ([[Fancier sharedInstance] getColorForPath:@"global.table.separator"]!=nil){
			[self setSeparatorColor:nil];
		}
		
		[self setTintColor:nil];
	}
@end

%hook UITableView
	// Force color choices
	- (id)initWithFrame:(struct CGRect)arg1 style:(long long)arg2{
		UITableView *obj=%orig;
		[obj setIsFancierInstance:NO];
	
		[obj loadColors];		
		[[NSNotificationCenter defaultCenter] addObserver:obj selector:@selector(loadColors) name:@"com.chewmieser.fancier.reloadColors" object:nil];
	
		return obj;
	}

	// Background
	- (void)setBackgroundColor:(id)arg1{
		UIColor *color=[[Fancier sharedInstance] getColorForPath:@"global.table.background"];
		if (!color || self.isFancierInstance || [[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.springboard"]){
			if (arg1 == nil && ![[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.springboard"]){ return; }else{ %orig; }
		}else{
			%orig(color);
		}
	}
	
	- (void)setSeparatorColor:(UIColor *)arg1{
		UIColor *color=[[Fancier sharedInstance] getColorForPath:@"global.table.separator"];
		if (!color || self.isFancierInstance || [[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.springboard"]){
			if (arg1 == nil){ return; }else{ %orig; }
		}else{
			%orig(color);
		}
	}
	
	// Cell background & title...
	/*- (id)cellForRowAtIndexPath:(id)arg1{
		UITableViewCell *cell=%orig;
		UIColor *color=[[Fancier sharedInstance] getColorForPath:@"global.table.cellbackground"];
		if (!color || self.isFancierInstance){
			return cell;
		}else{
			NSLog(@">>> %@",cell);
			[cell setBackgroundColor:color];
			return cell;
		}
	}*/
%end

// -- Handle Table View Cell
@implementation UITableViewCell (Fancier)
	- (void)loadColors{
		if ([[Fancier sharedInstance] getColorForPath:@"global.table.cellbackground"]!=nil){
			[self setBackgroundColor:nil];
		}
		
		[self setNeedsDisplay];
	}
@end

%hook UITableViewCell
	- (id)initWithStyle:(long long)arg1 reuseIdentifier:(id)arg2{
		UITableViewCell *obj=%orig;
		[obj setIsFancierInstance:NO];
	
		[obj loadColors];		
		[[NSNotificationCenter defaultCenter] addObserver:obj selector:@selector(loadColors) name:@"com.chewmieser.fancier.reloadColors" object:nil];
	
		return obj;
	}
	
	- (void)setBackgroundColor:(id)arg1{
		UIColor *color=[[Fancier sharedInstance] getColorForPath:@"global.table.cellbackground"];
		if (!color || self.isFancierInstance || [[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.springboard"]){
			if (arg1 == nil && ![[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.springboard"]){ return; }else{ %orig; }
		}else{
			%orig(color);
		}
	}
	
	- (id)textLabel{
		UILabel *label=%orig;
		UIColor *color=[[Fancier sharedInstance] getColorForPath:@"global.table.celltext"];
		if (!color || self.isFancierInstance || [[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.springboard"]){
			return label;
		}else{
			[label setTextColor:color];
			return label;
		}
	}
	
	/*- (UIView *)contentView{
		UIView *content=%orig;
		NSLog(@">> View: %@",self.subviews);
		UIColor *color=[[Fancier sharedInstance] getColorForPath:@"global.table.cellbackground"];
		if (!color || self.isFancierInstance || [[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.springboard"]){
			return content;
		}else{
			[content setBackgroundColor:color];
			return content;
		}
	}*/
%end

// Key mask
%hook UIKBBackdropView
	- (UIView *)colorTintView{
		if ([[Fancier sharedInstance] getColorForPath:@"global.keyboard.key"]!=nil){
			UIView *tintView=[[UIView alloc] initWithFrame:self.frame];
			[tintView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
			[tintView setBackgroundColor:[[Fancier sharedInstance] getColorForPath:@"global.keyboard.key"]];
			
			UIImage *_maskingImage = [self colorTintMaskImage];
			CALayer *_maskingLayer = [CALayer layer];
			_maskingLayer.frame = tintView.bounds;
			[_maskingLayer setContents:(id)[_maskingImage CGImage]];
			[tintView.layer setMask:_maskingLayer];
		
			return tintView;
		}else{
			return %orig;
		}
	}
%end

%hook UIKBBackgroundView
	- (id)initWithFrame:(struct CGRect)arg1{
		UIKBBackgroundView *zz=%orig;
		
		// Inject Background View
		UIView *tmp=[[UIView alloc] initWithFrame:zz.frame];
		[tmp setTag:42];
		[tmp setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
		[tmp setBackgroundColor:[UIColor clearColor]];
		[zz insertSubview:tmp atIndex:0];
		
		return zz;
	}
	
	- (void)refreshStyleForKeyplane:(id)arg1{
		// Colorize Background View
		if ([[Fancier sharedInstance] getColorForPath:@"global.keyboard.background"]!=nil){
			for (UIView *tmp in [self subviews]){
				if (tmp.tag==42){
					[tmp setBackgroundColor:[[Fancier sharedInstance] getColorForPath:@"global.keyboard.background"]];
				}
			}
		}
		
		%orig;
	}
%end

// Force dark keyboard - IF we colorize
%hook UIKBRenderConfig
	+ (id)defaultConfig{
		if ([[Fancier sharedInstance] getColorForPath:@"global.keyboard.background"]!=nil || [[Fancier sharedInstance] getColorForPath:@"global.keyboard.key"]!=nil){
			return [objc_getClass("UIKBRenderConfig") darkConfig];
		}else{
			return %orig;
		}
	}
%end