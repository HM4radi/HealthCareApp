//
//  RTFamilyDetailViewController.m
//  Health
//
//  Created by Mac on 6/16/14.
//  Copyright (c) 2014 RADI Team. All rights reserved.
//

#import "RTFamilyDetailViewController.h"



@interface RTFamilyDetailViewController ()

@end

@implementation RTFamilyDetailViewController

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
   static NSString *Cellidentifier=@"TimelineCell2";
//    [self.view addSubview:self.timeLineTableView];
    // Do any additional setup after loading the view from its nib.
    UINib *nib = [UINib nibWithNibName:@"RTTimeLineTableViewCell" bundle:nil];
    [self.timeLineTableView registerNib:nib forCellReuseIdentifier:Cellidentifier];
   
   }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *Cellidentifier=@"TimelineCell2";
    static BOOL nibsRegistered = NO;
    
    static NSString *Cellidentifier=@"TimelineCell2";
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"RTTimeLineTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:Cellidentifier];
        nibsRegistered = YES;
    }
    RTTimeLineTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:Cellidentifier forIndexPath:indexPath];
//        cell.contentView.TitleLabel.text=@"早餐";
//        cell.contentView.SubTitleLabel.text=@"多吃蔬菜";
   
    
   


    
    return cell;

}

@end
