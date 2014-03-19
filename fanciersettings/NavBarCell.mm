#import "NavBarCell.h"

@implementation NavBarCell
	- (id)initWithSpecifier:(PSSpecifier *)specifier{
	    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"navCell" specifier:specifier];
	    if (self) {
			CGRect frame=[self frame];
			UINavigationItem *prevItem = [[UINavigationItem alloc] initWithTitle:@"Fancy"];
			UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:@"Fancier"];
			
			_navbar = [[UINavigationBar alloc] init];
			
			[navItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Test" style:UIBarButtonItemStylePlain target:nil action:nil] animated:NO];
			[navItem setHidesBackButton:NO animated:NO];
			[_navbar setFrame:CGRectMake(frame.origin.x,frame.origin.y+22,frame.size.width,frame.size.height)];
			
			[_navbar setItems:[NSArray arrayWithObjects:prevItem,navItem,nil] animated:NO];
			
			[self addSubview:_navbar];
		}
		
		return self;
	}
	
	- (float)preferredHeightForWidth:(float)arg1{
	    return 66.f;
	}
@end