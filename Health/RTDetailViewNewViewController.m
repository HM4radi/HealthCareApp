//
//  RTDetailViewNewViewController.m
//  Health
//
//  Created by Mac on 6/17/14.
//  Copyright (c) 2014 RADI Team. All rights reserved.
//

#import "RTDetailViewNewViewController.h"
#import "PNChart.h"
#import "RTFamilyDetailViewController.h"

@interface RTDetailViewNewViewController ()

@end

@implementation RTDetailViewNewViewController
{
    NSArray *dayStatusValueArray;
    NSArray *weekStatusValusArray;
    NSMutableDictionary *friendDataListDict;
    NSArray *selfHealthdataArray;
    NSArray *friend;
    
    NSArray *friendNameList;
    
    NSUInteger currentSelectedIndex;

}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    //初始化数据
    friendNameList=[NSArray arrayWithObjects:@"gyb",@"shirui",nil];
    
    
    
    NSArray *b1=[NSArray arrayWithObjects:@"1",@"5",@"2",@"6",@"8",@"7",@"9",@"5",@"1",@"10",@"8",@"4", nil];
    
    NSArray *b2=[NSArray arrayWithObjects:@"1",@"5",@"2",@"6",@"8",@"7",@"9", nil];
    NSArray *b3=[NSArray arrayWithObjects:@"90/100",@"60/100",@"90/100",nil ];
   
    NSArray *f1=[NSArray arrayWithObjects:b3,b1,b2, nil];
    UIImage* i1=[UIImage imageNamed:@"1.jpg"];
    friendDataListDict=[NSMutableDictionary dictionaryWithObject:f1 forKey:[friendNameList objectAtIndex:0]];
    [friendDataListDict setObject:i1 forKey:[[friendNameList objectAtIndex:0] stringByAppendingString:@"image"]];
//    [friendDict setObject:i2 forKey:@"watermeion"];
    
    
    
    NSArray *a1=[NSArray arrayWithObjects:@"10",@"3",@"2",@"5",@"8",@"7",@"9",@"10",@"1",@"10",@"8",@"2", nil];
    
    NSArray *a2=[NSArray arrayWithObjects:@"10",@"6",@"9",@"7",@"1",@"3",@"9", nil];
    
    NSArray *a3=[NSArray arrayWithObjects:@"30/100",@"80/100",@"75/100",nil];
    
     NSArray *f2=[NSArray arrayWithObjects:a3,a1,a2,nil];
    UIImage* i2=[UIImage imageNamed:@"2.jpg"];
    [friendDataListDict setObject:f2 forKey:[friendNameList objectAtIndex:1]];
   //添加用户头像
    [friendDataListDict setObject:i2 forKey:[[friendNameList objectAtIndex:1] stringByAppendingString:@"image"]];
    
    
    
    // Do any additional setup after loading the view from its nib.
    
    LightMenuBar *menuBar = [[LightMenuBar alloc] initWithFrame:CGRectMake(0, 64, 320, 40) andStyle:LightMenuBarStyleItem];
//      LightMenuBar *menuBar = [[LightMenuBar alloc] initWithFrame:CGRectMake(0, 64, 320, 40) andStyle:LightMenuBarStyleButton];
    menuBar.delegate = self;
    
    menuBar.bounces = YES;
    //menuBar
  
    menuBar.selectedItemIndex = currentSelectedIndex;
//    currentSelectedIndex=0;
    
    menuBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:menuBar];
    
    
    portraitView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 85, 85)];
    [portraitView.layer setCornerRadius:CGRectGetHeight(portraitView.bounds)/2];
    portraitView.layer.borderColor = [UIColor blueColor].CGColor;
    //portraitView.layer.borderWidth = 0.5;
    [portraitView.layer setMasksToBounds:YES];
    
    
    
    [self loadProfileImage:[friendDataListDict objectForKey:[[friendNameList objectAtIndex:currentSelectedIndex] stringByAppendingString:@"image"]]];
    //add line chart
    //Add LineChart
//	UILabel * lineChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, 30)];
//	lineChartLabel.text = @"Line Chart";
//	lineChartLabel.textColor = PNFreshGreen;
//	lineChartLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:23.0];
//	lineChartLabel.textAlignment = NSTextAlignmentCenter;
	
	[self setChartData];
    [self loadDayDataAndDrawLine];
    [self loadDataLabelText];
    
//    lineChart = [[PNChart alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200.0)];
//    lineChart.backgroundColor = [UIColor clearColor];
//    //设置x轴点的个数
//    [lineChart setXNodeNum:12.0];
//	[lineChart setXLabels:@[@"0点",@"2点",@"4点",@"6点",@"8点",@"10点",@"12点",@"14点",@"16点",@"18点",@"20点",@"22点"]];
//	[lineChart setYValues:dayStatusValueArray];
//	[lineChart strokeChart];
//    //	[self.friendBriefChat addSubview:lineChartLabel];
//	[self.friendBriefChat addSubview:lineChart];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)setChartData
{
    if (currentSelectedIndex<[friendNameList count]) {
        dayStatusValueArray=[[friendDataListDict objectForKey:[friendNameList objectAtIndex:currentSelectedIndex]] objectAtIndex:1];
        weekStatusValusArray=[[friendDataListDict objectForKey:[friendNameList objectAtIndex:currentSelectedIndex]] objectAtIndex:2];
      

    }
   



}


-(void)loadDataLabelText
{
    self.data1Label.text=[[[friendDataListDict objectForKey:
                            [friendNameList objectAtIndex:currentSelectedIndex]] objectAtIndex:0] objectAtIndex:0];
    self.data2Label.text=[[[friendDataListDict objectForKey:[friendNameList objectAtIndex:currentSelectedIndex]] objectAtIndex:0] objectAtIndex:1];
    self.data3Label.text=[[[friendDataListDict objectForKey:[friendNameList objectAtIndex:currentSelectedIndex]] objectAtIndex:0] objectAtIndex:2];


}

-(void)loadProfileImage:(UIImage*) image
{
    
    [portraitView removeFromSuperview];
   
    
    [portraitView setImage:image];
    [self.friendsBriefProfieView addSubview:portraitView];

}

-(void)setCurrentSelectedIndex:(NSUInteger) i
{
    currentSelectedIndex=i;

}


#pragma mark LightMenuBarDelegate
- (NSUInteger)itemCountInMenuBar:(LightMenuBar *)menuBar {
    return [friendNameList count];
}


//MenuBar Title Text
- (NSString *)itemTitleAtIndex:(NSUInteger)index inMenuBar:(LightMenuBar *)menuBar {
   
    NSLog(@"index:%lu",(unsigned long)index);
    return [friendNameList objectAtIndex:index];
    
    
}

//MenuBar Selected
- (void)itemSelectedAtIndex:(NSUInteger)index inMenuBar:(LightMenuBar *)menuBar {
//    dispLabel.text = [NSString stringWithFormat:@"%d Selected", index];
    [self setCurrentSelectedIndex:index];
    [self loadProfileImage:[friendDataListDict objectForKey:[[friendNameList objectAtIndex:index] stringByAppendingString:@"image"]]];
    
    [self setChartData];
    [self loadDayDataAndDrawLine];
    //设置头像右侧label  数据逻辑  friendDataList["gyb"].[0].[x];
    [self loadDataLabelText];
}
//itemWidth
//< Optional
- (CGFloat)itemWidthAtIndex:(NSUInteger)index inMenuBar:(LightMenuBar *)menuBar {
    return 60.0f;
}

#if USE_CUSTOM_DISPLAY

/****************************************************************************/
//< For Background Area
/****************************************************************************/

/**< Top and Bottom Padding, by Default 5.0f */
- (CGFloat)verticalPaddingInMenuBar:(LightMenuBar *)menuBar {
    return 0.0f;
}

/**< Left and Right Padding, by Default 5.0f */
- (CGFloat)horizontalPaddingInMenuBar:(LightMenuBar *)menuBar {
    return 0.0f;
}

/**< Corner Radius of the background Area, by Default 5.0f */
- (CGFloat)cornerRadiusOfBackgroundInMenuBar:(LightMenuBar *)menuBar {
    return 0.0f;
}

- (UIColor *)colorOfBackgroundInMenuBar:(LightMenuBar *)menuBar {
    return [UIColor blackColor];
}

/****************************************************************************/
//< For Button
/****************************************************************************/

/**< Corner Radius of the Button highlight Area, by Default 5.0f */
- (CGFloat)cornerRadiusOfButtonInMenuBar:(LightMenuBar *)menuBar {
    return 1.0f;
}

- (UIColor *)colorOfButtonHighlightInMenuBar:(LightMenuBar *)menuBar {
    return [UIColor whiteColor];
    
}

- (UIColor *)colorOfTitleNormalInMenuBar:(LightMenuBar *)menuBar {
    return [UIColor whiteColor];
}

- (UIColor *)colorOfTitleHighlightInMenuBar:(LightMenuBar *)menuBar {
    return [UIColor blackColor];
}

- (UIFont *)fontOfTitleInMenuBar:(LightMenuBar *)menuBar {
    return [UIFont systemFontOfSize:15.0f];
}

/****************************************************************************/
//< For Seperator
/****************************************************************************/

///**< Color of Seperator, by Default White */
//- (UIColor *)seperatorColorInMenuBar:(LightMenuBar *)menuBar {
//}

/**< Width of Seperator, by Default 1.0f */
- (CGFloat)seperatorWidthInMenuBar:(LightMenuBar *)menuBar {
    return 0.0f;
}

/**< Height Rate of Seperator, by Default 0.7f */
- (CGFloat)seperatorHeightRateInMenuBar:(LightMenuBar *)menuBar {
    return 0.0f;
}

#endif


- (IBAction)dayAndWeekSegAction:(id)sender {
    
    switch (self.dayAndWeekSegment.selectedSegmentIndex) {
        case 0:
            [self loadDayDataAndDrawLine];
            break;
        case 1:
            [self loadWeekDataAndDrawLine];
         
            break;
        default:
            break;
    }
    
}

-(void)loadDayDataAndDrawLine
{
    if (lineChart!=nil) {
        [lineChart removeFromSuperview];
        lineChart=nil;
    }
     lineChart = [[PNChart alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200.0)];
	lineChart.backgroundColor = [UIColor clearColor];
    //设置x轴点的个数
    [lineChart setXNodeNum:12.0];
	[lineChart setXLabels:@[@"0点",@"2点",@"4点",@"6点",@"8点",@"10点",@"12点",@"14点",@"16点",@"18点",@"20点",@"22点"]];
	[lineChart setYValues:dayStatusValueArray];
	[lineChart strokeChart];
 
	[self.friendBriefChat addSubview:lineChart];
    
}

-(void)loadWeekDataAndDrawLine
{
    if (lineChart!=nil) {
        [lineChart removeFromSuperview];
        lineChart=nil;
    }
    
    lineChart = [[PNChart alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200.0)];
	lineChart.backgroundColor = [UIColor clearColor];
    //设置x轴点的个数
    [lineChart setXNodeNum:7.0];
	[lineChart setXLabels:@[@"Mon",@"Tue",@"Wed",@"Thu",@"Fri",@"Sat",@"Sun"]];
	[lineChart setYValues:weekStatusValusArray];
	[lineChart strokeChart];
    
	[self.friendBriefChat addSubview:lineChart];
    
}








//make a phone call
- (IBAction)makeAcal:(id)sender {
     [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel://15652779418"]];}



- (IBAction)moreInfoAction:(id)sender {
    
    RTFamilyDetailViewController *detailViewController=[[RTFamilyDetailViewController alloc]initWithNibName:@"RTFamilyDetailViewController" bundle:nil];
   
    //
    //
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                   style:UIBarButtonItemStylePlain target:nil action:nil];
    detailViewController.navigationItem.backBarButtonItem = backButton;

    
    [self.navigationController pushViewController:detailViewController animated:YES];
    //    NSLog(@"%d",indexPath.row);
}
- (IBAction)sendMessage:(id)sender {
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"sms://15652779418"]];
}

- (IBAction)addReminder:(id)sender {
  
    UIAlertView *alerView=[[UIAlertView alloc] initWithTitle:@"Opps~!" message:@"该功能还在不断完善中" delegate:self cancelButtonTitle:@"好的知道了" otherButtonTitles:nil, nil];
    [alerView show];
}

- (IBAction)addAlert:(id)sender {
    UIAlertView *alerView=[[UIAlertView alloc] initWithTitle:@"Opps~!" message:@"该功能还在不断完善中" delegate:self cancelButtonTitle:@"好的知道了" otherButtonTitles:nil, nil];
    [alerView show];
}
@end
