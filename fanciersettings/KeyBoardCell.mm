#import "KeyBoardCell.h"

@implementation KeyBoardCell
	- (id)initWithSpecifier:(PSSpecifier *)specifier{
	    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"keyCell" specifier:specifier];
	    if (self) {
			self.autoresizingMask = UIViewAutoresizingFlexibleHeight;
			self.clipsToBounds = YES;
			
			CGRect frame=[self frame];
			
			_keyboard=[[UIInputView alloc] initWithFrame:CGRectMake(frame.origin.x,frame.origin.y+22,frame.size.width,frame.size.height) inputViewStyle:UIInputViewStyleDefault];
			for (UIView *ii in [_keyboard subviews]){
				NSLog(@"--- %@",ii);
			}
			
			for (CALayer *zz in [_keyboard.layer sublayers]){
				NSLog(@"..... %@",zz);
			}
			
			[_keyboard setAlpha:1];
			[_keyboard setHidden:NO];
			//[UIInputView appearanceWhenContainedIn:[self class], nil];

			
			//_keyboard = [[UIKeyboard alloc] initWithFrame:CGRectMake(frame.origin.x,frame.origin.y+22,frame.size.width,frame.size.height)];
			//[_keyboard _setRenderConfig:[objc_getClass("UIKBRenderConfig") defaultConfig]];
			[self addSubview:_keyboard];
			//[_keyboard activate];
		}

		return self;
	}

	- (float)preferredHeightForWidth:(float)arg1{
	    return 238.f;
	}
@end
