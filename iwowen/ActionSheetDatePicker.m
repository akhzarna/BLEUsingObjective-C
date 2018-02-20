

#import "ActionSheetDatePicker.h"
#import <objc/message.h>

@interface ActionSheetDatePicker()
@property (nonatomic, assign) UIDatePickerMode datePickerMode;
@property (nonatomic, strong) NSDate *selectedDate;
@end

@implementation ActionSheetDatePicker
@synthesize selectedDate = _selectedDate;
@synthesize datePickerMode = _datePickerMode;

+ (id)showPickerWithTitle:(NSString *)title 
           datePickerMode:(UIDatePickerMode)datePickerMode selectedDate:(NSDate *)selectedDate                                                                             
                 target:(id)target action:(SEL)action origin:(id)origin {
    ActionSheetDatePicker *picker = [[ActionSheetDatePicker alloc] initWithTitle:title datePickerMode:datePickerMode selectedDate:selectedDate target:target action:action origin:origin];
    [picker showActionSheetPicker];
    return picker;
}

- (id)initWithTitle:(NSString *)title datePickerMode:(UIDatePickerMode)datePickerMode selectedDate:(NSDate *)selectedDate target:(id)target action:(SEL)action origin:(id)origin {
    self = [super initWithTarget:target successAction:action cancelAction:nil origin:origin];
    if (self) {
        self.title = title;
        self.datePickerMode = datePickerMode;
        self.selectedDate = selectedDate;
    }
    return self;
}


- (UIView *)configuredPickerView {
    CGRect datePickerFrame = CGRectMake(0, 40, self.viewSize.width, 216);
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:datePickerFrame];
    datePicker.datePickerMode = self.datePickerMode;
    [datePicker setDate:self.selectedDate animated:NO];
    [datePicker addTarget:self action:@selector(eventForDatePicker:) forControlEvents:UIControlEventValueChanged];
    
    //need to keep a reference to the picker so we can clear the DataSource / Delegate when dismissing (not used in this picker, but just in case somebody uses this as a template for another picker)
    self.pickerView = datePicker;
    
    return datePicker;
}

- (void)notifyTarget:(id)target didSucceedWithAction:(SEL)action origin:(id)origin {
    if ([target respondsToSelector:action])
        objc_msgSend(target, action, self.selectedDate, origin);
    else
        NSAssert(NO, @"Invalid target/action ( %s / %s ) combination used for ActionSheetPicker", object_getClassName(target), (char *)sel_getName(action));
}

- (void)eventForDatePicker:(id)sender {
    if (!sender || ![sender isKindOfClass:[UIDatePicker class]])
        return;
    UIDatePicker *datePicker = (UIDatePicker *)sender;
    self.selectedDate = datePicker.date;
}

- (void)customButtonPressed:(id)sender {
    UIBarButtonItem *button = (UIBarButtonItem*)sender;
    NSInteger index = button.tag;
    NSAssert((index >= 0 && index < self.customButtons.count), @"Bad custom button tag: %d, custom button count: %d", index, self.customButtons.count);    
    NSAssert([self.pickerView respondsToSelector:@selector(setDate:animated:)], @"Bad pickerView for ActionSheetDatePicker, doesn't respond to setDate:animated:");
    NSDictionary *buttonDetails = [self.customButtons objectAtIndex:index];
    NSDate *itemValue = [buttonDetails objectForKey:@"buttonValue"];
    UIDatePicker *picker = (UIDatePicker *)self.pickerView;    
    [picker setDate:itemValue animated:YES];
    [self eventForDatePicker:picker];
}

@end
