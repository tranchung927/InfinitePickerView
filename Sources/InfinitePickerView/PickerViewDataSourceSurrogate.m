#import "PickerViewDataSourceSurrogate.h"
#import "InfinitePickerView+Private.h"

NSInteger const kInfinitePickerViewRowOffset = 1000;

@implementation PickerViewDataSourceSurrogate

- (NSInteger)pickerView:(UIPickerView *)pickerView rowOffsetForComponent:(NSInteger)component {
    NSInteger numberOfRowsInComponent = [self.pickerViewDataSource pickerView:pickerView numberOfRowsInComponent:component];
    if (numberOfRowsInComponent <= 0) {
        return kInfinitePickerViewRowOffset;
    }
    return ((kInfinitePickerViewRowOffset / numberOfRowsInComponent) + 1) * numberOfRowsInComponent;
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return [self.pickerViewDataSource numberOfComponentsInPickerView:pickerView];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ([pickerView isKindOfClass:[InfinitePickerView class]]) {
        InfinitePickerView *infinitePickerView = (InfinitePickerView *)pickerView;
        if([infinitePickerView isInfiniteScrollEnabledInComponent:component]) {
            NSInteger numberOfRowsInComponent = [self.pickerViewDataSource pickerView:pickerView numberOfRowsInComponent:component];
            return [self pickerView:pickerView rowOffsetForComponent:component] * 2 + numberOfRowsInComponent;
        }
    }
    return [self.pickerViewDataSource pickerView:pickerView numberOfRowsInComponent:component];
}

@end
