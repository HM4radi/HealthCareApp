//
//  RTHumanBodySearchView.h
//  Health
//
//  Created by Mac on 5/28/14.
//  Copyright (c) 2014 RADI Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTHumanBodySearchView: UIView <UITableViewDelegate,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *searchResultView;
@property (strong, nonatomic) IBOutlet UILabel *scopeThemeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *Background;

@end
