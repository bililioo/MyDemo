//
//  ViewController.m
//  ContactsDemo
//
//  Created by Bin on 2018/1/7.
//  Copyright © 2018年 Orz. All rights reserved.
//

#import "ViewController.h"
#import <AddressBookUI/AddressBookUI.h>
#import <AddressBook/AddressBook.h>

@interface ViewController () <ABPeoplePickerNavigationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    ABPeoplePickerNavigationController *pvc = [[ABPeoplePickerNavigationController alloc] init];
    
    pvc.peoplePickerDelegate = self;
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined)
    {
        ABAddressBookRef bookRef = ABAddressBookCreate();
        ABAddressBookRequestAccessWithCompletion(bookRef, ^(bool granted, CFErrorRef error) {
            if (granted)
            {
                NSLog(@"授权成功!");
                [self presentViewController:pvc animated:YES completion:nil];
            }
            else
            {
                NSLog(@"授权失败!");
            }
        });
    }
    else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized)
    {
        [self presentViewController:pvc animated:YES completion:nil];
    }
    
}

// 选择某个联系人时调用
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person
{
    NSLog(@"选中联系人");
    CFStringRef firstName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
    CFStringRef lastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
    
    NSString *fir = CFBridgingRelease(firstName);
    NSString *las = CFBridgingRelease(lastName);
    
    NSLog(@"%@---%@", fir, las);
    
    ABMultiValueRef multi = ABRecordCopyValue(person, kABPersonPhoneProperty);
    CFIndex count = ABMultiValueGetCount(multi);
    for (int i = 0; i  < count; i++)
    {
        NSString *label = (__bridge_transfer NSString *)ABMultiValueCopyLabelAtIndex(multi, i);
        NSString *phone =(__bridge_transfer NSString *)  ABMultiValueCopyValueAtIndex(multi, i);
        NSLog(@"%@---%@", label, phone);
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
