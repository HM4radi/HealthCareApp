//
//  RTPillsViewController.m
//  Health
//
//  Created by GeoBeans on 14-5-27.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import "RTPillsViewController.h"

@interface RTPillsViewController ()

@end

@implementation RTPillsViewController

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
    [self.addNavBar setFrame:CGRectMake(0, 0, 320, 64)];
    //self.navLabel1.frame=CGRectMake(100,32,120,20);
    self.navLabel2.frame=CGRectMake(100,32,120,20);

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    recordArray=[[NSMutableArray alloc]init];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    self.tableView.backgroundColor=[UIColor clearColor];
    

    cellNum=5;
    
    recordArray = [NSMutableArray arrayWithObjects:
                   [NSDictionary dictionaryWithObjectsAndKeys:@"格列吡嗪", @"name",@"11:30", @"time", @"前", @"before",@"1",@"number",@"1",@"complete", nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:@"立普妥", @"name",@"12:30", @"time", @"后", @"before",@"2",@"number",@"0",@"complete", nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:@"阿莫西林", @"name",@"12:30", @"time", @"后", @"before",@"2",@"number",@"0",@"complete", nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:@"格列吡嗪", @"name",@"17:30", @"time", @"前", @"before",@"1",@"number",@"0",@"complete", nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:@"立普妥", @"name",@"19:30", @"time", @"后", @"before",@"2",@"number",@"0",@"complete", nil],nil];
    
    self.pickView.dataSource=self;
    self.pickView.delegate=self;
    hour=[[NSArray alloc] initWithObjects:@"6时",@"7时",@"8时",@"9时",@"10时",@"11时",@"12时",@"13时",@"14时",@"15时",@"16时",@"17时",@"18时",@"19时",@"20时",@"21时",@"22时",@"23时",@"0时",@"1时",
          @"2时",@"3时",@"4时",@"5时",nil];
    minite=[[NSArray alloc] initWithObjects:@"00分",@"10分",@"20分",@"30分",@"40分",@"50分",nil];
    
    //textField
    self.nameField.delegate=self;
    self.nameField.tag=0;
    self.numField.delegate=self;
    self.numField.tag=1;
 
}


- (IBAction)touchBack:(id)sender {
    [UIView beginAnimations:@"view flip" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView transitionWithView:self.view.superview
                      duration:0.2
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{ [self.view removeFromSuperview];  }
                    completion:NULL];
    [UIView commitAnimations];
}
- (IBAction)add:(id)sender {
    [UIView beginAnimations:@"view flip" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView transitionWithView:self.view.superview
                      duration:0.2
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{ [self.view addSubview:self.addView];  }
                    completion:NULL];
    [UIView commitAnimations];
}

//- (void)add{
//    [UIView beginAnimations:@"view flip" context:nil];
//    [UIView setAnimationDuration:0.5];
//    [UIView transitionWithView:self.view.superview
//                      duration:0.2
//                       options:UIViewAnimationOptionTransitionFlipFromRight
//                    animations:^{ [self.view addSubview:self.addView];  }
//                    completion:NULL];
//    [UIView commitAnimations];
//}
- (IBAction)touchFinish:(id)sender {
    if (!currentName||!currentNum||!currentBeforeAfter||!currentHour||!currentMinute) {
        NSString *msg = @"请输入完整信息";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:msg
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }else
    {
        [recordArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:currentName, @"name",[NSString stringWithFormat:@"%@:%@",currentHour,currentMinute], @"time", currentBeforeAfter, @"before",currentNum,@"number",@"0",@"complete", nil]];
        cellNum++;
        [self.tableView reloadData];
        currentName=nil;
        currentNum=nil;
        currentBeforeAfter=nil;
        currentHour=nil;
        currentMinute=nil;
        
        [UIView beginAnimations:@"view flip" context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView transitionWithView:self.view.superview
                          duration:0.2
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        animations:^{ [self.addView removeFromSuperview];  }
                        completion:NULL];
        [UIView commitAnimations];
    }

}

//- (void)touchFinish{
//    if (!currentName||!currentNum||!currentBeforeAfter||!currentHour||!currentMinute) {
//        NSString *msg = @"请输入完整信息";
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                        message:msg
//                                                       delegate:nil
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil];
//        [alert show];
//    }else
//    {
//        [recordArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:currentName, @"name",[NSString stringWithFormat:@"%@:%@",currentHour,currentMinute], @"time", currentBeforeAfter, @"before",currentNum,@"number",@"0",@"complete", nil]];
//        cellNum++;
//        [self.tableView reloadData];
//        currentName=nil;
//        currentNum=nil;
//        currentBeforeAfter=nil;
//        currentHour=nil;
//        currentMinute=nil;
//        
//    [UIView beginAnimations:@"view flip" context:nil];
//    [UIView setAnimationDuration:0.5];
//    [UIView transitionWithView:self.view.superview
//                      duration:0.2
//                       options:UIViewAnimationOptionTransitionFlipFromLeft
//                    animations:^{ [self.addView removeFromSuperview];  }
//                    completion:NULL];
//    [UIView commitAnimations];
//    }
//}
- (IBAction)touchCancel:(id)sender {
    [UIView beginAnimations:@"view flip" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView transitionWithView:self.view.superview
                      duration:0.2
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{ [self.addView removeFromSuperview];  }
                    completion:NULL];
    [UIView commitAnimations];
}

//- (void)touchCancel{
//    [UIView beginAnimations:@"view flip" context:nil];
//    [UIView setAnimationDuration:0.5];
//    [UIView transitionWithView:self.view.superview
//                      duration:0.2
//                       options:UIViewAnimationOptionTransitionFlipFromLeft
//                    animations:^{ [self.addView removeFromSuperview];  }
//                    completion:NULL];
//    [UIView commitAnimations];
//
//}

//*********************tableView********************//

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static BOOL nibsRegistered = NO;
    
    static NSString *Cellidentifier=@"cell1";
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"RTPillsTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:Cellidentifier];
        nibsRegistered = YES;
    }
    
    RTPillsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:Cellidentifier forIndexPath:indexPath];
    NSUInteger row=[indexPath row]-1;
    cell.accessoryType=UITableViewCellAccessoryNone;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    if (row==-1) {
        cell.pillsName.text=@"药品名称";
        cell.pillsTime.text=@"服用时间";
        cell.pillsFood.text=@"餐前";
        cell.pillsNum.text=@"剂量";
        cell.pillsCmp.hidden=YES;
    }else{
        cell.pillsCmp.hidden=NO;
        NSDictionary *dic=[recordArray objectAtIndex:row];
        cell.pillsName.text=[dic objectForKey:@"name"];
        cell.pillsTime.text=[dic objectForKey:@"time"];
        cell.pillsFood.text=[dic objectForKey:@"before"];
        cell.pillsNum.text=[dic objectForKey:@"number"];
        if ([[dic objectForKey:@"complete"] isEqualToString:@"0"]) {
            cell.pillsCmp.on=true;
        }else{
            cell.pillsCmp.on=false;
        }
    }
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return cellNum+1;
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
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[[tableView cellForRowAtIndexPath:indexPath] setSelectionStyle:UITableViewCellSelectionStyleNone];
}

//*********************pickerView********************//
//  返回两列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

//  返回每一列的列表项数
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
    if (component == 0)
        return 24;
    else
    return 6;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    if (component == 0)
        return [hour objectAtIndex:row];
    else
    return [minite objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0)
        currentHour=[hour objectAtIndex:row];
    else
        currentMinute=[minite objectAtIndex:row];
}

//*********************textField********************//
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag==0) {
        currentName=textField.text;
    }else if (textField.tag==1)
        currentNum=textField.text;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.nameField resignFirstResponder];
    [self.numField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.nameField resignFirstResponder];
    [self.numField resignFirstResponder];
    return  YES;
}

//*********************segmented Control********************//
- (IBAction)beforeAfter:(id)sender {
    if (self.beforeAfter.selectedSegmentIndex==0) {
        currentBeforeAfter=@"前";
    }else if (self.beforeAfter.selectedSegmentIndex==1)
        currentBeforeAfter=@"后";
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
