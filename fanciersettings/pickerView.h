//#import "pickerView.mm"

@protocol pickerViewDelegate;

@interface pickerView : UIImageView{
	const UInt8 *pData;
	int pWidth;
	int pHeight;
}
	@property (nonatomic, retain) id<pickerViewDelegate> delegate;
	- (UIColor *)pickerGetColorAtPoint:(CGPoint)point;
@end
	
@protocol pickerViewDelegate <NSObject>
	- (void)didUpdateColor:(UIColor *)color;
	- (void)isPicking:(BOOL)picking;
@end