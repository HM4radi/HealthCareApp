//
//  GYBTableViewCell.h
//  TableView
//
//  Created by Mac on 5/17/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPMeterView.h"
#import "UIBezierPath+BasicShapes.h"


@interface GYBTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *portait;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property CGFloat *statueValue;


@property (strong, nonatomic)IBOutlet DPMeterView *statueView;
- (IBAction)locateInMap:(id)sender;

- (void)updateProgressWithDelta:(CGFloat)delta animated:(BOOL)animated;

@end
