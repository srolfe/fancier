#import "ColorPickerCell.h"

@implementation ColorPickerCell
	- (id)initWithStyle:(long long)arg1 reuseIdentifier:(id)arg2 specifier:(id)arg3{
	    self = [super initWithStyle:arg1 reuseIdentifier:arg2 specifier:arg3];
	    if (self) {
			[self setIsFancierInstance:YES];
			CGRect frame=[self frame];
			frame.origin.y=44;
			frame.size.height=256;
			
			_pickerView=[[UIView alloc] initWithFrame:frame];
			_pickerIm=[[UIImage alloc] initWithContentsOfFile:[[NSBundle bundleWithPath:@"/Library/PreferenceBundles/FancierSettings.bundle"] pathForResource:@"picker" ofType:@"png"]];
			_picker=[[pickerView alloc] initWithImage:_pickerIm];
			[_picker setDelegate:self];
			[_picker setUserInteractionEnabled:YES];
			[_pickerView addSubview:_picker];
			
			[self addSubview:_pickerView];
			
			[[self textField] addTarget:self action:@selector(textFieldDidEdit:) forControlEvents:UIControlEventEditingChanged];
			
			self.autoresizingMask = UIViewAutoresizingFlexibleHeight;
			self.clipsToBounds = YES;
		}
		
		return self;
	}
	
	- (void)didUpdateColor:(UIColor *)color{
	    const CGFloat *components = CGColorGetComponents(color.CGColor);
	    CGFloat r = components[0];
	    CGFloat g = components[1];
	    CGFloat b = components[2];
		
		/*if (((0.2126*(r*255)) + (0.7152*(g*255)) + (0.0722*(b*255)))<100){
			textField.layer.shadowOpacity=0.25;
		}else{
			textField.layer.shadowOpacity=0.8;
		}*/
		
		[((UITextField *) [self textField]) setText:[NSString stringWithFormat:@"#%02X%02X%02X", (int)lroundf(r * 255), (int)lroundf(g * 255), (int)lroundf(b * 255)]];
		[[self textField] setTextColor:color];
		[self _setValueChanged];
	}
	
	-(void)textFieldDidEdit:(UITextField *)textField{
		if ([textField.text stringByReplacingOccurrencesOfString:@"#" withString:@""].length>=6){
			unsigned int hexInt = 0;
			NSScanner *scanner = [NSScanner scannerWithString:textField.text];
			[scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
			[scanner scanHexInt:&hexInt];

			UIColor *color=UIColorFromRGB(hexInt);
			[self didUpdateColor:color];
		}
	}
	
	- (void)isPicking:(BOOL)picking{
		UITableView *table=((UITableView *)[[self superview] performSelector:@selector(superview)]);
		table.scrollEnabled=!picking;
	}
	
	- (void)layoutSubviews{
		[super layoutSubviews];
		
		UILabel *titleLabel=[self titleLabel];
		CGRect newFrame = titleLabel.frame;
		newFrame.origin.y = newFrame.origin.x-4;
		[titleLabel setFrame:newFrame];
		
		UITextField *textField=[self textField];
		CGRect tFrame = textField.frame;
		tFrame.origin.x=self.frame.size.width-100;
		tFrame.size.width=75;
		tFrame.origin.y=newFrame.origin.y+1;
		[textField setFrame:tFrame];
		
		if (((UITextField *)[self textField]).text.length>0){
			[self textFieldDidEdit:[self textField]];
		}
	}
@end