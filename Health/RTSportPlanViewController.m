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
    [self.sportSpeedView addGestureRecognizer:Gesture3];
    [Gesture3 view].tag=3;
    self.sportSpeedView.userInteractionEnabled=YES;
 
    
    sportType=[[NSMutableArray alloc]initWithObjects:@"跑步",@"步行",@"骑行",@"爬楼梯",@"乒乓球",@"羽毛球",@"篮球",@"足球",@"网球",@"健身操",@"游泳",  nil];
    
    if (!timePicker) {
        timePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0,30,320,100)];
        [timePicker setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
        [timePicker setDate:[NSDate date] animated:YES];
        [timePicker setMaximumDate:[NSDate date]];
        
        timePicker.tag=0;
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
}

- (void)showSelectView:(UITapGestureRecognizer *)sender{
    if ([sender view].tag==1) {
        if (timePicker.tag==1) {
            [timePicker removeFromSuperview];
            timePicker.tag=0;
        }
        actionView.title=@"请选择运动项目\n\n\n\n\n\n\n\n\n\n\n\n\n";
        [actionView addSubview:typePicker];
        [actionView showInView:self.view];
        typePicker.tag=1;
    }
    else if ([sender view].tag==2) {
        if (typePicker.tag==1) {
            [typePicker removeFromSuperview];
            typePicker.tag=0;
        }
        [timePicker setDatePickerMode:UIDatePickerModeDateAndTime];
        actionView.title=@"请选择起始时间\n\n\n\n\n\n\n\n\n\n\n\n\n";
        if (timePicker.tag==0) {
            [actionView addSubview:timePicker];
        }
        [actionView showInView:self.view];
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
        [actionView showInView:self.view];
        timePicker.tag=1;
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
    if (component == 0)
        NSLog(@"didselect");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
