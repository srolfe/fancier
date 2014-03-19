#import "TableViewCell.h"

@implementation TableViewCell
	- (id)initWithSpecifier:(PSSpecifier *)specifier{
	    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"navCell" specifier:specifier];
	    if (self) {
			CGRect frame=[self frame];
			frame.size.height=150;
			_tableView=[[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
			[_tableView setScrollEnabled:NO];
			[_tableView setContentOffset:CGPointMake(0,25)];
			[_tableView setDelegate:self];
			[_tableView setDataSource:self];
			[self addSubview:_tableView];
		}
		
		return self;
	}
	
	- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
		return 1;
	}
	
	- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
		return 2;
	}
	
	- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FancierSample"];
		
		if(cell == nil){
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FancierSample"];
		}
		
		cell.textLabel.text=@"Cell Label";
		
		return cell;
	}
	
	- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
		return @"Header";
	}
	
	- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
		return @"Footer";
	}
	
	- (float)preferredHeightForWidth:(float)arg1{
	    return 150.f;
	}
@end