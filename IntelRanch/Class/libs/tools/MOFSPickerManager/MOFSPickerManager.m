//
//  MOFSPickerManager.m
//  MOFSPickerManager
//
//  Created by luoyuan on 16/8/26.
//  Copyright © 2016年 luoyuan. All rights reserved.
//

#import "MOFSPickerManager.h"

@implementation MOFSPickerManager

+ (MOFSPickerManager *)shareManger {
    static MOFSPickerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [self new];
    });
    return  manager;
}

- (MOFSDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [MOFSDatePicker new];
    }
    return _datePicker;
}

- (MOFSPickerView *)pickView {
    if (!_pickView) {
        _pickView = [MOFSPickerView new];
    }
    return _pickView;
}

//- (MOFSAddressPickerView *)addressPicker {
//    if (!_addressPicker) {
//        _addressPicker = [MOFSAddressPickerView new];
//    }
//    return _addressPicker;
//}

// ================================DatePicker===================================//

- (void)showDatePickerWithTag:(NSInteger)tag commitBlock:(DatePickerCommitBlock)commitBlock cancelBlock:(DatePickerCancelBlock)cancelBlock {
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    
    self.datePicker.toolBar.titleBarTitle = @"";
    self.datePicker.toolBar.cancelBarTitle = @"取消";
    self.datePicker.toolBar.commitBarTitle = @"确定";
    
    self.datePicker.minimumDate = nil;
    self.datePicker.maximumDate = nil;
    [self.datePicker showMOFSDatePickerViewWithTag:tag firstDate:nil commit:^(NSDate *date) {
        if (commitBlock) {
            commitBlock(date);
        }
    } cancel:^{
        if (cancelBlock) {
            cancelBlock();
        }
    }];
}

- (void)showDatePickerWithTag:(NSInteger)tag datePickerMode:(UIDatePickerMode)mode commitBlock:(DatePickerCommitBlock)commitBlock cancelBlock:(DatePickerCancelBlock)cancelBlock {
    self.datePicker.datePickerMode = mode;
    
    self.datePicker.toolBar.titleBarTitle = @"";
    self.datePicker.toolBar.cancelBarTitle = @"取消";
    self.datePicker.toolBar.commitBarTitle = @"确定";
    
    self.datePicker.minimumDate = nil;
    self.datePicker.maximumDate = nil;
    [self.datePicker showMOFSDatePickerViewWithTag:tag firstDate:nil commit:^(NSDate *date) {
        if (commitBlock) {
            commitBlock(date);
        }
    } cancel:^{
        if (cancelBlock) {
            cancelBlock();
        }
    }];
}

- (void)showDatePickerWithTag:(NSInteger)tag title:(NSString *)title cancelTitle:(NSString *)cancelTitle commitTitle:(NSString *)commitTitle datePickerMode:(UIDatePickerMode)mode commitBlock:(DatePickerCommitBlock)commitBlock cancelBlock:(DatePickerCancelBlock)cancelBlock {
    self.datePicker.datePickerMode = mode;
    
    self.datePicker.toolBar.titleBarTitle = title;
    self.datePicker.toolBar.cancelBarTitle = cancelTitle;
    self.datePicker.toolBar.commitBarTitle = commitTitle;
    
    self.datePicker.minimumDate = nil;
    self.datePicker.maximumDate = nil;
    [self.datePicker showMOFSDatePickerViewWithTag:tag firstDate:nil commit:^(NSDate *date) {
        if (commitBlock) {
            commitBlock(date);
        }
    } cancel:^{
        if (cancelBlock) {
            cancelBlock();
        }
    }];
}

- (void)showDatePickerWithTag:(NSInteger)tag firstDate:(NSDate *)firstDate minDate:(NSDate *)minDate maxDate:(NSDate *)maxDate datePickerMode:(UIDatePickerMode)mode commitBlock:(DatePickerCommitBlock)commitBlock cancelBlock:(DatePickerCancelBlock)cancelBlock {
    self.datePicker.datePickerMode = mode;
    
    self.datePicker.toolBar.titleBarTitle = @"";
    self.datePicker.toolBar.cancelBarTitle = @"取消";
    self.datePicker.toolBar.commitBarTitle = @"确定";
    
    self.datePicker.minimumDate = minDate;
    self.datePicker.maximumDate = maxDate;
    
    [self.datePicker showMOFSDatePickerViewWithTag:tag firstDate:firstDate commit:^(NSDate *date) {
        if (commitBlock) {
            commitBlock(date);
        }
    } cancel:^{
        if (cancelBlock) {
            cancelBlock();
        }
    }];
}


- (void)showDatePickerWithTitle:(NSString *)title cancelTitle:(NSString *)cancelTitle commitTitle:(NSString *)commitTitle firstDate:(NSDate *)firstDate minDate:(NSDate *)minDate maxDate:(NSDate *)maxDate datePickerMode:(UIDatePickerMode)mode tag:(NSInteger)tag commitBlock:(DatePickerCommitBlock)commitBlock cancelBlock:(DatePickerCancelBlock)cancelBlock {
    self.datePicker.datePickerMode = mode;
    
    self.datePicker.toolBar.titleBarTitle = title;
    self.datePicker.toolBar.cancelBarTitle = cancelTitle;
    self.datePicker.toolBar.commitBarTitle = commitTitle;
    
    self.datePicker.minimumDate = minDate;
    self.datePicker.maximumDate = maxDate;
    
    [self.datePicker showMOFSDatePickerViewWithTag:tag firstDate:firstDate commit:^(NSDate *date) {
        if (commitBlock) {
            commitBlock(date);
        }
    } cancel:^{
        if (cancelBlock) {
            cancelBlock();
        }
    }];
}

// ================================pickerView===================================//

- (void)showPickerViewWithDataArray:(NSArray *)array tag:(NSInteger)tag title:(NSString *)title cancelTitle:(NSString *)cancelTitle commitTitle:(NSString *)commitTitle commitBlock:(PickerViewCommitBlock)commitBlock cancelBlock:(PickerViewCancelBlock)cancelBlock {
    
    self.pickView.showTag = tag;
    self.pickView.toolBar.titleBarTitle = title;
    self.pickView.toolBar.cancelBarTitle = cancelTitle;
    self.pickView.toolBar.commitBarTitle = commitTitle;
    [self.pickView showMOFSPickerViewWithDataArray:array commitBlock:^(NSString *string) {
        if (commitBlock) {
            commitBlock(string);
        }
    } cancelBlock:^{
        if (cancelBlock) {
            cancelBlock();
        }
    }];
    
}

////===============================addressPicker===================================//
//
//- (void)showMOFSAddressPickerWithTitle:(NSString *)title cancelTitle:(NSString *)cancelTitle commitTitle:(NSString *)commitTitle commitBlock:(void(^)(NSString *address, NSString *zipcode))commitBlock cancelBlock:(void(^)())cancelBlock {
//    self.addressPicker.toolBar.titleBarTitle = title;
//    self.addressPicker.toolBar.cancelBarTitle = cancelTitle;
//    self.addressPicker.toolBar.commitBarTitle = commitTitle;
//    [self.addressPicker showMOFSAddressPickerCommitBlock:^(NSString *address, NSString *zipcode) {
//        if (commitBlock) {
//            commitBlock(address, zipcode);
//        }
//    } cancelBlock:^{
//        if (cancelBlock) {
//            cancelBlock();
//        }
//    }];
//}
//
//- (void)showMOFSAddressPickerWithDefaultAddress:(NSString *)address numberOfComponents:(NSInteger)numberOfComponents title:(NSString *)title cancelTitle:(NSString *)cancelTitle commitTitle:(NSString *)commitTitle commitBlock:(void (^)(NSString *, NSString *))commitBlock cancelBlock:(void (^)())cancelBlock {
//    self.addressPicker.componentNumber = numberOfComponents;
//    self.addressPicker.toolBar.titleBarTitle = title;
//    self.addressPicker.toolBar.cancelBarTitle = cancelTitle;
//    self.addressPicker.toolBar.commitBarTitle = commitTitle;
//    
//    [self.addressPicker showMOFSAddressPickerCommitBlock:^(NSString *address, NSString *zipcode) {
//        if (commitBlock) {
//            commitBlock(address, zipcode);
//        }
//    } cancelBlock:^{
//        if (cancelBlock) {
//            cancelBlock();
//        }
//    }];
//    
//    if (address == nil || [address isEqualToString:@""]) {
//        return;
//    }
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self searchIndexByAddress:address block:^(NSString *address) {
//            if (![address containsString:@"error"]) {
//                NSArray *indexArr = [address componentsSeparatedByString:@"-"];
//                for (int i = 0; i < indexArr.count; i++) {
//                    @try {
//                        
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            if (i < self.addressPicker.numberOfComponents) {
//                                
//                                [self.addressPicker selectRow:[indexArr[i] integerValue] inComponent:i animated:NO];
//                            }
//                            
//                            
//                            if (i < indexArr.count - 1) {
//                                
//                                if (i + 1 < self.addressPicker.numberOfComponents) {
//                                    [self.addressPicker reloadComponent:i + 1];
//                                }
//                                
//                            }
//                        });
//                        
//                    } @catch (NSException *exception) {
//                        
//                    } @finally {
//                        
//                    }
//                    
//                }
//            }
//        }];
//
//    });
//    
//    
//}
//
//- (void)showMOFSAddressPickerWithDefaultZipcode:(NSString *)zipcode numberOfComponents:(NSInteger)numberOfComponents title:(NSString *)title cancelTitle:(NSString *)cancelTitle commitTitle:(NSString *)commitTitle commitBlock:(void (^)(NSString *, NSString *))commitBlock cancelBlock:(void (^)())cancelBlock {
//    self.addressPicker.componentNumber = numberOfComponents;
//    self.addressPicker.toolBar.titleBarTitle = title;
//    self.addressPicker.toolBar.cancelBarTitle = cancelTitle;
//    self.addressPicker.toolBar.commitBarTitle = commitTitle;
//    
//    [self.addressPicker showMOFSAddressPickerCommitBlock:^(NSString *address, NSString *zipcode) {
//        if (commitBlock) {
//            commitBlock(address, zipcode);
//        }
//    } cancelBlock:^{
//        if (cancelBlock) {
//            cancelBlock();
//        }
//    }];
//    
//    if (zipcode == nil || [zipcode isEqualToString:@""]) {
//        return;
//    }
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self searchIndexByZipCode:zipcode block:^(NSString *address) {
//            if (![address containsString:@"error"]) {
//                NSArray *indexArr = [address componentsSeparatedByString:@"-"];
//                for (int i = 0; i < indexArr.count; i++) {
//                    @try {
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            if (i < self.addressPicker.numberOfComponents) {
//                                
//                                [self.addressPicker selectRow:[indexArr[i] integerValue] inComponent:i animated:NO];
//                            }
//                            
//                            
//                            if (i < indexArr.count - 1) {
//                                
//                                if (i + 1 < self.addressPicker.numberOfComponents) {
//                                    [self.addressPicker reloadComponent:i + 1];
//                                }
//                                
//                            }
//                            
//                        });
//                    } @catch (NSException *exception) {
//                        
//                    } @finally {
//                        
//                    }
//                    
//                }
//            }
//        }];
//
//    });
//    
//    
//}
//
//- (void)searchAddressByZipcode:(NSString *)zipcode block:(void(^)(NSString *address))block {
//    [self.addressPicker searchType:SearchTypeAddress key:zipcode block:^(NSString *result) {
//        if (block) {
//            block(result);
//        }
//    }];
//}
//
//- (void)searchZipCodeByAddress:(NSString *)address block:(void(^)(NSString *zipcode))block {
//    [self.addressPicker searchType:SearchTypeZipcode key:address block:^(NSString *result) {
//        if (block) {
//            block(result);
//        }
//    }];
//}
//
//- (void)searchIndexByAddress:(NSString *)address block:(void(^)(NSString *address))block {
//    [self.addressPicker searchType:SearchTypeAddressIndex key:address block:^(NSString *result) {
//        if (block) {
//            block(result);
//        }
//    }];
//}
//
//- (void)searchIndexByZipCode:(NSString *)zipcode block:(void (^)(NSString *))block {
//    [self.addressPicker searchType:SearchTypeZipcodeIndex key:zipcode block:^(NSString *result) {
//        if (block) {
//            block(result);
//        }
//    }];
//}

@end
