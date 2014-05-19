//
//  SecondViewController.h
//  Health
//
//  Created by GeoBeans on 14-5-14.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController{
    float searchbarY;
}

@property (retain, nonatomic) IBOutlet UITableView *tableView;

@property (retain, nonatomic) IBOutlet UISearchBar *searchbar;

@property (retain, nonatomic) IBOutlet UINavigationBar *navigationbar;



- (void)followScrollView:(UIView*)scrollableView;
@end
