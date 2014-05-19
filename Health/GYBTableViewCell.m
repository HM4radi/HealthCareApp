//
//  GYBTableViewCell.m
//  TableView
//
//  Created by Mac on 5/17/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import "GYBTableViewCell.h"
#import "DPMeterView.h"
#import "UIBezierPath+BasicShapes.h"

@implementation GYBTableViewCell




- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)locateInMap:(id)sender {
}

- (void)updateProgressWithDelta:(CGFloat)delta animated:(BOOL)animated
{
    NSArray *shapeViews = [self shapeViews];
    for (DPMeterView *shapeView in shapeViews) {
        if (delta < 0) {
            [shapeView minus:fabs(delta) animated:animated];
        } else {
            [shapeView add:fabs(delta) animated:animated];
        }
    }
    
//    self.title = [NSString stringWithFormat:@"%.2f%%",
//                  [(DPMeterView *)[shapeViews lastObject] progress]*100];
}

- (NSArray *)shapeViews
{
    NSMutableArray *shapeViews = [NSMutableArray array];
    
    if (self.statueView && [self.statueView isKindOfClass:[DPMeterView class]])
        [shapeViews addObject:self.statueView];
    
    //    if (self.shape2View && [self.shape2View isKindOfClass:[DPMeterView class]])
    //        [shapeViews addObject:self.shape2View];
    //
    //    if (self.shape3View && [self.shape3View isKindOfClass:[DPMeterView class]])
    //        [shapeViews addObject:self.shape3View];
    //
    //    if (self.shape4View && [self.shape4View isKindOfClass:[DPMeterView class]])
    //        [shapeViews addObject:self.shape4View];
    //
    //    if (self.shape5View && [self.shape5View isKindOfClass:[DPMeterView class]])
    //        [shapeViews addObject:self.shape5View];
    
    return [NSArray arrayWithArray:shapeViews];
}
@end
