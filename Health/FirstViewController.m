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
    self.navigationItem.title=@"今日运动";
    
    
    
    UIScrollView* scrollView = [ [UIScrollView alloc ] initWithFrame:CGRectMake(0, 64, 320, 468) ];
    [self.view addSubview:scrollView];
    progressView=[[PICircularProgressView alloc]initWithFrame:CGRectMake(60, 6, 200, 200)];
    [scrollView addSubview:progressView];
    scrollView.contentSize=CGSizeMake(self.view.frame.size.width, 226+100*cellNum);

    //为progressView 添加点击事件
    progressView.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewClick:)];
    [progressView addGestureRecognizer:tapGesture];
    tag=0;
    
    //add tableView
    [self.tableView setDelegate:self];
	[self.tableView setDataSource:self];
    [self.tableView setFrame:CGRectMake(0, 216, 320, 100*cellNum)];//按照cell个数定义高度
    self.tableView.scrollEnabled=false;
    [scrollView addSubview:self.tableView];
    recordArray = [NSMutableArray arrayWithObjects:
                   [NSDictionary dictionaryWithObjectsAndKeys:@"鸟巢", @"location",@"21:00", @"startTime", @"21:30", @"endTime",@"3000",@"steps",@"4.3km/h",@"speed",@"200KCal",@"colories", nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:@"天安门", @"location",@"11:00", @"startTime", @"11:30", @"endTime",@"5000",@"steps",@"4.7km/h",@"speed",@"280KCal",@"colories", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"中科院遥感所", @"location",@"19:00", @"startTime", @"20:30", @"endTime",@"10000",@"steps",@"4.3km/h",@"speed",@"400KCal",@"colories", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"清华大学", @"location",@"21:00", @"startTime", @"21:30", @"endTime",@"3000",@"steps",@"4.3km/h",@"speed",@"200KCal",@"colories", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"天坛", @"location",@"21:00", @"startTime", @"21:30", @"endTime",@"3000",@"steps",@"4.3km/h",@"speed",@"200KCal",@"colories", nil]
                   ,nil];
    
    //add mapView
    [self.detailNavBar setFrame:CGRectMake(0, 0, 320, 64)];
    if (!_mapView) {
        _mapView= [[RTMapView alloc] initWithFrame:CGRectMake(0, 64, 320, 264)];
        [self.detailView insertSubview:_mapView belowSubview:self.labelValues];
    }
    [self loadChartView];
    self.labelValues.hidden=YES;
}


//*******************************动态图********************************//
- (void)viewClick:(UITapGestureRecognizer *)gesture
{
    if (tag==0) {
        UIColor *col1=[UIColor colorWithRed:15.0/255.0 green:97.0/255.0 blue:189.0/255.0 alpha:1.0];
        UIColor *col2=[UIColor colorWithRed:114.0/255.0 green:174.0/255.0 blue:235.0/255.0 alpha:1.0];
        [self setupPregressView:@"步   数" goal:@"目标:10000" complete:9000 withTopColor:col1 AndBottomColor:col2];
        tag++;
    }else if (tag==1){
        
        UIColor *col2=[UIColor colorWithRed:183.0/255.0 green:242.0/255.0 blue:151.0/255.0 alpha:1.0];
        UIColor *col1=[UIColor colorWithRed:0.0/255.0 green:255.0/255.0 blue:0.0/255.0 alpha:1.0];

        [self setupPregressView:@"里   程" goal:@"目标:10" complete:7 withTopColor:col1 AndBottomColor:col2];
        tag++;
    }else if (tag==2){
        UIColor *col1=[UIColor colorWithRed:255.0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
        UIColor *col2=[UIColor colorWithRed:242.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];

        [self setupPregressView:@"卡路里" goal:@"目标:300" complete:180 withTopColor:col1 AndBottomColor:col2];
        tag=0;
    }
    
}
- (void)setupPregressView:(NSString *)title goal:(NSString *)goal complete:(int)_complete withTopColor:(UIColor*)color1 AndBottomColor:(UIColor*)color2
{
    progressView.title=title;
    progressView.goal=goal;
    complete=_complete;
    progressView.progressTopGradientColor=color1;
    progressView.progressBottomGradientColor=color2;
    
    for (int i=0; i<=100*complete/[[progressView.goal substringFromIndex:3] floatValue]; i++) {
        [self performSelector:@selector(setProgress) withObject:nil afterDelay:0.005*i];
    }
}

- (void)setProgress{
    
    progressView.progress=(progressNow++)/100;
    if (progressNow==100*complete/[[progressView.goal substringFromIndex:3] floatValue]+1) {
        progressNow=0;
    }
}

- (void)viewDidAppear:(BOOL)animated{
    UIColor *col1=[UIColor colorWithRed:255.0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
    UIColor *col2=[UIColor colorWithRed:242.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];

    [self setupPregressView:@"卡路里" goal:@"目标:300" complete:180 withTopColor:col1 AndBottomColor:col2];

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

- (IBAction)back:(id)sender {
    [UIView beginAnimations:@"view flip" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView transitionWithView:self.view
                      duration:0.2
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{ [self.detailView removeFromSuperview];  }
                    completion:NULL];
    [UIView commitAnimations];
    
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
//    self.labelDates.text = [NSString stringWithFormat:@"in %@", [self.ArrayOfDates objectAtIndex:index]];
}

- (void)didReleaseGraphWithClosestIndex:(float)index {
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.labelValues.alpha = 0.0;
        self.labelDates.alpha = 0.0;
    } completion:^(BOOL finished){
        self.labelValues.hidden=YES;
        self.labelValues.alpha = 1.0;
        self.labelDates.alpha = 1.0;
        
//        
//        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//            self.labelValues.alpha = 1.0;
//            self.labelDates.alpha = 1.0;
//        } completion:nil];
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
