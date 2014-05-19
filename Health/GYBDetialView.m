//
//  GYBDetialView.m
//  TableView
//
//  Created by Mac on 5/17/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import "GYBDetialView.h"
#import "DPMeterView.h"
#import "UIBezierPath+BasicShapes.h"

@implementation GYBDetialView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (NSArray *)shapeViews
{
    NSMutableArray *shapeViews = [NSMutableArray array];
    
    if (self.statusView && [self.statusView isKindOfClass:[DPMeterView class]])
            [shapeViews addObject:self.statusView];
    
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

- (void)updateProgressWithDelta:(CGFloat)delta animated:(BOOL)animated
{
    NSArray *shapeViews = [self shapeViews];
    for (DPMeterView *shapeView in shapeViews) {
            if (delta < 0) {
                                [shapeView minus:fabs(delta) animated:animated];
                            }
            else {
                                [shapeView add:fabs(delta) animated:animated];
                            }
    }
    
    //    self.title = [NSString stringWithFormat:@"%.2f%%",
    //                                [(DPMeterView *)[shapeViews lastObject] progress]*100];
}
@end
