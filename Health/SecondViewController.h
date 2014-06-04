//
//  SecondViewController.h
//  Health
//
//  Created by GeoBeans on 14-5-14.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "RTSndDoctorDetailViewController.h"
#import "RTSndMedicationViewController.h"
#import "RTDiseaseViewController.h"
#import <AVOSCloud/AVOSCloud.h>

@interface SecondViewController : UIViewController <UISearchBarDelegate,UISearchDisplayDelegate>{
    RTSndDoctorDetailViewController *rtSndDoctorDetailViewController;
    RTSndMedicationViewController *rtSndMedicationViewController;
    RTDiseaseViewController *rtDiseaseViewController;
    UIView *rightNowView;
    float searchbarY;
}


@property (strong, nonatomic) IBOutlet UILabel *TitleLabel;






@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedBtn;

@property (strong, nonatomic) IBOutlet UITableView *tableView;


@property (retain, nonatomic) IBOutlet UISearchBar *searchbar;

@property (retain, nonatomic) IBOutlet UINavigationBar *navigationbar;

@property (strong, nonatomic) IBOutlet UIView *MedicationView;

- (IBAction)searchTypeChange:(id)sender;

- (void)followScrollView:(UIView*)scrollableView;


@property (strong, nonatomic) IBOutlet UIView *searchView;



- (IBAction)showToSearchBar:(id)sender;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *showSearchBarBtn;



//thirdView and components
@property (strong, nonatomic) IBOutlet UIView *thirdView;

//thirdView Button  and Image

@property (strong, nonatomic) IBOutlet UIImageView *bodyImage;

@property (strong, nonatomic) IBOutlet UIButton *arm1;

@property (strong, nonatomic) IBOutlet UIButton *neck;

@property (strong, nonatomic) IBOutlet UIButton *head;

@property (strong, nonatomic) IBOutlet UIButton *breast;

@property (strong, nonatomic) IBOutlet UIButton *arm2;
@property (strong, nonatomic) IBOutlet UIButton *hand1;

@property (strong, nonatomic) IBOutlet UIButton *hand2;
@property (strong, nonatomic) IBOutlet UIButton *abdomen;
@property (strong, nonatomic) IBOutlet UIButton *leg;

- (IBAction)headTrouched:(id)sender;

- (IBAction)neckTouched:(id)sender;

- (IBAction)armTouched:(id)sender;

- (IBAction)abdomenTouched:(id)sender;
- (IBAction)handTouched:(id)sender;

- (IBAction)legTouched:(id)sender;
- (IBAction)breastTouched:(id)sender;


//HumanSearchView and components
@property (strong, nonatomic) IBOutlet UIView *HumanSearchResultView;
@property (strong, nonatomic) IBOutlet UITableView *DiseaseView;
@property (strong, nonatomic) IBOutlet UILabel *Theme;
@property (strong, nonatomic) IBOutlet UIImageView *titleImage;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *backToThirdViewBtn;
- (IBAction)bactToThirdView:(id)sender;




@end
