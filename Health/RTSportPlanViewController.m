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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.NavBar setFrame:CGRectMake(0, 0, 320, 64)];
    self.NavBar.translucent=YES;

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
        [dateFormatter2 setDateFormat:@"HH小时mm分"];
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
    }
    
    //返回按钮
    UIImageView *imgview1=[[UIImageView alloc]initWithFrame:CGRectMake(10, 27, 30, 25)];
    [imgview1 setImage:[UIImage imageNamed:@"back-master.png"]];
    [self.NavBar addSubview:imgview1];
    UITapGestureRecognizer *backGesture1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchBack)];
    [imgview1 addGestureRecognizer:backGesture1];
    imgview1.userInteractionEnabled=YES;
    
    //确认按钮
    UIImageView *imgview2=[[UIImageView alloc]initWithFrame:CGRectMake(280, 27, 30, 30)];
    [imgview2 setImage:[UIImage imageNamed:@"ok.png"]];
    [self.NavBar addSubview:imgview2];
    UITapGestureRecognizer *backGesture2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchOK)];
    [imgview2 addGestureRecognizer:backGesture2];
    imgview2.userInteractionEnabled=YES;

    
    self.selectRoute.tag=0;
    
    self.removeBtn.hidden=YES;
    
    routeCoord=[[NSArray alloc]init];
    
    //plandata
    planData=[RTPlanData shareInstance];
}


- (IBAction)selectRoute:(id)sender {
    if (self.selectRoute.tag==0) {
        [self.selectRoute setTitle:@"完成选择路线" forState:UIControlStateNormal];
        _mapView.selecting=YES;
        self.selectRoute.tag=1;
        self.removeBtn.hidden=NO;
    }else if (self.selectRoute.tag==1){
        [self.selectRoute setTitle:@"开始选择路线" forState:UIControlStateNormal];
        _mapView.selecting=NO;
        self.selectRoute.tag=0;
        self.removeBtn.hidden=YES;
        if (_mapView.routeCoord) {
            routeCoord=_mapView.routeCoord;
        }
    }
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
        }
        else if (timePicker.tag!=0){
            if (timePicker.tag==1) {
                NSString *dtString=[dateFormatter1 stringFromDate:[timePicker date]];
                self.startTimeLabel.text=dtString;
                planData.startTime=dtString;
            }else if (timePicker.tag==2){
                NSString *dtString=[dateFormatter2 stringFromDate:[timePicker date]];
                self.lastTimeLabel.text=dtString;
                planData.lastTime=dtString;
            }            
        }
    }
}

//*********************pickerView********************//
//  返回两列
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

- (void)touchBack{
    _mapView=nil;
    self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchOK{
    _mapView=nil;
    self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
