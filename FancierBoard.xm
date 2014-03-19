#include "FancierBoard.h"
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
		if ([colorHex stringByReplacingOccurrencesOfString:@"#" withString:@""].length>=6){
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

static bool isSearchHeader;

@implementation UIView (Fancier)
	// Handle @property
	- (void)setIsSearchHeader:(BOOL)search{
		objc_setAssociatedObject(self, &isSearchHeader, [NSNumber numberWithBool:search], OBJC_ASSOCIATION_RETAIN);
	}

	- (BOOL)isSearchHeader{
		return [objc_getAssociatedObject(self, &isSearchHeader) boolValue];
	}
@end

%hook SBSearchResultsBackdropView
	- (void)layoutSubviews{
		%orig;
		
		UIView *tintView=MSHookIvar<UIView *>(self,"_tintView");
		if ([self isSearchHeader]){
			if ([[Fancier sharedInstance] getColorForPath:@"springboard.spotlight.header"]) [tintView setBackgroundColor:[[Fancier sharedInstance] getColorForPath:@"springboard.spotlight.header"]];
		}else{
			if ([[Fancier sharedInstance] getColorForPath:@"springboard.spotlight.table"]) [tintView setBackgroundColor:[[Fancier sharedInstance] getColorForPath:@"springboard.spotlight.table"]];
		}
	}
%end
	
%hook SBSearchHeader
	- (void)layoutSubviews{
		%orig;
		
		if ([[[self subviews] objectAtIndex:1] class] != [objc_getClass("SBSearchResultsBackdropView") class]){
			if ([[[self subviews] objectAtIndex:0] class] == [objc_getClass("SBWallpaperEffectView") class]){
				[[[self subviews] objectAtIndex:0] setAlpha:0];
			}
			
			SBSearchResultsBackdropView *newBlur=[[objc_getClass("SBSearchResultsBackdropView") alloc] initWithFrame:self.bounds];
			[newBlur setIsSearchHeader:YES];
			[newBlur setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
			[self insertSubview:newBlur atIndex:1];
		}
	}
%end

@interface _UIBackdropView : UIView
	- (void)transitionToColor:(id)arg1;
@end

%hook SBControlCenterContentContainerView
	// Colorize CC background
	/*-(id)backdropView{
		_UIBackdropView *view=(_UIBackdropView *)%orig;
		if ([[Fancier sharedInstance] getColorForPath:@"springboard.cc.background"]) [view transitionToColor:[[Fancier sharedInstance] getColorForPath:@"springboard.cc.background"]];
		return view;
	}*/
	
	// Colorize CC background
	- (void)layoutSubviews{
		_UIBackdropView *view=MSHookIvar<_UIBackdropView *>(self,"_backdropView");
		if ([[Fancier sharedInstance] getColorForPath:@"springboard.cc.background"]) [view transitionToColor:[[Fancier sharedInstance] getColorForPath:@"springboard.cc.background"]];
		
		%orig;
	}
%end

//%hook SBControlCenterContainerView
	/*- (void)updateBackgroundSettings:(id)arg1{
		UIView *tmp=arg1;
		UIView *overlay=[[UIView alloc] initWithFrame:tmp.frame];
		[overlay setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
		[overlay setBackgroundColor:[UIColor redColor]];
		[tmp addSubview:overlay];
		
		%orig(tmp);
	}*/
	
	// Control center - Extra space tint color
	/*- (id)_currentBGColor{
		id tmp=%orig;
		NSLog(@">> | %@",tmp);
		return [UIColor redColor];
	}*/
//%end

@interface SBNotificationCenterViewController : UIViewController
	@property(readonly, nonatomic) _UIBackdropView *backdropView;
@end

%hook SBNotificationCenterViewController
	/*- (void)loadView{
		%orig;
		//UIView *background=MSHookIvar<UIView *>(self,"_backgroundView");
		//NSLog(@">> ! %@",background);
		//[background setBackgroundColor:[UIColor redColor]];
		[self.backdropView transitionToColor:[UIColor redColor]];
	}*/
	
	/*-(id)backdropView{
		_UIBackdropView *view=(_UIBackdropView *)%orig;
		[view transitionToColor:[UIColor redColor]];
		return view;
	}*/
	
	- (void)viewWillAppear:(_Bool)arg1{
		%orig;
		UIView *container=MSHookIvar<UIView *>(self,"_containerView");
		if ([[Fancier sharedInstance] getColorForPath:@"springboard.nc.background"]) [container setBackgroundColor:[[Fancier sharedInstance] getColorForPath:@"springboard.nc.background"]];
	}
%end