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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        //载入运动次数
        cellNum=0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationbar setFrame:CGRectMake(0, 0, 320, 64)];
    self.navigationbar.translucent=YES;
    scrollView = [ [UIScrollView alloc ] initWithFrame:CGRectMake(0, 64, 320, 468) ];
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
    
    //添加按钮2
    UIImageView *imgview2=[[UIImageView alloc]initWithFrame:CGRectMake(280, 27, 30, 30)];
    [imgview2 setImage:[UIImage imageNamed:@"add-master.png"]];
    [self.view insertSubview:imgview2 aboveSubview:self.navigationbar];
    UITapGestureRecognizer *backGesture2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addPlan)];
    [imgview2 addGestureRecognizer:backGesture2];
    imgview2.userInteractionEnabled=YES;
    
    //stepCounter
    stepCounter=[RTStepCounter sharedRTSterCounter];
    [stepCounter addObserver:self forKeyPath:@"step" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    
    //plandata
    planData=[RTPlanData shareInstance];
    
    
    dateFormatter1=[[NSDateFormatter alloc]init];
    [dateFormatter1 setDateFormat:@"HH:mm"];
    dateFormatter2=[[NSDateFormatter alloc]init];
    [dateFormatter2 setDateFormat:@"H小时m分"];
    dateFormatter3=[[NSDateFormatter alloc]init];
    [dateFormatter3 setDateFormat:@"H"];
    dateFormatter4=[[NSDateFormatter alloc]init];
    [dateFormatter4 setDateFormat:@"m"];
    
    [self tableViewInit];
}

- (void)tableViewInit{
    //add tableView
    recordArray=[[NSMutableArray alloc]init];
    [self.tableView setDelegate:self];
	[self.tableView setDataSource:self];
    self.tableView.scrollEnabled=false;
    self.tableView.separatorColor=[UIColor colorWithRed:130.0/255.0 green:190.0/255.0 blue:20.0/255.0 alpha:1.0];
    
    NSUserDefaults *mySettingData = [NSUserDefaults standardUserDefaults];
    
    AVQuery *query=[AVQuery queryWithClassName:@"JKHistorySportPlan"];
    query.limit = 5;
    [query whereKey:@"userObjectId" equalTo:[mySettingData objectForKey:@"CurrentUserName"]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            cellNum=[objects count];
            
            for (int i=0; i<cellNum; i++) {
                NSString *placeName=[[[objects objectAtIndex:i] objectForKey:@"sportGeoPointDescription"] objectAtIndex:0];
                NSString *startTime=[dateFormatter1 stringFromDate: [[objects objectAtIndex:i] objectForKey:@"startTime"]];
                NSString *endTime=[dateFormatter1 stringFromDate: [[objects objectAtIndex:i] objectForKey:@"endTime"]];
                NSString *sportType=[[objects objectAtIndex:i] objectForKey:@"sportType"];
                NSString *strength=[[objects objectAtIndex:i] objectForKey:@"strength"];
                NSNumber *calories=[[objects objectAtIndex:i] objectForKey:@"sportCaloriesPlan"];
                NSString *objectId=[[objects objectAtIndex:i] objectForKey:@"objectId"];
                [recordArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:placeName, @"location",startTime, @"startTime", endTime, @"endTime",sportType,@"type",strength,@"strength",calories,@"calories",objectId,@"objectId",nil]];
            }
            
            [self.tableView setFrame:CGRectMake(0, 216, 320, 100*cellNum)];//按照cell个数定义高度
            scrollView.contentSize=CGSizeMake(self.view.frame.size.width, 226+100*cellNum);
            [scrollView addSubview:self.tableView];
        } else {
            // Log details of the failure
            NSLog(@"查找错误");
        }
    }];
    query=nil;
}



- (void)addPlan{
    if (!sportPlanVC) {
        sportPlanVC=[[RTSportPlanViewController alloc]init];
        sportPlanVC.dataDelegate=self;
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
    cell.type.text=[dic objectForKey:@"type"];
    if ([[dic objectForKey:@"type"] isEqualToString:@"跑步"]||[[dic objectForKey:@"type"] isEqualToString:@"走路"]) {
        cell.title2.text=@"平均速度";
    }
    cell.strength.text=[dic objectForKey:@"strength"];
    
    NSNumberFormatter *ft=[[NSNumberFormatter alloc]init];
    cell.calories.text=[ft stringFromNumber:[dic objectForKey:@"calories"]];
    ft=nil;
    
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
    NSUInteger row = [indexPath row];
    [self loadDetailView:row];
    [[tableView cellForRowAtIndexPath:indexPath] setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)refreshTableView{
    [recordArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:[planData.sportGeoPointDescription objectAtIndex:0], @"location",[dateFormatter1 stringFromDate: planData.startTime ], @"startTime", [dateFormatter1 stringFromDate: planData.endTime], @"endTime",planData.sportType,@"type",planData.strength,@"strength",planData.calories,@"calories",planData.objectId,@"objectId",nil]];
    cellNum++;
    [self.tableView setFrame:CGRectMake(0, 216, 320, 100*cellNum)];
    [self.tableView reloadData];
    scrollView.contentSize=CGSizeMake(self.view.frame.size.width, 226+100*cellNum);
}

//*********************detailsView********************//

- (void)loadDetailView:(NSInteger)row{

    if(!detailVC){
        detailVC=[[RTDetailViewController alloc]init];
    }
    
    NSDictionary *dic=[recordArray objectAtIndex:row];
    NSString *objectId=[dic objectForKey:@"objectId"];
    
    AVQuery *query=[AVQuery queryWithClassName:@"JKHistorySportPlan"];
    [query whereKey:@"objectId" equalTo:objectId];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            cellNum=[objects count];
            
            planData.routeCoord=[[objects objectAtIndex:0] objectForKey:@"sportGeoPoint"];
            planData.startTime=[[objects objectAtIndex:0] objectForKey:@"startTime"];
            planData.endTime=[[objects objectAtIndex:0] objectForKey:@"endTime"];
            planData.sportType=[[objects objectAtIndex:0] objectForKey:@"sportType"];
            planData.strength=[[objects objectAtIndex:0] objectForKey:@"strength"];
            planData.calories=[[objects objectAtIndex:0] objectForKey:@"sportCaloriesPlan"];
            
            detailVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;     
            [self presentViewController:detailVC animated:YES completion:nil];
            detailVC=nil;
        }
    }];
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
