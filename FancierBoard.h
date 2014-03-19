@interface Fancier : NSObject{
	NSDictionary *config;
}

	+ (Fancier *)sharedInstance;
	- (void)loadConfiguration;
	- (UIColor *)getColorForPath:(NSString *)path;
@end
	
@interface SBWallpaperEffectView : UIView
@end

@interface SBSearchHeader : UIView
@end

@interface SBSearchResultsBackdropView : UIView
{
    UIView *_tintView;
}

- (void)layoutSubviews;
- (void)dealloc;
- (id)initWithFrame:(struct CGRect)arg1;

@end

@interface UIView (Fancier)
	@property (nonatomic) BOOL isSearchHeader;
@end