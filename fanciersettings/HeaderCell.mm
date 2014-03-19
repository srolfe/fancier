#import "HeaderCell.h"

@implementation HeaderCell
	- (id)initWithSpecifier:(PSSpecifier *)specifier{
	    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"headerCell" specifier:specifier];
	    if (self) {
			UIImage *bkIm = [[UIImage alloc] initWithContentsOfFile:[[NSBundle bundleWithPath:@"/Library/PreferenceBundles/FancierSettings.bundle"] pathForResource:@"fancierHeader" ofType:@"png"]];
			_background = [[UIImageView alloc] initWithImage:bkIm];
			[self addSubview:_background];
	    }
	
	    return self;
	}

	- (float)preferredHeightForWidth:(float)arg1{
	    return 100.f;
	}
@end