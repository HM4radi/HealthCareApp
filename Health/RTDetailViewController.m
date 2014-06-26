//
//  RTDetailViewController.m
//  Health
//
//  Created by GeoBeans on 14-6-17.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import "RTDetailViewController.h"

@interface RTDetailViewController ()

@end

@implementation RTDetailViewController
@synthesize myGraph;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewWillLayoutSubviews{
    [self.navBar setFrame:CGRectMake(0, 0, 320, 64)];
    self.navBar.translucent=YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

    planData=[RTPlanData shareInstance];
    
    if ([planData.sportType isEqualToString:@"跑步"]||[planData.sportType isEqualToString:@"步行"]||[planData.sportType isEqualToString:@"骑行"]) {
        if (!_mapView) {
            _mapView= [[RTMapView alloc] initWithFrame:CGRectMake(0, 64, 320, 264)];
            [self.view insertSubview:_mapView belowSubview:self.labelValues];
        }
        [self loadChartView];
        self.labelValues.hidden=YES;
    }else{
        if (!_mapView) {
            _mapView= [[RTMapView alloc] initWithFrame:CGRectMake(0, 64, 320, 354)];
            [self.view insertSubview:_mapView belowSubview:self.labelValues];
        }
        [self.myGraph removeFromSuperview];
        [self.labelValues removeFromSuperview];
        [self.infoView setFrame:CGRectMake(0, 418, 320, 100)];
        [self.view addSubview:self.infoView];
    }

    currentAnno=[[QPointAnnotation alloc]init];
    
    route=[_mapView convertToCoord2D:planData.routeCoord];
    if ([planData.routeCoord count]>1) {
        [_mapView addPolyline:route withcount:[planData.routeCoord count]];
    }else if ([planData.routeCoord count]==1){
        [self addPointAnno:route[0]];
        [_mapView setCenterCoord:route[0]];
    }
    
}

- (IBAction)touchBack:(id)sender {
    self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self dismissViewControllerAnimated:YES completion:nil];
}

//*********************chartView********************//

- (void)loadChartView{
    
    self.ArrayOfValues = [[NSMutableArray alloc] init];
    self.ArrayOfDates = [[NSMutableArray alloc] init];
    
    [self.view insertSubview:self.labelValues aboveSubview:self.myGraph];
    
    for (int i=0; i <[planData.routeCoord count]; i++) {
        [self.ArrayOfValues addObject:[NSNumber numberWithInteger:(20+rand()%30)]]; // Random values for the graph
        [self.ArrayOfDates addObject:[NSString stringWithFormat:@"%@",[NSNumber numberWithInt:i]]]; // Dates for the X-Axis of the graph
    }
    
    //BEMSimpleLineGraphView *myGraph = [[BEMSimpleLineGraphView alloc] initWithFrame:CGRectMake(0, 328, 320, 200)];
    myGraph.delegate = self;
    self.myGraph.frame=CGRectMake(0, 328, 320, 195);
    // Customization of the graph
    self.myGraph.enableTouchReport = YES;
    self.myGraph.colorTop = [UIColor colorWithRed:31.0/255.0 green:187.0/255.0 blue:166.0/255.0 alpha:1.0];
    self.myGraph.colorBottom = [UIColor colorWithRed:31.0/255.0 green:187.0/255.0 blue:166.0/255.0 alpha:1.0]; // Leaving this not-set on iOS 7 will default to your window's tintColor
    self.myGraph.colorLine = [UIColor yellowColor];
    self.myGraph.colorXaxisLabel = [UIColor whiteColor];
    self.myGraph.widthLine = 3.0;
    self.myGraph.enableTouchReport = YES;
    
}

#pragma mark - SimpleLineGraph Data Source

- (int)numberOfPointsInGraph {
    return (int)[self.ArrayOfValues count];
}

- (float)valueForIndex:(NSInteger)index {
    return [[self.ArrayOfValues objectAtIndex:index] floatValue];
}

#pragma mark - SimpleLineGraph Delegate

- (int)numberOfGapsBetweenLabels {
    return 1;
}

- (NSString *)labelOnXAxisForIndex:(NSInteger)index {
    return [self.ArrayOfDates objectAtIndex:index];
}

- (void)didTouchGraphWithClosestIndex:(int)index {
    self.labelValues.textColor=[UIColor yellowColor];
    self.labelValues.frame=CGRectMake(self.labelValues.frame.origin.x, 320, self.labelValues.frame.size.width, self.labelValues.frame.size.height);
    self.labelValues.hidden=NO;
    self.labelValues.text = [NSString stringWithFormat:@"%@KCal", [self.ArrayOfValues objectAtIndex:index]];
    
    if (index!=currentIndex) {
        [_mapView removePointAnno:currentAnno];
        [self addPointAnno:route[index]];
    }
    currentIndex=index;
}

- (void)didReleaseGraphWithClosestIndex:(float)index {
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.labelValues.alpha = 0.0;
        self.labelDates.alpha = 0.0;
    } completion:^(BOOL finished){
        self.labelValues.hidden=YES;
        self.labelValues.alpha = 1.0;
        self.labelDates.alpha = 1.0;
    }];
}

-(void)addPointAnno:(CLLocationCoordinate2D)point{
    
    [currentAnno setCoordinate:point];
    [currentAnno setTitle:@"途经点"];
    [_mapView addPointAnno:currentAnno];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
