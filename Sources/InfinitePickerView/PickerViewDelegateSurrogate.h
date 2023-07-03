#import <UIKit/UIKit.h>
#import "InfinitePickerViewDelegate.h"

@interface PickerViewDelegateSurrogate : NSObject <InfinitePickerViewDelegate>

@property (weak, nonatomic) id<InfinitePickerViewDelegate> pickerViewDelegate;

@end
