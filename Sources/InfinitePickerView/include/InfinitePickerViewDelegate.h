#import <UIKit/UIKit.h>

@class InfinitePickerView;

/**
 The delegate of a InfinitePickerView object must adopt this protocol. It extends the `UIPickerViewDelegate` protocol.
 */
@protocol InfinitePickerViewDelegate<UIPickerViewDelegate>

@optional
/**
 Tells the picker view if the infinite scroll feature is enable for a picker component.

 @param pickerView An object representing the picker view requesting the data.
 @param component A zero-indexed number identifying a component of pickerView. Components are numbered left-to-right.
 @return true to enable the infinite scroll feature, otherwise false.
 */
- (BOOL)pickerView:(InfinitePickerView *)pickerView isInfiniteScrollEnabledInComponent:(NSInteger)component;

@end
