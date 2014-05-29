//
//  RTMsgDetailViewController.m
//  Health
//
//  Created by GeoBeans on 14-5-29.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import "RTMsgDetailViewController.h"



@interface RTMsgDetailViewController ()

@end

@implementation RTMsgDetailViewController

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
    [self.navBar setFrame:CGRectMake(0, 0, 320, 64)];
    [self.tableView setDelegate:self];
	[self.tableView setDataSource:self];
    [self.tableView setFrame:CGRectMake(0, 64, 320, 464)];//按照cell个数定义高度
    self.tableView.separatorColor=[UIColor colorWithRed:130.0/255.0 green:190.0/255.0 blue:20.0/255.0 alpha:1.0];

    //返回按钮1
    UIImageView *imgview=[[UIImageView alloc]initWithFrame:CGRectMake(10, 27, 30, 25)];
    [imgview setImage:[UIImage imageNamed:@"back-master.png"]];
    [self.view insertSubview:imgview aboveSubview:self.navBar];
    UITapGestureRecognizer *backGesture1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchBack)];
    [imgview addGestureRecognizer:backGesture1];
    imgview.userInteractionEnabled=YES;
    
    msgArray=[[NSMutableArray alloc]init];
    msgArray = [NSMutableArray arrayWithObjects:
                [NSDictionary dictionaryWithObjectsAndKeys:@"每天十个时刻如何补水最养生", @"title",@"对于喝水，喝多都是渴了就喝，这虽然也没有错，但如果能够掌握住喝水的学问，按照最佳的时间段来喝，那不仅仅能解渴，还能排毒养生防病呢？那么，一天中喝水的最佳时间是什么呢？下面，小编告诉你一天中最该喝水的十个时刻。", @"content",@"hs.jpg", @"imagename", nil],
                [NSDictionary dictionaryWithObjectsAndKeys:@"常吃12种蔬菜对养肝大有裨益", @"title",@"阴虚证：潮热、盗汗、手足心热、贪凉怕热、消瘦、口干咽燥、喜冷饮、小便短赤、大便干结、舌红少苔、脉细数无力。", @"content",@"sc.jpg", @"imagename", nil],
                [NSDictionary dictionaryWithObjectsAndKeys:@"五一小长假过后吃什么排毒快", @"title",@"假期刚过，您是否在假期中因为亲朋好友相聚免不了大吃大喝呢？事先制定的减肥计划可能又没有付诸实施。而假期中因为不适量饮食以及作息的改变可能会令你体内的毒素沉积。", @"content",@"wuyi.jpg", @"imagename", nil],
                [NSDictionary dictionaryWithObjectsAndKeys:@"掉头发或许预示5种致命疾病", @"title",@"人体需要铁质帮助生成红细胞，以便向全身输送氧。缺铁会导致贫血，红细胞因此减少，头皮得到的血氧量也随之下降。", @"content",@"dtf.jpg", @"imagename", nil],
                [NSDictionary dictionaryWithObjectsAndKeys:@"春季：心情焦虑喝一杯菊花茶", @"title",@"美国俄亥俄州立大学一项研究发现，补充欧米伽3脂肪酸可以使焦虑减轻20%。新研究负责人马萨贝鲁里博士表示，经常食用富含欧米伽3脂肪酸的三文鱼、金枪鱼、鲭鱼等深海肥鱼，有助于缓解焦虑情绪。", @"content",@"jhc.jpg", @"imagename", nil],
                nil];
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

//*********************tableView********************//

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static BOOL nibsRegistered = NO;
    
    static NSString *Cellidentifier=@"cell2";
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"RTMsgDetailTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:Cellidentifier];
        nibsRegistered = YES;
    }
    
    RTMsgDetailTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:Cellidentifier forIndexPath:indexPath];
	NSUInteger row=[indexPath row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSDictionary *dic=[msgArray objectAtIndex:row];
    UIImage *icon = [UIImage imageNamed:[dic objectForKey:@"imagename"]];
    CGSize itemSize = CGSizeMake(64, 64);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO ,0.0);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [icon drawInRect:imageRect];
    
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    //cell.imageView.image=[UIImage imageNamed:[dic objectForKey:@"imagename"]];
    cell.titleLabel.text=[dic objectForKey:@"title"];
    cell.contentLabel.text=[dic objectForKey:@"content"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 5;
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
    //[self loadDetailView];
    [[tableView cellForRowAtIndexPath:indexPath] setSelectionStyle:UITableViewCellSelectionStyleNone];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
