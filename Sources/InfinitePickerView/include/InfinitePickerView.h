#import <UIKit/UIKit.h>
#import "InfinitePickerViewDelegate.h"
/**
 `UIPickerView` subclass which enables endless scrolling (like UIDatePicker).
*/
@interface InfinitePickerView : UIPickerView

/**
 The delegate for the picker view.
 */
@property(nullable,nonatomic,weak) id<InfinitePickerViewDelegate> delegate;

/**
 Returns the information if infinite scrolling is enable for a component.

 @param component A zero-indexed number identifying a component of the picker view.
 @return true if infinite scroll is enable, otherwise false.
 */
- (BOOL)isInfiniteScrollEnabledInComponent:(NSInteger)component;

@end
