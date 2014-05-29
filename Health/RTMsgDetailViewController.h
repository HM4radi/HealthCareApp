//
//  RTMsgDetailViewController.h
//  Health
//
//  Created by GeoBeans on 14-5-29.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTMsgDetailTableViewCell.h"
@interface RTMsgDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *msgArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;

@end
