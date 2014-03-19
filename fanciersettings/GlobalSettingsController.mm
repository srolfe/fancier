#import "GlobalSettingsController.h"

@implementation GlobalSettingsController
	- (id)specifiers {
		if(_specifiers == nil) {
			_specifiers = [[self loadSpecifiersFromPlistName:@"FancierGlobalSettings" target:self] retain];
		}
		
		UITableView *globalTable=[self table];
		[globalTable setIsFancierInstance:YES];
		[globalTable setBackgroundColor:[UIColor colorWithRed:0.937255 green:0.937255 blue:0.956863 alpha:1]];
		[globalTable setSeparatorColor:[UIColor colorWithRed:0.783922 green:0.780392 blue:0.8 alpha:1]];
		
		return _specifiers;
	}
	
	- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
		if (selectedRow!=nil && (indexPath.row == selectedRow.row && indexPath.section == selectedRow.section)){
			selectedRow=nil;
			//NSIndexPath *pp=[NSIndexPath indexPathForRow:0 inSection:indexPath.section];
			[tableView reloadData];
			//[tableView scrollToRowAtIndexPath:pp atScrollPosition:UITableViewScrollPositionTop animated:YES];
		}else{
			selectedRow=[indexPath copy];
			[tableView reloadData];
		}
	}
	
	- (id)tableView:(id)arg1 viewForHeaderInSection:(long long)arg2{
		UITableViewCell *tmp=[super tableView:arg1 viewForHeaderInSection:arg2];
		[tmp setIsFancierInstance:YES];
		[tmp setBackgroundColor:[UIColor colorWithRed:0.937255 green:0.937255 blue:0.956863 alpha:1]];
		
		return tmp;
	}
	
	- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2{
		UITableViewCell *tmp=[super tableView:arg1 cellForRowAtIndexPath:arg2];
		
		// Force light-mode
		[tmp setIsFancierInstance:YES];
		[tmp setBackgroundColor:[UIColor whiteColor]];
		[tmp.textLabel setTextColor:[UIColor blackColor]];
		
		return tmp;
	}
	
	- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
		if (selectedRow!=nil && (indexPath.row == selectedRow.row && indexPath.section == selectedRow.section)){
			return 300.f;
		}else{
			return 44.f;
		}
	}
@end