//
//  RTMsgViewController.m
//  Health
//
//  Created by GeoBeans on 14-5-28.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import "RTMsgViewController.h"

@interface RTMsgViewController ()

@end

@implementation RTMsgViewController

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
    
    [self.navBar setFrame:CGRectMake(0, 0, 320, 64)];
    [self.collectionView registerClass:[RTCollectionViewCell class] forCellWithReuseIdentifier:@"RTCollectionViewCell"];
    
    msgArray=[[NSMutableArray alloc]init];
    msgArray = [NSMutableArray arrayWithObjects:
                   [NSDictionary dictionaryWithObjectsAndKeys:@"养生", @"name",@"ys.jpg", @"imagename", nil],
                [NSDictionary dictionaryWithObjectsAndKeys:@"中医", @"name",@"zy.jpg", @"imagename", nil],
                [NSDictionary dictionaryWithObjectsAndKeys:@"慢性病", @"name",@"mxb.jpg", @"imagename", nil],
                [NSDictionary dictionaryWithObjectsAndKeys:@"感冒", @"name",@"gm.jpg", @"imagename", nil],
                [NSDictionary dictionaryWithObjectsAndKeys:@"颈椎健康", @"name",@"jzjk.jpg", @"imagename", nil],
                [NSDictionary dictionaryWithObjectsAndKeys:@"两性知识", @"name",@"lxzs.jpg", @"imagename", nil],
                [NSDictionary dictionaryWithObjectsAndKeys:@"男性健康", @"name",@"nxjk.jpg", @"imagename", nil],
                [NSDictionary dictionaryWithObjectsAndKeys:@"女性健康", @"name",@"nxjk1.jpg", @"imagename", nil],
                [NSDictionary dictionaryWithObjectsAndKeys:@"心理健康", @"name",@"xljk.jpg", @"imagename", nil],
                [NSDictionary dictionaryWithObjectsAndKeys:@"运动饮食", @"name",@"ydys.jpg", @"imagename", nil],
                [NSDictionary dictionaryWithObjectsAndKeys:@"孕妇健康", @"name",@"yfjk.jpg", @"imagename", nil],
                [NSDictionary dictionaryWithObjectsAndKeys:@"医学前沿", @"name",@"yxqy.jpg", @"imagename", nil],nil];
    
    self.collectionView.frame=CGRectMake(0, 64, 320, 504);
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    self.collectionView.backgroundColor=[UIColor clearColor];
}


//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 12;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RTCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"RTCollectionViewCell" forIndexPath:indexPath];
    
    NSUInteger row=[indexPath row];
    NSDictionary *dic=[msgArray objectAtIndex:row];
    
    if (dic) {
        //加载图片
        cell.imageView.image = [UIImage imageNamed:[dic objectForKey:@"imagename"]];
        //设置label文字
        cell.cellLabel.text = [dic objectForKey:@"name"];

    }
        cell.backgroundColor=[UIColor clearColor];
    return cell;
}

//定义每个UICollectionView 的大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake(80, 120);
//}

//定义每个UICollectionView 的 margin
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(2.5, 2.5, 2.5, 2.5);
//}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!detialView) {
        detialView=[[RTMsgDetailViewController alloc] init ];
    }
    [UIView beginAnimations:@"view flip" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView transitionWithView:self.view
                      duration:0.2
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{ [self.view addSubview:detialView.view];  }
                    completion:NULL];
    [UIView commitAnimations];
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
