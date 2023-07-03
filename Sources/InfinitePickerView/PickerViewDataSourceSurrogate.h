#import <UIKit/UIKit.h>

@interface PickerViewDataSourceSurrogate : NSObject <UIPickerViewDataSource>

@property (weak, nonatomic) id<UIPickerViewDataSource> pickerViewDataSource;

- (NSInteger)pickerView:(UIPickerView *)pickerView rowOffsetForComponent:(NSInteger)component;

@end
