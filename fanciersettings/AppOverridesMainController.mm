#import "AppOverridesMainController.h"

typedef enum PSCellType {
	PSGroupCell,
	PSLinkCell,
	PSLinkListCell,
	PSListItemCell,
	PSTitleValueCell,
	PSSliderCell,
	PSSwitchCell,
	PSStaticTextCell,
	PSEditTextCell,
	PSSegmentCell,
	PSGiantIconCell,
	PSGiantCell,
	PSSecureEditTextCell,
	PSButtonCell,
	PSEditTextViewCell,
} PSCellType;

@implementation AppOverridesMainController
	/*- (id)specifiers{
		_dataSource = [[ALApplicationTableDataSource alloc] init];
		_dataSource.sectionDescriptors = [ALApplicationTableDataSource standardSectionDescriptors];
		_dataSource.loadsAsynchronously = NO;
		
		return nil;
	}
	
	- (void)viewDidLoad
	{
		[super viewDidLoad];
		_table.dataSource=_dataSource;
		_dataSource.tableView=_table;
	}*/
@end