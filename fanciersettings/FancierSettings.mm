#import "common.h"
#import "ColorPickerCell.h"
#import "GlobalSettingsController.h"
#import "HeaderCell.h"
#import "KeyBoardCell.h"
#import "NavBarCell.h"
#import "pickerView.h"
#import "TabBarCell.h"
#import <objc/runtime.h>
//#import <QuartzCore/QuartzCore.h>

// Main screen controller
@interface FancierSettingsListController: PSListController {
}
@end

@implementation FancierSettingsListController
	- (id)specifiers {
		if(_specifiers == nil) {
			_specifiers = [[self loadSpecifiersFromPlistName:@"FancierSettings" target:self] retain];
			
			[((UITableView *)[self table]) setIsFancierInstance:YES];
			[((UITableView *)[self table]) setBackgroundColor:[UIColor colorWithRed:0.937255 green:0.937255 blue:0.956863 alpha:1]];
			[((UITableView *)[self table]) setSeparatorColor:[UIColor colorWithRed:0.783922 green:0.780392 blue:0.8 alpha:1]];
		}
		return _specifiers;
	}
	
	- (id)tableView:(id)arg1 viewForHeaderInSection:(long long)arg2{
		id tmp=[super tableView:arg1 viewForHeaderInSection:arg2];
		
		[((UITableViewCell *) tmp) setIsFancierInstance:YES];
		[((UITableViewCell *) tmp) setBackgroundColor:[UIColor colorWithRed:0.937255 green:0.937255 blue:0.956863 alpha:1]];
		
		return tmp;
	}
	
	- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2{
		UITableViewCell *tmp=(UITableViewCell *)[super tableView:arg1 cellForRowAtIndexPath:arg2];
		[tmp setIsFancierInstance:YES];
		[tmp setBackgroundColor:[UIColor whiteColor]];
		[tmp.textLabel setTextColor:[UIColor blackColor]];
		return tmp;
	}
@end