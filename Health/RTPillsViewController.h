//
//  RTPillsViewController.h
//  Health
//
//  Created by GeoBeans on 14-5-27.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTPillsTableViewCell.h"

@interface RTPillsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>{
    int cellNum;
    NSMutableArray *recordArray;
    NSArray *hour;
    NSArray *minite;
    NSString *currentName;
    NSString *currentNum;
    NSString *currentBeforeAfter;
    NSString *currentHour;
    NSString *currentMinute;
}

@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIView *addView;

@property (weak, nonatomic) IBOutlet UIPickerView *pickView;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *numField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *beforeAfter;
@property (weak, nonatomic) IBOutlet UINavigationBar *addNavBar;
@property (weak, nonatomic) IBOutlet UILabel *navLabel1;
@property (weak, nonatomic) IBOutlet UILabel *navLabel2;

@end
