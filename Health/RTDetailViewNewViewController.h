//
//  RTDetailViewNewViewController.h
//  Health
//
//  Created by Mac on 6/17/14.
//  Copyright (c) 2014 RADI Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LightMenuBarDelegate.h"
#import "LightMenuBar.h"
#import "PNChart.h"

@interface RTDetailViewNewViewController : UIViewController<LightMenuBarDelegate>
{

    UIImageView * portraitView;
    PNChart * lineChart ;
}


@property (strong, nonatomic) IBOutlet UIButton *moreInfoBtn;

- (IBAction)moreInfoAction:(id)sender;



@property (strong, nonatomic) IBOutlet UISegmentedControl *dayAndWeekSegment;
- (IBAction)dayAndWeekSegAction:(id)sender;



- (IBAction)makeAcal:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *data1Label;
@property (strong, nonatomic) IBOutlet UILabel *data2Label;
@property (strong, nonatomic) IBOutlet UILabel *data3Label;


@property (strong, nonatomic) IBOutlet UIButton *AlertBtn;
@property (strong, nonatomic) IBOutlet UIButton *addReminderBtn;
@property (strong, nonatomic) IBOutlet UIButton *sendMessageBtn;
@property (strong, nonatomic) IBOutlet UIButton *callBtn;
@property (strong, nonatomic) IBOutlet UIView *friendTodaysGoalView;
@property (strong, nonatomic) IBOutlet UIView *friendBriefChat;
@property (strong, nonatomic) IBOutlet UIView *friendsBriefProfieView;

- (IBAction)sendMessage:(id)sender;

- (IBAction)addReminder:(id)sender;
- (IBAction)addAlert:(id)sender;

-(void)setCurrentSelectedIndex:(NSUInteger) i;

@end
