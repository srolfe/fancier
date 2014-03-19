#import "pickerView.h"

@implementation pickerView
	@synthesize delegate;
	
	- (UIColor *)pickerGetColorAtPoint:(CGPoint)point{
		point.x=point.x*2;
		point.y=point.y*2;
		
		if (point.x>pWidth){point.x=pWidth;}
		if (point.y>=pHeight){point.y=pHeight-1.0;}
		if (point.x<0){point.x=0;}
		if (point.y<0){point.y=0;}
		
		if (pData == nil){
	    	CFDataRef pixelData = CGDataProviderCopyData(CGImageGetDataProvider([self.image CGImage]));
	    	pData = CFDataGetBytePtr(pixelData);
			pHeight = CGImageGetHeight([self.image CGImage]);
			pWidth = CGImageGetWidth([self.image CGImage]);
		}

	    int pixelInfo = ((pWidth  * point.y) + point.x ) * 4; // The image is png
	    return [UIColor colorWithRed:pData[pixelInfo]/255.0f green:pData[(pixelInfo + 1)]/255.0f blue:pData[(pixelInfo + 2)]/255.0f alpha:pData[(pixelInfo + 3)]/255.0f];
	}
	
	- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
		CGPoint touchLocation = [[touches anyObject] locationInView:self];
		[self.delegate didUpdateColor:[self pickerGetColorAtPoint:touchLocation]];
		[self.delegate isPicking:YES];
	}
	
	- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
		CGPoint touchLocation = [[touches anyObject] locationInView:self];
		//NSLog(@"%f, %f",touchLocation.x,touchLocation.y);
		[self.delegate didUpdateColor:[self pickerGetColorAtPoint:touchLocation]];
		
	}
	
	- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
		[self.delegate isPicking:NO];
	}
@end