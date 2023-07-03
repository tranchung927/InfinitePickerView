#import "InfinitePickerView.h"
#import "PickerViewDataSourceSurrogate.h"
#import "PickerViewDelegateSurrogate.h"

@interface InfinitePickerView()

@property (strong, nonatomic) PickerViewDataSourceSurrogate * dataSourceSurrogate;
@property (strong, nonatomic) PickerViewDelegateSurrogate * delegateSurrogate;

@end

@implementation InfinitePickerView

- (void)didMoveToWindow
{
    [super didMoveToWindow];
    for (int i = 0; i < [self numberOfComponents]; i++) {
        NSInteger selectedRow = [self selectedRowInComponent:i];
        [self selectRow:selectedRow inComponent:i animated:NO];
    }
}

- (NSInteger)normalizedRowForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSInteger numberOfRowsInComponent = [self numberOfRowsInComponent:component];
    if (numberOfRowsInComponent <= 0) {
        return row;
    }
    
    NSInteger rowOffset = [self.dataSourceSurrogate pickerView:self rowOffsetForComponent:component];
    NSInteger normalizedRow = (row - rowOffset) % numberOfRowsInComponent;
    if (normalizedRow < 0) {
        normalizedRow += numberOfRowsInComponent;
    }
    return normalizedRow;
}

- (NSInteger)numberOfRowsInComponent:(NSInteger)component
{
    if([self isInfiniteScrollEnabledInComponent:component]) {
        NSInteger rowOffset = [self.dataSourceSurrogate pickerView:self rowOffsetForComponent:component];
        return [super numberOfRowsInComponent:component] - 2 * rowOffset;
    }

    return [super numberOfRowsInComponent:component];
}

- (UIView *)viewForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if([self isInfiniteScrollEnabledInComponent:component]) {
        return [super viewForRow:[self normalizedRowForRow:row forComponent:component] forComponent:component];
    }

    return [super viewForRow:row forComponent:component];
}

- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated
{
    if([self isInfiniteScrollEnabledInComponent:component]) {
        NSInteger rowOffset = [self.dataSourceSurrogate pickerView:self rowOffsetForComponent:component];
        [super selectRow:row + rowOffset inComponent:component animated:animated];
        return;
    }

    [super selectRow:row inComponent:component animated:animated];
}

- (NSInteger)selectedRowInComponent:(NSInteger)component
{
    NSInteger row = [super selectedRowInComponent:component];
    if([self isInfiniteScrollEnabledInComponent:component]) {
        return [self normalizedRowForRow:row forComponent:component];
    }
    return row;
}

- (BOOL)isInfiniteScrollEnabledInComponent:(NSInteger)component
{
    if([self.delegate respondsToSelector:@selector(pickerView:isInfiniteScrollEnabledInComponent:)]) {
        return [self.delegate pickerView:self isInfiniteScrollEnabledInComponent:component];
    }
    return YES;
}

- (void)setDataSource:(id<UIPickerViewDataSource>)dataSource
{
    PickerViewDataSourceSurrogate * surrogate = [[PickerViewDataSourceSurrogate alloc] init];
    surrogate.pickerViewDataSource = dataSource;
    [super setDataSource:surrogate];
    self.dataSourceSurrogate = surrogate;
}

- (id<InfinitePickerViewDelegate>)delegate
{
    return (id<InfinitePickerViewDelegate>)[super delegate];
}

- (void)setDelegate:(id<InfinitePickerViewDelegate>)delegate
{
    PickerViewDelegateSurrogate * surrogate = [[PickerViewDelegateSurrogate alloc] init];
    surrogate.pickerViewDelegate = delegate;
    [super setDelegate:surrogate];
    self.delegateSurrogate = surrogate;
}

@end
