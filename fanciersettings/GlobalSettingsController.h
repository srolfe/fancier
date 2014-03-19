//#import "GlobalSettingsController.mm"
#import "common.h"
#import "NavBarCell.h"
#import "TabBarCell.h"
#import "ColorPickerCell.h"
#import "TableViewCell.h"

@interface UIView (Fancier)
	@property (nonatomic) BOOL isFancierInstance;
@end

	/*@interface UITableView (Fancier)
	- (void)didReceiveUpdate:(NSNotification *)notification;
@end*/

@interface GlobalSettingsController : PSListController{
	NSIndexPath *selectedRow;
}
@end