//#import "KeyBoardCell.mm"
#import "common.h"

@interface TableViewCell : PSTableCell <UITableViewDataSource, UITableViewDelegate>{
	UITableView *_tableView;
	UIColor *_cellBackgroundColor;
	UIColor *_cellTextColor;
}
@end