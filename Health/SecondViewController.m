//
//  SecondViewController.m
//  Health
//
//  Created by GeoBeans on 14-5-14.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()<UITableViewDataSource, UITableViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, retain)	UIView* scrollableView;
@property (strong, nonatomic) UIPanGestureRecognizer* panGesture;

@end

@implementation SecondViewController

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
    
    [self.tableView setDelegate:self];
	[self.tableView setDataSource:self];
    [self.tableView setFrame:CGRectMake(0, 108, 320, 460)];
//    UIImageView *bkgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 64, 320, 504)];
//    [bkgView setImage:[UIImage imageNamed:@"Window Background@2x.png"]];
//    self.tableView.backgroundView=bkgView;
    
    [self.searchbar setFrame:CGRectMake(0, 64, 320, 44)];
    searchbarY=64;
	[self.searchbar setTintColor:[UIColor blackColor]];
    [self.navigationbar setFrame:CGRectMake(0, 0, 320, 64)];
    
//    [self.navigationbar setBackgroundColor: [UIColor colorWithRed:164/255.0 green:164/255.0 blue:0/255.0 alpha:1]];
    //[self.navigationbar setBackgroundColor:[UIColor darkGrayColor]];
    self.navigationbar.translucent=NO;
    
	// Just call this line to enable the scrolling navbar
	[self followScrollView:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 20;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Identifier"];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Identifier"];
	}
	
	cell.textLabel.text = @[@"Awesome content", @"Great content", @"Amazing content", @"Ludicrous content"][arc4random()%4];
    
	return cell;
}

- (void)followScrollView:(UIView*)scrollableView
{
	self.scrollableView = scrollableView;
	
	self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
	[self.panGesture setMaximumNumberOfTouches:1];
	
	[self.panGesture setDelegate:self];
	[self.scrollableView addGestureRecognizer:self.panGesture];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
	return YES;
}

- (void)handlePan:(UIPanGestureRecognizer*)gesture
{
    
	CGPoint translation = [gesture translationInView:[self.scrollableView superview]];
	
	if (translation.y < 0) {
        
        if (searchbarY+translation.y>=20) {
            [self.searchbar setFrame:CGRectMake(0, searchbarY+translation.y, 320, 44)];
            [self.tableView setFrame:CGRectMake(0, searchbarY+translation.y+44, 320, 528-(searchbarY+translation.y))];
        }else {
            [self.searchbar setFrame:CGRectMake(0, 20, 320, 44)];
            [self.tableView setFrame:CGRectMake(0, 64, 320, 528)];
            
        }
	}
	
	if (translation.y > 0) {
 
        if (searchbarY+translation.y<=64) {
            [self.searchbar setFrame:CGRectMake(0, searchbarY+translation.y, 320, 44)];
            [self.tableView setFrame:CGRectMake(0, searchbarY+translation.y+44, 320, 528-(searchbarY+translation.y))];
        }else {
            [self.searchbar setFrame:CGRectMake(0, 64, 320, 44)];
            [self.tableView setFrame:CGRectMake(0, 108, 320, 460)];
        }
	}
	
    
	if ([gesture state] == UIGestureRecognizerStateEnded) {
		searchbarY = self.searchbar.frame.origin.y;
	}
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
