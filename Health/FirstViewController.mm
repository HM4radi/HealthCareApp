//
//  FirstViewController.m
//  Health
//
//  Created by GeoBeans on 14-5-14.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize cellNum;
@synthesize myGraph;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        //载入运动次数
        cellNum=5;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationbar setFrame:CGRectMake(0, 0, 320, 64)];
    self.navigationbar.translucent=YES;
    UIScrollView* scrollView = [ [UIScrollView alloc ] initWithFrame:CGRectMake(0, 64, 320, 468) ];
    [self.view addSubview:scrollView];
    progressView=[[PICircularProgressView alloc]initWithFrame:CGRectMake(60, 6, 200, 200)];
    progressView.thicknessRatio=0.08;
    progressView.roundedHead=false;
    progressView.showShadow=false;
    [scrollView addSubview:progressView];
    scrollView.contentSize=CGSizeMake(self.view.frame.size.width, 226+100*cellNum);

    //为progressView 添加点击事件
    progressView.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewClick:)];
    [progressView addGestureRecognizer:tapGesture];
    tag=0;
    
    
    //返回按钮1
    UIImageView *imgview=[[UIImageView alloc]initWithFrame:CGRectMake(10, 27, 30, 25)];
    [imgview setImage:[UIImage imageNamed:@"back-master.png"]];
    [self.view insertSubview:imgview aboveSubview:self.navigationbar];
    UITapGestureRecognizer *backGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchBack)];
    [imgview addGestureRecognizer:backGesture];
    imgview.userInteractionEnabled=YES;
    
    //返回按钮2
    UIImageView *imgview1=[[UIImageView alloc]initWithFrame:CGRectMake(10, 27, 30, 25)];
    [imgview1 setImage:[UIImage imageNamed:@"back-master.png"]];
    [self.detailView insertSubview:imgview1 aboveSubview:self.detailNavBar];
    UITapGestureRecognizer *backGesture1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchBack2)];
    [imgview1 addGestureRecognizer:backGesture1];
    imgview1.userInteractionEnabled=YES;

    //添加按钮2
    UIImageView *imgview2=[[UIImageView alloc]initWithFrame:CGRectMake(280, 27, 30, 30)];
    [imgview2 setImage:[UIImage imageNamed:@"add-master.png"]];
    [self.view insertSubview:imgview2 aboveSubview:self.navigationbar];
    UITapGestureRecognizer *backGesture2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addPlan)];
    [imgview2 addGestureRecognizer:backGesture2];
    imgview2.userInteractionEnabled=YES;
    
    
    //add tableView
    [self.tableView setDelegate:self];
	[self.tableView setDataSource:self];
    [self.tableView setFrame:CGRectMake(0, 216, 320, 100*cellNum)];//按照cell个数定义高度
    self.tableView.scrollEnabled=false;
    self.tableView.separatorColor=[UIColor colorWithRed:130.0/255.0 green:190.0/255.0 blue:20.0/255.0 alpha:1.0];
    [scrollView addSubview:self.tableView];
    recordArray = [NSMutableArray arrayWithObjects:
                   [NSDictionary dictionaryWithObjectsAndKeys:@"鸟巢", @"location",@"21:00", @"startTime", @"21:30", @"endTime",@"3000",@"steps",@"4.3",@"speed",@"200",@"calories", nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:@"天安门", @"location",@"11:00", @"startTime", @"11:30", @"endTime",@"5000",@"steps",@"4.7",@"speed",@"280",@"calories", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"中科院遥感所", @"location",@"19:00", @"startTime", @"20:30", @"endTime",@"10000",@"steps",@"4.3",@"speed",@"400",@"calories", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"清华大学", @"location",@"21:00", @"startTime", @"21:30", @"endTime",@"3000",@"steps",@"4.3",@"speed",@"200",@"calories", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"天坛", @"location",@"21:00", @"startTime", @"21:30", @"endTime",@"3000",@"steps",@"4.3",@"speed",@"200",@"calories", nil]
                   ,nil];
    
    //add mapView
    [self.detailNavBar setFrame:CGRectMake(0, 0, 320, 64)];
    if (!_mapView) {
        _mapView= [[RTMapView alloc] initWithFrame:CGRectMake(0, 64, 320, 264)];
        [self.detailView insertSubview:_mapView belowSubview:self.labelValues];
    }
    [self loadChartView];
    self.labelValues.hidden=YES;
    
    currentAnno=[[QPointAnnotation alloc]init];
    [self addLineAnno];
    
    //stepCounter
    stepCounter=[RTStepCounter sharedRTSterCounter];
    [stepCounter addObserver:self forKeyPath:@"step" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    
    //plandata
    planData=[RTPlanData shareInstance];
}


- (void)addPlan{
    if (!sportPlanVC) {
        sportPlanVC=[[RTSportPlanViewController alloc]init];
    }

    sportPlanVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;

    [self presentViewController:sportPlanVC animated:YES completion:nil];
    
    sportPlanVC=nil;
}


//*******************************动态图********************************//
- (void)viewClick:(UITapGestureRecognizer *)gesture
{
    if (tag==0) {
        progressView.type=0;
        UIColor *col1=[UIColor colorWithRed:15.0/255.0 green:97.0/255.0 blue:189.0/255.0 alpha:1.0];
        UIColor *col2=[UIColor colorWithRed:114.0/255.0 green:174.0/255.0 blue:235.0/255.0 alpha:1.0];
        [self setupPregressView:@"步   数" goal:@"目标:5000" complete:[stepCounter.step floatValue] withTopColor:col1 AndBottomColor:col2];
        tag++;
    }else if (tag==1){
        progressView.type=1;
        UIColor *col2=[UIColor colorWithRed:183.0/255.0 green:242.0/255.0 blue:151.0/255.0 alpha:1.0];
        UIColor *col1=[UIColor colorWithRed:0.0/255.0 green:255.0/255.0 blue:0.0/255.0 alpha:1.0];
        [self setupPregressView:@"里   程" goal:@"目标:9.4" complete:6.2 withTopColor:col1 AndBottomColor:col2];
        tag++;
    }else if (tag==2){
        progressView.type=2;
        UIColor *col1=[UIColor colorWithRed:255.0/255.0 green:136/255.0 blue:49/255.0 alpha:1.0];
        UIColor *col2=[UIColor colorWithRed:244.0/255.0 green:237.0/255.0 blue:138.0/255.0 alpha:1.0];
        [self setupPregressView:@"卡路里" goal:@"目标:300" complete:236 withTopColor:col1 AndBottomColor:col2];
        tag=0;
    }
}

- (void)setupPregressView:(NSString *)title goal:(NSString *)goal complete:(float)_complete withTopColor:(UIColor*)color1 AndBottomColor:(UIColor*)color2
{
    progressNow=0;
    progressView.title=title;
    progressView.goal=goal;
    complete=_complete;
    progressView.progressTopGradientColor=color1;
    progressView.progressBottomGradientColor=color2;
    NSString *finishAnimat;
    finishAnimat=@"notFinished";
    
    for (int i=0; i<=100*complete/[[progressView.goal substringFromIndex:3] floatValue]; i++) {
        if (100*complete/[[progressView.goal substringFromIndex:3] floatValue]-i<1) {
            finishAnimat=@"finished";
        }
        [self performSelector:@selector(setProgress:) withObject:finishAnimat afterDelay:0.005*i];
    }
}

- (void)setProgress:(NSString *)finish{
    float goal=[[progressView.goal substringFromIndex:3] floatValue];
    progressView.progress=(progressNow++)/100;
    if ([finish isEqual:@"finished"]) {
        progressView.progress=float(complete)/goal;
    }
}

- (void)viewDidAppear:(BOOL)animated{
    
    UIColor *col1=[UIColor colorWithRed:255.0/255.0 green:136/255.0 blue:49/255.0 alpha:1.0];
    UIColor *col2=[UIColor colorWithRed:244.0/255.0 green:237.0/255.0 blue:138.0/255.0 alpha:1.0];
    progressView.type=2;
    [self setupPregressView:@"卡路里" goal:@"目标:300" complete:236 withTopColor:col1 AndBottomColor:col2];

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{

    if ([keyPath isEqual:@"step"]) {
        if (progressView.type==0) {
            float goal=[[progressView.goal substringFromIndex:3] floatValue];
            progressView.progress=float([stepCounter.step floatValue])/goal;
        }
    }
}

//*********************tableView********************//

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static BOOL nibsRegistered = NO;
    
    static NSString *Cellidentifier=@"cell1";
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"RTTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:Cellidentifier];
        nibsRegistered = YES;
    }

    RTTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:Cellidentifier forIndexPath:indexPath];
    
	NSUInteger row=[indexPath row];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSDictionary *dic=[recordArray objectAtIndex:row];
    cell.location.text=[dic objectForKey:@"location"];
    cell.startTime.text=[dic objectForKey:@"startTime"];
    cell.endTime.text=[dic objectForKey:@"endTime"];
    cell.steps.text=[dic objectForKey:@"steps"];
    cell.speed.text=[dic objectForKey:@"speed"];
    cell.calories.text=[dic objectForKey:@"calories"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return cellNum;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//行缩进

-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = [indexPath row];
    return row;
}
//改变行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self loadDetailView];
    [[tableView cellForRowAtIndexPath:indexPath] setSelectionStyle:UITableViewCellSelectionStyleNone];
}

//*********************detailsView********************//

- (void)loadDetailView{

    [UIView beginAnimations:@"view flip" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView transitionWithView:self.view
                      duration:0.2
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{ [self.view addSubview:self.detailView];  }
                    completion:NULL];
    [UIView commitAnimations];
    //add ChartView
    
}



//*********************chartView********************//

- (void)loadChartView{
    
    self.ArrayOfValues = [[NSMutableArray alloc] init];
    self.ArrayOfDates = [[NSMutableArray alloc] init];
    
    [self.detailView insertSubview:self.labelValues aboveSubview:self.myGraph];
    
    for (int i=0; i < 24; i++) {
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

-(void)addLineAnno{
 
    [self initRouteCount];
    [_mapView addPolyline:route withcount:routeCount];
}

- (void)initRouteCount{
    routeCount=24;
    route=new CLLocationCoordinate2D[routeCount];
    route[0]=CLLocationCoordinate2DMake(40.0002778,116.3741667);
    route[1]=CLLocationCoordinate2DMake(40.0033333,116.3745833);
    route[2]=CLLocationCoordinate2DMake(40.0034056,116.3779722);
    route[3]=CLLocationCoordinate2DMake(40.0053139,116.3779556);
    route[4]=CLLocationCoordinate2DMake(40.0055194,116.3865056);
    route[5]=CLLocationCoordinate2DMake(40.0101472,116.3862889);
    route[6]=CLLocationCoordinate2DMake(40.0104417,116.3874528);
    route[7]=CLLocationCoordinate2DMake(40.0104333,116.3904583);
    route[8]=CLLocationCoordinate2DMake(40.0101917,116.3904583);
    route[9]=CLLocationCoordinate2DMake(40.0009844,116.3906278);
    route[10]=CLLocationCoordinate2DMake(40.0009703,116.3902750);
    route[11]=CLLocationCoordinate2DMake(40.0009406,116.3902306);
    route[12]=CLLocationCoordinate2DMake(40.0009000,116.3905111);
    route[13]=CLLocationCoordinate2DMake(40.0009469,116.3902889);
    route[14]=CLLocationCoordinate2DMake(40.0009458,116.3925000);
    route[15]=CLLocationCoordinate2DMake(40.0108778,116.3934639);
    route[16]=CLLocationCoordinate2DMake(40.0144444,116.3935694);
    route[17]=CLLocationCoordinate2DMake(40.0150861,116.3929917);
    route[18]=CLLocationCoordinate2DMake(40.0148889,116.3918028);
    route[19]=CLLocationCoordinate2DMake(40.0151167,116.3897833);
    route[20]=CLLocationCoordinate2DMake(40.0158250,116.3874417);
    route[21]=CLLocationCoordinate2DMake(40.0156917,116.3861444);
    route[22]=CLLocationCoordinate2DMake(40.0151722,116.3845667);
    route[23]=CLLocationCoordinate2DMake(40.0140667,116.3680944);
}

-(void)addPointAnno:(CLLocationCoordinate2D)point{
    
    [currentAnno setCoordinate:point];
    [currentAnno setTitle:@"途经点"];
    [_mapView addPointAnno:currentAnno];
}


- (void)touchBack{
    
    [UIView beginAnimations:@"view flip" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView transitionWithView:self.view.superview
                      duration:0.2
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{ [self.view removeFromSuperview];  }
                    completion:NULL];
    [UIView commitAnimations];
}

- (void)touchBack2{
    
    [UIView beginAnimations:@"view flip" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView transitionWithView:self.view
                      duration:0.2
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{ [self.detailView removeFromSuperview];  }
                    completion:NULL];
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
