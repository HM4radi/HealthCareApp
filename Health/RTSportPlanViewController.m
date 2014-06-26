//
//  RTSportPlanViewController.m
//  Health
//
//  Created by GeoBeans on 14-6-11.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import "RTSportPlanViewController.h"

@interface RTSportPlanViewController ()

@end

@implementation RTSportPlanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewWillLayoutSubviews{
    [self.NavBar setFrame:CGRectMake(0, 0, 320, 64)];
    self.NavBar.translucent=YES;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UITapGestureRecognizer *Gesture1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showSelectView:)];
    [self.sportTypeView addGestureRecognizer:Gesture1];
    [Gesture1 view].tag=1;
    self.sportTypeView.userInteractionEnabled=YES;
    
    
    UITapGestureRecognizer *Gesture2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showSelectView:)];
    [self.sportTimeView addGestureRecognizer:Gesture2];
    [Gesture2 view].tag=2;
    self.sportTimeView.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *Gesture3=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showSelectView:)];
    [self.sportLastView addGestureRecognizer:Gesture3];
    [Gesture3 view].tag=3;
    self.sportLastView.userInteractionEnabled=YES;
 
    
    sportType=[[NSMutableArray alloc]initWithObjects:@"跑步",@"步行",@"骑行",@"爬楼梯",@"乒乓球",@"羽毛球",@"篮球",@"足球",@"网球",@"健身操",@"游泳",  nil];
    
    if (!timePicker) {
        timePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0,30,320,100)];
        [timePicker setDate:[NSDate date] animated:YES];
        timePicker.tag=0;
        dateFormatter1=[[NSDateFormatter alloc]init];
        [dateFormatter1 setDateFormat:@"HH:mm"];
        dateFormatter2=[[NSDateFormatter alloc]init];
        [dateFormatter2 setDateFormat:@"H小时m分"];
        dateFormatter3=[[NSDateFormatter alloc]init];
        [dateFormatter3 setDateFormat:@"H"];
        dateFormatter4=[[NSDateFormatter alloc]init];
        [dateFormatter4 setDateFormat:@"m"];
    }
    if (!typePicker) {
        typePicker=[[UIPickerView alloc]initWithFrame:CGRectMake(0,30,320,100)];
        typePicker.delegate = self;
        typePicker.dataSource=self;
        typePicker.showsSelectionIndicator = YES;
        typePicker.tag=0;
    }
    if (!actionView) {
        actionView = [[UIActionSheet alloc] initWithTitle:@"请选择运动项目\n\n\n\n\n\n\n\n\n\n\n\n\n" delegate:self  cancelButtonTitle:@"取消" destructiveButtonTitle:@"完成" otherButtonTitles:nil, nil];
        actionView.actionSheetStyle=UIActionSheetStyleBlackTranslucent;
        [actionView setBounds:CGRectMake(0,0,100,200)];
    }
    
    if (!_mapView) {
        _mapView= [[RTMapView alloc] initWithFrame:CGRectMake(0, 220, 320, 308)];
        [self.view addSubview:_mapView];
        
        //定位按钮
        UIImageView *imgview3=[[UIImageView alloc]initWithFrame:CGRectMake(270, 248, 40, 40)];
        [imgview3 setImage:[UIImage imageNamed:@"locate2.png"]];
        [_mapView addSubview:imgview3];
        UITapGestureRecognizer *locating=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchLocate)];
        [imgview3 addGestureRecognizer:locating];
        imgview3.userInteractionEnabled=YES;
    }
    
    self.selectRoute.tag=0;
    
    self.removeBtn.hidden=YES;
    
    //plandata
    planData=[RTPlanData shareInstance];
    [planData resetting];
    finished=NO;
    

}

- (void)viewDidAppear:(BOOL)animated{
    [_mapView showLocation];
}

- (IBAction)selectRoute:(id)sender {
    if (self.selectRoute.tag==0) {
        [self.selectRoute setTitle:@"完成选择路线" forState:UIControlStateNormal];
        _mapView.selecting=YES;
        self.selectRoute.tag=1;
        self.removeBtn.hidden=NO;
        planData.querySuccess=NO;
        
    }else if (self.selectRoute.tag==1){
        [self.selectRoute setTitle:@"开始选择路线" forState:UIControlStateNormal];
        self.selectRoute.tag=0;
        self.removeBtn.hidden=YES;
        if ([_mapView.routeCoord count]>0) {
            planData.routeCoord=_mapView.routeCoord;
            
            [_mapView addPolyline:[_mapView convertToCoord2D:planData.routeCoord] withcount:[_mapView.routeCoord count]];
            for (int i=0; i<[planData.routeCoord count];i++ ) {
                [_mapView returnPlaceName:[planData.routeCoord objectAtIndex:i]];
            }
        }
    }
    _mapView.selecting=NO;
}

- (IBAction)removeBtn:(id)sender {
    [_mapView removeLastPoint];
}

- (void)showSelectView:(UITapGestureRecognizer *)sender{
    if ([sender view].tag==1) {
        if (timePicker.tag!=0) {
            [timePicker removeFromSuperview];
            timePicker.tag=0;
        }
        actionView.title=@"请选择运动项目\n\n\n\n\n\n\n\n\n\n\n\n\n";
        [actionView addSubview:typePicker];
        typePicker.tag=1;
    }
    else if ([sender view].tag==2) {
        if (typePicker.tag!=0) {
            [typePicker removeFromSuperview];
            typePicker.tag=0;
        }
        [timePicker setDatePickerMode:UIDatePickerModeDateAndTime];
        actionView.title=@"请选择起始时间\n\n\n\n\n\n\n\n\n\n\n\n\n";
        if (timePicker.tag==0) {
            [actionView addSubview:timePicker];
        }
        timePicker.tag=1;
    }
    else if ([sender view].tag==3) {
        if (typePicker.tag==1) {
            [typePicker removeFromSuperview];
            typePicker.tag=0;
        }
        actionView.title=@"请选择持续时间\n\n\n\n\n\n\n\n\n\n\n\n\n";
        [timePicker setDatePickerMode:UIDatePickerModeCountDownTimer];
        if (timePicker.tag==0) {
            [actionView addSubview:timePicker];
        }
        timePicker.tag=2;
    }
    [actionView showInView:_mapView];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        if (typePicker.tag!=0) {
            self.typeLabel.text=selectedType;
            planData.sportType=selectedType;
            planData.strength=[self returnStrength:selectedType];
        }
        else if (timePicker.tag!=0){
            if (timePicker.tag==1) {
                NSString *dtString=[dateFormatter1 stringFromDate:[timePicker date]];
                self.startTimeLabel.text=dtString;
                planData.startTime=[timePicker date];
            }else if (timePicker.tag==2){
                NSString *dtString=[dateFormatter2 stringFromDate:[timePicker date]];
                self.lastTimeLabel.text=dtString;
                planData.lastTime=[timePicker date];
            }
        }
    }
}

- (NSDate*)calEndTime{
    NSDate *ldate=planData.lastTime;
    int hour=[[dateFormatter3 stringFromDate:ldate] intValue];
    int minute=[[dateFormatter4 stringFromDate:ldate] intValue];
    NSTimeInterval interval=hour*3600+minute*60;
    NSDate *startdate=planData.startTime;
    NSDate *date2=[startdate dateByAddingTimeInterval:interval];
    return date2;
}

//*********************pickerView********************//
//  返回1列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

//  返回每一列的列表项数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [sportType count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return [sportType objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    selectedType=[sportType objectAtIndex:row];
}

//- (void)touchBack{
//    self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

- (IBAction)touchCancel:(id)sender {
    self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)touchOK:(id)sender {
    if ([self isFinishedSelecting]) {
        NSNumberFormatter *ft=[[NSNumberFormatter alloc]init];
        planData.calories=[ft numberFromString:self.caloriesLabel.text];
        ft=nil;
        planData.endTime=[self calEndTime];
        self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self dismissViewControllerAnimated:YES completion:nil];
        [self saveDataToAVOS];
    }

}

//- (void)touchOK{
//    if ([self isFinishedSelecting]) {
//        NSNumberFormatter *ft=[[NSNumberFormatter alloc]init];
//        planData.calories=[ft numberFromString:self.caloriesLabel.text];
//        ft=nil;
//        planData.endTime=[self calEndTime];
//        self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//        [self dismissViewControllerAnimated:YES completion:nil];
//        [self saveDataToAVOS];
//    }
//}

- (NSString*)returnStrength:(NSString*)type{
    NSString *strength=nil;
    
    if ([type isEqualToString:@"跑步"])
        strength=@"较强";
    else if ([type isEqualToString:@"步行"])
        strength=@"较轻";
    else if ([type isEqualToString:@"骑行"])
        strength=@"较强";
    else if ([type isEqualToString:@"爬楼梯"])
        strength=@"较轻";
    else if ([type isEqualToString:@"乒乓球"])
        strength=@"较轻";
    else if ([type isEqualToString:@"羽毛球"])
        strength=@"中等";
    else if ([type isEqualToString:@"篮球"])
        strength=@"较强";
    else if ([type isEqualToString:@"足球"])
        strength=@"较强";
    else if ([type isEqualToString:@"网球"])
        strength=@"较强";
    else if ([type isEqualToString:@"健身操"])
        strength=@"中等";
    else if ([type isEqualToString:@"游泳"])
        strength=@"较强";

    return strength;
}


- (BOOL)isFinishedSelecting{
    BOOL f=false;
    
    if (planData.startTime&&planData.lastTime&&planData.sportType&&[planData.routeCoord count]>0) {
        f=YES;
    }else if (!planData.startTime){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"信息不完整" message:@"请选择开始时间" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        alert=nil;
    }else if (!planData.lastTime){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"信息不完整" message:@"请选择持续时间" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        alert=nil;
    }else if (!planData.sportType){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"信息不完整" message:@"请选择运动项目" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        alert=nil;
    }else if ([planData.routeCoord count]==0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"信息不完整" message:@"请选择运动路线" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        alert=nil;
    }
    return f;
}

- (void)saveDataToAVOS{
    NSUserDefaults *mySettingData = [NSUserDefaults standardUserDefaults];
    
    AVObject *sportPlan=[AVObject objectWithClassName:@"JKHistorySportPlan"];
    [sportPlan setObject:planData.startTime forKey:@"startTime"];
    [sportPlan setObject:planData.endTime forKey:@"endTime"];
    [sportPlan setObject:planData.sportType forKey:@"sportType"];
    [sportPlan setObject:planData.routeCoord forKey:@"sportGeoPoint"];
    [sportPlan setObject:planData.calories forKey:@"sportCaloriesPlan"];
    planData.progress=[NSNumber numberWithInt:0];
    [sportPlan setObject:planData.progress forKey:@"planCompleteProgress"];
    [sportPlan setObject:planData.sportGeoPointDescription forKey:@"sportGeoPointDescription"];
    [sportPlan setObject:planData.strength forKey:@"strength"];
    [sportPlan setObject:[mySettingData objectForKey:@"CurrentUserName"] forKey:@"userObjectId"];
    [sportPlan saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [sportPlan saveEventually];
        if (!error) {
            planData.objectId=sportPlan.objectId;
            [self.dataDelegate refreshTableView];
        }
    }];
    sportPlan=nil;
}


- (void)touchLocate{

    NSDictionary *locInfo=[_mapView returnLocationInfo];
    CLLocation *loc=[locInfo objectForKey:@"location"];
    if (loc) {
        [_mapView setCenterCoord:loc.coordinate];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
