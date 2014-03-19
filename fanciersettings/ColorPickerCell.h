//#import
#import "pickerView.h"
#import "common.h"
#import "GlobalSettingsController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ColorPickerCell : PSEditableTableCell <pickerViewDelegate>{
	UIView *_pickerView;
	UIImage *_pickerIm;
	pickerView *_picker;
}
@end