//
//  RTLoginViewController.m
//  Health
//
//  Created by GeoBeans on 14-5-19.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import "RTLoginViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "RTUSERInfo.h"


#define ANIMATION_DURATION 0.3f

@interface RTLoginViewController ()

@end

@implementation RTLoginViewController
static  RTLoginViewController *thisController=nil;

+(id)shareLoginControllor
{
    if (thisController==nil) {
        thisController=[[RTLoginViewController alloc] initWithNibName:@"RTLoginViewController" bundle:nil];
    }
    return thisController;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void) viewWillAppear:(BOOL)animated{

    [self CheckCurrentUserAndLoadViewControllor];
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
        // Do any additional setup after loading the view from its nib.
        
        //AVOS Login subclass
        loginer=[[RTLoginBusiness alloc]init];
        
        
        NSDictionary *account1=[NSDictionary dictionaryWithObjectsAndKeys:@"aaaaaa",@"userNumber",@"12345678",@"passWord",@"1.jpg",@"userHead", nil];
        NSDictionary *account2=[NSDictionary dictionaryWithObjectsAndKeys:@"Lucas@163.com",@"userNumber",@"29843223",@"passWord",@"2.jpg",@"userHead", nil];
        
        NSDictionary *account3=[NSDictionary dictionaryWithObjectsAndKeys:@"Ray@Hotmail.com",@"userNumber",@"987654321",@"passWord",@"3.jpg",@"userHead", nil];
        
        _currentAccounts=[[NSMutableArray arrayWithObjects:account1,account2, account3,nil]retain];
        
        
        
        
        [_userLargeHead.layer setCornerRadius:CGRectGetHeight(_userLargeHead.bounds)/2];
        [_userLargeHead.layer setMasksToBounds:YES];
        
        
        _currentAccounts=[[NSMutableArray arrayWithObjects:account1,account2, account3,nil]retain];
        
        [self reloadAccountBox];
        
        self.login.userInteractionEnabled=YES;
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loginCheckOncloud)];
        [self.login addGestureRecognizer:tapGesture];
    
   
   
}

-(void)loginCheckOncloud{
    if (loginer.username==nil || loginer.pwd==nil) {
         self.loginInfoLabel.text=@"请输入用户信息";
    }
    else{
        [loginer login:loginer.username Pwd:loginer.pwd];
        if(loginer.isSucceed)
        {
            [self logIn];
            NSLog(@"loginer.isSucceed:Yes");
            self.loginInfoLabel.text=nil;
        }
        else
        {
            NSLog(@"loginer.isSucceed:No");
            self.loginInfoLabel.text=loginer.feedback;
            
            
            
        }
        
    }
  

}

- (IBAction)register:(id)sender {
    RTRegisterViewController* rgtVC=[[RTRegisterViewController alloc] initWithNibName:@"RTRegisterViewController" bundle:nil];
    [self presentViewController:rgtVC animated:YES completion:nil];
}





-(void)PushModalToMainView
{
    RTMainViewController* mainVC=[RTMainViewController shareMainViewControllor];
    //    [self presentModalViewController:mainVC animated:YES];
    [self presentViewController:mainVC animated:YES completion:nil];

}
-(void)logIn{
    
  
    [self PushModalToMainView];

    
}


- (IBAction)dropDown:(id)sender {
    if ([sender isSelected]) {
        
        [self hideAccountBox];
        
    }else
    {
        
        [self showAccountBox];
        
    }

}

-(void)showAccountBox
{
    [_dropButton setSelected:YES];
    CABasicAnimation *move=[CABasicAnimation animationWithKeyPath:@"position"];
    [move setFromValue:[NSValue valueWithCGPoint:CGPointMake(_moveDownGroup.center.x, _moveDownGroup.center.y)]];
    [move setToValue:[NSValue valueWithCGPoint:CGPointMake(_moveDownGroup.center.x, _moveDownGroup.center.y+_account_box.frame.size.height)]];
    [move setDuration:ANIMATION_DURATION];
    [_moveDownGroup.layer addAnimation:move forKey:nil];
    
    
    [_account_box setHidden:NO];
    
    //模糊处理
    [_userLargeHead setAlpha:0.5f];
    [_numberLabel setAlpha:0.5f];
    [_passwordLabel setAlpha:0.5f];
    [_userNumber setAlpha:0.5f];
    [_userPassword setAlpha:0.5f];
    
    CABasicAnimation *scale=[CABasicAnimation animationWithKeyPath:@"transform"];
    [scale setFromValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 0.2, 1.0)]];
    [scale setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    CABasicAnimation *center=[CABasicAnimation animationWithKeyPath:@"position"];
    [center setFromValue:[NSValue valueWithCGPoint:CGPointMake(_account_box.center.x, _account_box.center.y-_account_box.bounds.size.height/2)]];
    [center setToValue:[NSValue valueWithCGPoint:CGPointMake(_account_box.center.x, _account_box.center.y)]];
    
    CAAnimationGroup *group=[CAAnimationGroup animation];
    [group setAnimations:[NSArray arrayWithObjects:scale,center, nil]];
    [group setDuration:ANIMATION_DURATION];
    [_account_box.layer addAnimation:group forKey:nil];
    
    
    
    [_moveDownGroup setCenter:CGPointMake(_moveDownGroup.center.x, _moveDownGroup.center.y+_account_box.frame.size.height)];
    
}
-(void)hideAccountBox
{
    [_dropButton setSelected:NO];
    CABasicAnimation *move=[CABasicAnimation animationWithKeyPath:@"position"];
    [move setFromValue:[NSValue valueWithCGPoint:CGPointMake(_moveDownGroup.center.x, _moveDownGroup.center.y)]];
    [move setToValue:[NSValue valueWithCGPoint:CGPointMake(_moveDownGroup.center.x, _moveDownGroup.center.y-_account_box.frame.size.height)]];
    [move setDuration:ANIMATION_DURATION];
    [_moveDownGroup.layer addAnimation:move forKey:nil];
    
    [_moveDownGroup setCenter:CGPointMake(_moveDownGroup.center.x, _moveDownGroup.center.y-_account_box.frame.size.height)];
    [_userLargeHead setAlpha:1.0f];
    [_numberLabel setAlpha:1.0f];
    [_passwordLabel setAlpha:1.0f];
    [_userNumber setAlpha:1.0f];
    [_userPassword setAlpha:1.0f];
    
    CABasicAnimation *scale=[CABasicAnimation animationWithKeyPath:@"transform"];
    [scale setFromValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    [scale setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 0.2, 1.0)]];
    
    CABasicAnimation *center=[CABasicAnimation animationWithKeyPath:@"position"];
    [center setFromValue:[NSValue valueWithCGPoint:CGPointMake(_account_box.center.x, _account_box.center.y)]];
    [center setToValue:[NSValue valueWithCGPoint:CGPointMake(_account_box.center.x, _account_box.center.y-_account_box.bounds.size.height/2)]];
    
    CAAnimationGroup *group=[CAAnimationGroup animation];
    [group setAnimations:[NSArray arrayWithObjects:scale,center, nil]];
    [group setDuration:ANIMATION_DURATION];
    [_account_box.layer addAnimation:group forKey:nil];
    
    
    [_account_box performSelector:@selector(setHidden:) withObject:[NSNumber numberWithBool:NO] afterDelay:ANIMATION_DURATION];
}


-(void)reloadAccountBox
{
    for (UIView* view in _account_box.subviews) {
        if (view.tag!=20000) {
            [view removeFromSuperview];
        }
    }
    int count=(int)_currentAccounts.count;
    //图片之间的间距
    CGFloat insets = 0.0;
    
    
    //图片的宽度与背景的宽度
    CGFloat imageWidth=49,bgWidth=288,bgHeight=80;
    
    //根据账号数量对3的商来计算整个view高度的调整
    CGFloat newHeight;
    newHeight=((count-1)/3)*80+80;
    if (newHeight!=bgHeight) {
        [_account_box setFrame:CGRectMake(_account_box.frame.origin.x, _account_box.frame.origin.y, _account_box.frame.size.width, newHeight)];
    }
    
    CGFloat paddingTop=(bgHeight-imageWidth)/2;
    CGFloat paddingLeft=(320-bgWidth)/2;
    if (count >3) {
        insets=(bgWidth-imageWidth*3)/4;
    }else{
        //根据图片数量对3取模计算间距
        switch (count%3) {
            case 0:
                insets=(bgWidth-imageWidth*3)/4;
                
                break;
            case 1:
                insets=(bgWidth-imageWidth)/2;
                break;
            case 2:
                insets=(bgWidth-imageWidth*2)/3;
                break;
            default:
                break;
        }
    }
    
    
    
    for (int i=0;i<_currentAccounts.count;i++)
    {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(paddingLeft+insets+(i%3)*(imageWidth+insets), paddingTop+80*(i/3), imageWidth, imageWidth)];
        [button setBackgroundImage:[UIImage imageNamed:@"login_dropdown_avatar_border"] forState:UIControlStateNormal];
        [button.imageView setImage:[UIImage imageNamed:@"login_avatar"]];
        button.tag=10000+i;
        [button addTarget:self action:@selector(chooseAccount:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *headImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 45 , 45)];
        [headImage.layer setCornerRadius:3.0];
        [headImage setClipsToBounds:YES];
        [headImage setCenter:CGPointMake(button.center.x, button.center.y)];
        [headImage setImage:[UIImage imageNamed:[_currentAccounts[i] objectForKey:@"userHead"]]];
        [_account_box addSubview:headImage];
        [_account_box addSubview:button];
        
    }
}

- (void)chooseAccount:(UIButton*)button
{
    NSInteger accountIndex=button.tag-10000;
    [_userNumber setText:[[_currentAccounts objectAtIndex:accountIndex] objectForKey:@"userNumber"] ];
    [_userPassword setText:[[_currentAccounts objectAtIndex:accountIndex] objectForKey:@"passWord"]];
    [_userLargeHead setImage:[UIImage imageNamed:[[_currentAccounts objectAtIndex:accountIndex] objectForKey:@"userHead"]]];
    [self hideAccountBox];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_userNumber resignFirstResponder];
    [_userPassword resignFirstResponder];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_dropButton release];
    [_moveDownGroup release];
    [_account_box release];
    [_userNumber release];
    [_userPassword release];
    [_userLargeHead release];
    [_numberLabel release];
    [_passwordLabel release];
    [super dealloc];
}

- (IBAction)loginInput:(id)sender {
    NSString *username;
    NSString *pwd;
    username=self.userNumber.text;
    pwd=self.userPassword.text;
    
    if (username==nil|| pwd==nil) {
        NSLog(@"用户输入为空");
    }
    else
    {
        loginer.username=username;
        loginer.pwd=pwd;
    
    }
}

-(BOOL)CheckCurrentUserAndLoadViewControllor
{
    AVUser * currentUser = [AVUser currentUser];
    if (currentUser != nil) {
        NSLog(@"CurrentUser1:%@",currentUser.username);
        [self logIn];
        return YES;
    }
    else
    {
        NSLog(@"CurrentUser2:%@",currentUser.username);
        return NO;
    }
    
}


@end
