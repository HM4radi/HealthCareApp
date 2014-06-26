//
//  RTDoingViewController.m
//  Health
//
//  Created by GeoBeans on 14-6-24.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import "RTDoingViewController.h"

@interface RTDoingViewController ()

@end

@implementation RTDoingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)startButton:(id)sender {
    if (!started) {
        [self initTimer];
        started=YES;
        [self.startButton setTitle:@"停止" forState:UIControlStateNormal];
        _mapView.recording=YES;
        [sportRecord resetData];
        
    }else{
        [self freeTimer];
        started=NO;
        [self.startButton setTitle:@"开始" forState:UIControlStateNormal];
        _mapView.recording=NO;
    }
}

- (void)viewWillLayoutSubviews{
    [self.navBar setFrame:CGRectMake(0, 0, 320, 64)];
    self.navBar.translucent=YES;
    [self.startButton setStyleType:ACPButtonOK];
    [self.startButton setLabelTextColor:[UIColor whiteColor] highlightedColor:[UIColor greenColor] disableColor:nil];
    [self.startButton setCornerRadius:40];
    [self.startButton setLabelFont:[UIFont fontWithName:@"Trebuchet MS" size:20]];
    [self.startButton setBorderStyle:[UIColor greenColor] andInnerColor:nil];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (!_mapView) {
        _mapView= [[RTMapView alloc] initWithFrame:CGRectMake(0, 64, 320, 264)];
        [self.view addSubview:_mapView];
    }
    
    [_mapView showLocation];
    
    planData=[RTPlanData shareInstance];
    route=[_mapView convertToCoord2D:planData.routeCoord];
    if ([planData.routeCoord count]>1) {
        [_mapView addPolyline:route withcount:[planData.routeCoord count]];
    }else if ([planData.routeCoord count]==1){
        [self addPointAnno:route[0]];
        [_mapView setCenterCoord:route[0]];
    }
    started=NO;
    
    sportRecord=[RTSportRecord shareInstance];
    [sportRecord addObserver:self forKeyPath:@"nowDistance" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
}

-(void)initTimer
{
    //时间间隔
    NSTimeInterval timeInterval =1.0 ;
    //定时器
    timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(handleMaxShowTimer:) userInfo:nil repeats:YES];
    seconds=0;
    timeLoop=0;
    
}

-(void)freeTimer{
    [timer invalidate];
}

//触发事件
-(void)handleMaxShowTimer:(NSTimer *)theTimer
{
    seconds++;
    timeLoop++;
    int hour=seconds/3600;
    int minute=(seconds%3600)/60;
    int second=(seconds%3600)%60;
    
    NSString *time=[NSString stringWithFormat:@"%02d:%02d:%02d",hour,minute,second];
    self.timeLabel.text=time;
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    self.speedLabel.text=[NSString stringWithFormat:@"%.1f",sportRecord.nowSpeed];
    self.calLabel.text=[NSString stringWithFormat:@"%.1f",sportRecord.nowCalories];
    self.distLabel.text=[NSString stringWithFormat:@"%.0f",sportRecord.nowDistance];
    
//    if ([sportRecord.realCoordinate count]>=2) {
//        NSString *s1=[sportRecord.realCoordinate objectAtIndex:[sportRecord.realCoordinate count]-2];
//        NSString *s2=[sportRecord.realCoordinate lastObject];
//        NSArray *arr=[[NSArray alloc]initWithObjects:s1,s2, nil];
//        CLLocationCoordinate2D *coord=[_mapView convertToCoord2D:arr];
//        
//        _mapView.lineColor=[[UIColor greenColor] colorWithAlphaComponent:0.7];
//        [_mapView addPolyline:coord withcount:2];
//        coord=nil;
//    }
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

- (IBAction)touchBack:(id)sender {
    self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [sportRecord removeObserver:self forKeyPath:@"nowDistance"];
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
