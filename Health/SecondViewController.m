//
//  SecondViewController.m
//  Health
//
//  Created by GeoBeans on 14-5-14.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import "SecondViewController.h"
#import "RTDoctor.h"
#import "RTHeadDisease.h"
#import "RTLegDisease.h"
#import "RTHumanBodySearchView.h"
#import "RTBreastDisease.h"
#import "RTArmDisease.h"
#import "RTAbdomenDisease.h"
#import "RTHandDisease.h"
#import "RTNeckDisease.h"
#import "RTMedication.h"
#import "AVIllness.h"
@interface SecondViewController ()<UITableViewDataSource, UITableViewDelegate,UIGestureRecognizerDelegate,UISearchBarDelegate,UISearchDisplayDelegate>
{
  
}

  -(void) loadDetailView:(UIViewController *)destinationViewControllor;


@property (nonatomic, retain)	UIView* scrollableView;
@property (strong, nonatomic) UIPanGestureRecognizer* panGesture;



//数据存储数组

@property (nonatomic,strong)NSArray *doctorArray;
@property(nonatomic,strong)NSMutableArray *filteredAll;
@property(nonatomic,strong)NSArray *headDiseaseArray;
@property(nonatomic,strong)NSArray *legDiseaseArray;
@property(nonatomic,strong)NSMutableArray *filteredDiseaseArray;

@property(nonatomic,strong)NSArray *armDiseaseArray;
@property(nonatomic,strong)NSArray *breastDiseaseArray;
@property(nonatomic,strong)NSArray *handDiseaseArray;
@property(nonatomic,strong)NSArray *neckDiseaseArray;
@property(nonatomic,strong)NSArray *abdomenDiseaseArray;
@property(nonatomic,strong)NSMutableArray *AllContextArray;

@property(nonatomic,strong)NSArray *medicationArray;

@end

@implementation SecondViewController


-(void)viewDidDisappear:(BOOL)animated{
    
    for(UIView* subView in self.view.subviews)
    {
    
        [subView removeFromSuperview];
    }
    [self.view addSubview:self.navigationbar];
    self.backToThirdViewBtn.enabled=NO;
    self.backToThirdViewBtn.title=nil;
    [self.view addSubview:self.TitleLabel];
    [self.view addSubview:self.thirdView];
    
}

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
    self.searchDisplayController.searchResultsTableView.tag=10004;
    //Disease 示范数据
    
    AVQuery *queryIllness=[AVIllness query];
    queryIllness.limit=10;
//    [queryIllness selectKeys:@[@"name", @"info"]];
    [queryIllness findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            for (AVIllness *i in objects) {
                NSLog(@"%@",i.name);
            }
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }
    ];
    
    _medicationArray=[NSArray arrayWithObjects:
                      [RTMedication diseaseNewDisease:@"OTC" name:@"莲花清瘟胶囊"],
                      [RTMedication diseaseNewDisease:@"OTC" name:@"竹叶青"],
                      [RTMedication diseaseNewDisease:@"OTC" name:@"云南白药"],
                      [RTMedication diseaseNewDisease:@"处方药" name:@"阿莫西林"],
                      [RTMedication diseaseNewDisease:@"OTC" name:@"念慈庵糖浆"],
                      [RTMedication diseaseNewDisease:@"处方药" name:@"青霉素"],
                      [RTMedication diseaseNewDisease:@"处方药" name:@"乙酰胺缓释片"],
                      [RTMedication diseaseNewDisease:@"OTC" name:@"维生素B"],
                      nil];
    
    
    
    _abdomenDiseaseArray=[NSArray arrayWithObjects:
                          [RTAbdomenDisease abdomenDiseaseOfCategory:@"危险" name:@"阑尾炎"],
                          [RTAbdomenDisease abdomenDiseaseOfCategory:@"危险" name:@"直肠炎"],
                          [RTAbdomenDisease abdomenDiseaseOfCategory:@"危险" name:@"胃炎"],
                          [RTAbdomenDisease abdomenDiseaseOfCategory:@"危险" name:@"胆囊炎"],
                          [RTAbdomenDisease abdomenDiseaseOfCategory:@"危险" name:@"胆囊息肉"],
                          [RTAbdomenDisease abdomenDiseaseOfCategory:@"危险" name:@"妇科炎症"],
                          [RTAbdomenDisease abdomenDiseaseOfCategory:@"危险" name:@"消化不良"],
                          [RTAbdomenDisease abdomenDiseaseOfCategory:@"危险" name:@"胃胀"],
                          [RTAbdomenDisease abdomenDiseaseOfCategory:@"危险" name:@"胃癌"],
                          [RTAbdomenDisease abdomenDiseaseOfCategory:@"危险" name:@"胃酸过多"],
                          [RTAbdomenDisease abdomenDiseaseOfCategory:@"危险" name:@"胰腺癌"],
                          nil];
    
    _armDiseaseArray=[NSArray arrayWithObjects:
                      [RTArmDisease armDiseaseOfCategory:@"一般" name:@"上肢骨折"],
                      nil];
    
    _handDiseaseArray=[NSArray arrayWithObjects:
                       [RTHandDisease handDiseaseOfCategory:@"一般" name:@"指关节炎"],
                       [RTHandDisease handDiseaseOfCategory:@"轻微" name:@"鸡眼"],
                       [RTHandDisease handDiseaseOfCategory:@"一般" name:@"灰指甲"],
                       [RTHandDisease handDiseaseOfCategory:@"危险" name:@"指骨折"],
                       nil];
    
    _breastDiseaseArray=[NSArray arrayWithObjects:
                         [RTBreastDisease breastDiseaseOfCategory:@"危险" name:@"心脏病"],
                         [RTBreastDisease breastDiseaseOfCategory:@"危险" name:@"肺炎"],
                         [RTBreastDisease breastDiseaseOfCategory:@"危险" name:@"肺结核"],
                         [RTBreastDisease breastDiseaseOfCategory:@"危险" name:@"呼吸系统疾病"],
                         [RTBreastDisease breastDiseaseOfCategory:@"危险" name:@"心血管疾病"],
                         nil];
    
    _neckDiseaseArray=[NSArray arrayWithObjects:
                       [RTNeckDisease diseaseNewDisease:@"危险" name:@"颈椎病"],
                       [RTNeckDisease diseaseNewDisease:@"危险" name:@"甲状腺疾病"],
                       [RTNeckDisease diseaseNewDisease:@"危险" name:@"淋巴系统疾病"],
                       [RTNeckDisease diseaseNewDisease:@"轻微" name:@"咽喉肿痛"],
                       [RTNeckDisease diseaseNewDisease:@"一般" name:@"上呼吸道疾病"],
                       [RTNeckDisease diseaseNewDisease:@"危险" name:@"肩周炎"],
                       nil];
    _headDiseaseArray=[NSArray arrayWithObjects:
                       [RTHeadDisease headDiseaseOfCategory:@"一般" name:@"Headache"],
                       [RTHeadDisease headDiseaseOfCategory:@"轻微" name:@"头皮痒"],
                       [RTHeadDisease headDiseaseOfCategory:@"轻微" name:@"偏头痛"],
                       [RTHeadDisease headDiseaseOfCategory:@"危险" name:@"脑血栓"],
                       [RTHeadDisease headDiseaseOfCategory:@"危险" name:@"中风"],
                       [RTHeadDisease headDiseaseOfCategory:@"危险" name:@"脑溢血"],
                       [RTHeadDisease headDiseaseOfCategory:@"危险" name:@"脑瘤"],
                       [RTHeadDisease headDiseaseOfCategory:@"轻微" name:@"牙周炎"],
                       
                       nil];
    _legDiseaseArray=[NSArray arrayWithObjects:
                      [RTLegDisease legDiseaseOfCategory:@"一般" name:@"膝盖积水"],
                      [RTLegDisease legDiseaseOfCategory:@"一般" name:@"大腿痛"],
                      [RTLegDisease legDiseaseOfCategory:@"危险" name:@"半月板断裂"],
                      [RTLegDisease legDiseaseOfCategory:@"一般" name:@"小腿骨折"],
                      [RTLegDisease legDiseaseOfCategory:@"一般" name:@"韧带撕裂"],
                      nil];
    
    
    
    
    //doctor 示范数据
    _doctorArray=[NSArray arrayWithObjects:
                  [RTDoctor doctorOfCategory:@"内科" name:@"王建国"],
                  [RTDoctor doctorOfCategory:@"外科" name:@"李建军"],
                  [RTDoctor doctorOfCategory:@"骨科" name:@"张大民"],
                  [RTDoctor doctorOfCategory:@"内科" name:@"王为民"],
                  [RTDoctor doctorOfCategory:@"妇科" name:@"李利"],
                  [RTDoctor doctorOfCategory:@"神经科" name:@"林日"],
                  [RTDoctor doctorOfCategory:@"皮肤科" name:@"李国庆"],
                  [RTDoctor doctorOfCategory:@"外科" name:@"张纸中"],
                  [RTDoctor doctorOfCategory:@"内科" name:@"郭明义"],
                  [RTDoctor doctorOfCategory:@"外科" name:@"杨元利"],
                  [RTDoctor doctorOfCategory:@"内科" name:@"张天一"],
                  [RTDoctor doctorOfCategory:@"口腔科" name:@"张增长"],
                  [RTDoctor doctorOfCategory:@"内科" name:@"Tom"],
                  [RTDoctor doctorOfCategory:@"外科" name:@"Wilimas"],
                  [RTDoctor doctorOfCategory:@"内科" name:@"JAMES"],
                  [RTDoctor doctorOfCategory:@"口腔科" name:@"Lady GaGa"],
                  nil];
    
    
    
    //初始化全文搜索数组数组，使它和NSArray大小一样
    self.AllContextArray=[NSMutableArray arrayWithArray:self.doctorArray];
    [self.AllContextArray addObjectsFromArray:self.headDiseaseArray];
    [self.AllContextArray addObjectsFromArray:self.neckDiseaseArray];
    [self.AllContextArray addObjectsFromArray:self.armDiseaseArray];
    [self.AllContextArray addObjectsFromArray:self.handDiseaseArray];
    [self.AllContextArray addObjectsFromArray:self.legDiseaseArray];
    [self.AllContextArray addObjectsFromArray:self.abdomenDiseaseArray];
    [self.AllContextArray addObjectsFromArray:self.breastDiseaseArray];
    [self.AllContextArray addObjectsFromArray:self.medicationArray];
//    self.filteredAll= [NSMutableArray arrayWithCapacity:[self.doctorArray count]];
    self.filteredAll=[NSMutableArray arrayWithArray:self.doctorArray];
    
    
    //初始化疾病数组大小
    self.filteredDiseaseArray=[NSMutableArray arrayWithCapacity:1];
    
    [self.tableView reloadData];
    
   
    
    
    
    [self.searchDisplayController setDelegate:self];
    [self.searchDisplayController setSearchResultsDataSource:self];
    [self.searchDisplayController setSearchResultsDelegate:self];
    

    
    
    // Do any additional setup after loading the view from its nib.
    
    [self.tableView setDelegate:self];
	[self.tableView setDataSource:self];
    [self.tableView setFrame:CGRectMake(0, 57, 320, 400)];
    [self.tableView removeFromSuperview];
    
//    [self.thirdView setFrame:CGRectMake(0, 64, 320, 464)];
    [self.view addSubview:self.thirdView];
    self.thirdView.frame=CGRectMake(0, 64, 320,464);
    
    
    [self.HumanSearchResultView setFrame:CGRectMake(0, 64, 320,464)];
    
    
    [self.MedicationView setFrame:CGRectMake(0, 57, 320, 400)];
    [self.DiseaseView setFrame:CGRectMake(0, 57, 320, 400)];
    //    UIImageView *bkgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 64, 320, 504)];
    //    [bkgView setImage:[UIImage imageNamed:@"Window Background@2x.png"]];
    //    self.tableView.backgroundView=bkgView;
   
   
    
	//改变搜索框颜色

    self.searchbar.delegate=self;
    for (UIView *subView in self.searchbar.subviews)
    {
        for (UIView *secondLevelSubview in subView.subviews){
            if ([secondLevelSubview isKindOfClass:[UITextField class]])
            {
                UITextField *searchBarTextField = (UITextField *)secondLevelSubview;
                
                //set font color here
                searchBarTextField.textColor = [UIColor blackColor];
                
                break;
            }
            if ([secondLevelSubview isKindOfClass:NSClassFromString(@"UISearchBarBackground")])
                    {
                            [secondLevelSubview removeFromSuperview];
                            break;
                        }
        }
    }
    
//    self.searchbar.backgroundColor=[UIColor Color];
    
//    for (UIView *subview in self.searchbar.subviews)
//    {
//        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")])
//        {
//            [subview removeFromSuperview];
//            break;  
//        }   
//    }
////
    
    
//    [self.searchView setFrame:CGRectMake(0, 0, 250, 44)];
    
//    [self.searchbar setFrame:CGRectMake(0, 0, 250, 44)];
    

    [self.navigationbar setFrame:CGRectMake(0, 0, 320, 64)];
   
    //    [self.navigationbar setBackgroundColor: [UIColor colorWithRed:164/255.0 green:164/255.0 blue:0/255.0 alpha:1]];
    //[self.navigationbar setBackgroundColor:[UIColor darkGrayColor]];
    self.navigationbar.translucent=YES;
  
	// Just call this line to enable the scrolling navbar
//	[self followScrollView:self.tableView];
    
    //regist target-action for segmented Control
//    [self.segmentedBtn setFrame:CGRectMake(68, 0, 185, 29)];
    [self.segmentedBtn  addTarget:self
                                action:@selector(searchTypeChange:)
                      forControlEvents:UIControlEventValueChanged];
    
    //添加navigationbar
    self.navigationbar.delegate=self;
    
    self.backToThirdViewBtn.enabled=NO;
    self.backToThirdViewBtn.title=nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rowcount=0;
    switch (tableView.tag) {
        case 10001:
            rowcount=[self.doctorArray count];
           
            break;
        case 10002:
            rowcount=[self.medicationArray count];
            
            break;
        case 10003:
            rowcount=[self.filteredDiseaseArray count];
            
            break;
        case 10004:
           rowcount=[self.filteredAll count];
            return rowcount;
        default:
            rowcount=0;
            break;
    }
    return rowcount+1;
}

//改变cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    static NSString *cellIndentifier;
    UITableViewCell *cell;
   
    switch (tableView.tag) {
        case 10001:
        
        {   cellIndentifier=@"doctorCell";
            cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if ([indexPath row]< self.doctorArray.count) {
                cell=nil;
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifier];
                }
                RTDoctor *doctor=nil;
                doctor=[self.doctorArray objectAtIndex:indexPath.row];
                cell.textLabel.text = doctor.name;
                cell.detailTextLabel.text=doctor.category;
                [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
                
            }
            //分页显示按钮  以下类似
            else
            {
                NSLog(@"selectedIndex:%d",indexPath.row);
                cell=nil;
                if (!cell) {
                   cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
                }
                
                cell.textLabel.text=@"点击加载更多";
                [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
            
            }
            
            break;
            
        
        }
        case 10002:
            
        {   cellIndentifier=@"medicationCell";
            cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if ([indexPath row]<self.medicationArray.count) {
                cell=nil;
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifier];
                }
                
                RTMedication *doctor=nil;
                
                
                doctor=[self.medicationArray objectAtIndex:indexPath.row];
                cell.textLabel.text = doctor.name;
                cell.detailTextLabel.text=doctor.info;
                [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            }
            else
            {
                NSLog(@"selectedIndex:%d",indexPath.row);
                cell=nil;
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
                }
                
                
                cell.textLabel.text=@"点击加载更多";
                
                [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
                
            }
            break;
            
            
        }
            
            
            case 10003:
            
        {
            cellIndentifier=@"diseaseCell";
            cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            
            if ([indexPath row]<self.filteredDiseaseArray.count) {
                
            
                cell=nil;
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifier];
                }
                
                RTHandDisease *doctor=nil;
                
                
                
                doctor=[self.filteredDiseaseArray objectAtIndex:indexPath.row];
                
                
                
                cell.textLabel.text = doctor.name;
                cell.detailTextLabel.text=doctor.info;
                
                
                [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            }
            else
            {
                NSLog(@"selectedIndex:%d",indexPath.row);
                cell=nil;
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
                }
                
                cell.textLabel.text=@"点击加载更多";
                
                [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
                
                
            }
            break;
        }
            case 10004:
        {
            cellIndentifier=@"doctorCell";
            cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            cell=nil;
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifier];
            }
            
            RTDoctor *doctor=nil;
            
            
            doctor=[self.filteredAll objectAtIndex:indexPath.row];
            cell.textLabel.text = doctor.name;
            cell.detailTextLabel.text=doctor.info;
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            
            
            
            
            break;
            
            
        }
        default:
            break;
        
    }
    
    if ([cell.detailTextLabel.text isEqual:@"危险"]) {
        cell.detailTextLabel.shadowColor=[UIColor redColor];
    }
    if ([cell.detailTextLabel.text isEqual:@"一般"]) {
        cell.detailTextLabel.shadowColor=[UIColor yellowColor];
    }
    if ([cell.detailTextLabel.text isEqual:@"轻微"]) {
        cell.detailTextLabel.shadowColor=[UIColor colorWithRed:130.0/255.0 green:190.0/255.0 blue:20.0/255.0 alpha:1.0];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    return cell;
}

-(void) loadDetailView:(UIViewController *)destinationViewControllor{

   
    [UIView beginAnimations:@"view flip" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView transitionWithView:self.view
                      duration:0.2
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{ [self.view addSubview:destinationViewControllor.view];  }
                    completion:NULL];
    [UIView commitAnimations];

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 切入详细视图
   
  
        
 
    
    switch (tableView.tag) {
            
        case 10001:
            if (!rtSndDoctorDetailViewController) {
                rtSndDoctorDetailViewController=[[RTSndDoctorDetailViewController alloc]init];
                
            }
            
            [self loadDetailView:rtSndDoctorDetailViewController];
            break;
        case 10002:
            if (!rtSndMedicationViewController) {
                rtSndMedicationViewController=[[RTSndMedicationViewController alloc]init];
            }
            [self loadDetailView:rtSndMedicationViewController];
            break;
        case 10003:
            if (!rtDiseaseViewController) {
                rtDiseaseViewController=[[RTDiseaseViewController alloc]init];
                
            }
            [self loadDetailView:rtDiseaseViewController];
            break;
        case 10004:
            break;
            
        default:
            break;
    }
    
    rightNowView=self.HumanSearchResultView;
    
//    [self loadDetailView];
//    [[tableView cellForRowAtIndexPath:indexPath] setSelectionStyle:UITableViewCellSelectionStyleNone];
//    [self performSegueWithIdentifier:@"candyDetail" sender:tableView];
}






- (IBAction)searchTypeChange:(id)sender {
    switch (self.segmentedBtn.selectedSegmentIndex) {
        case 0:
            NSLog(@"%d",0);
            [self.tableView removeFromSuperview];
            [self.MedicationView removeFromSuperview];
            [self.HumanSearchResultView addSubview:self.DiseaseView];
            break;
        case 1:
            [self.tableView removeFromSuperview];
            [self.DiseaseView removeFromSuperview];
            [self.HumanSearchResultView addSubview:self.MedicationView];
           NSLog(@"%d",1);
            break;
        case 2:
            NSLog(@"%d",2);
            [self.DiseaseView removeFromSuperview];
            [self.MedicationView removeFromSuperview];
            [self.HumanSearchResultView addSubview:self.tableView];
            break;
        default:
            break;
    }
    
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

//param mark   searchBar delegate method

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    self.showSearchBarBtn.enabled=YES;
    self.navigationItem.rightBarButtonItem=self.showSearchBarBtn;
//    [self.searchView removeFromSuperview];
    self.navigationItem.titleView=nil;
    self.TitleLabel.hidden=NO;
    
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    
  
    [self.searchbar resignFirstResponder];
    
}



#pragma mark content Filtering
-(void)filterContentForSearchText:(NSString *)searchText scope:(NSString*)scope
{
   //先根据搜索栏内容和范围更新过滤后的数组。
    //然后将过滤后的数组清空
    [self.filteredAll removeAllObjects];
    //用NSPredicate来过滤数组
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchText];
    self.filteredAll=[NSMutableArray arrayWithArray:[self.AllContextArray filteredArrayUsingPredicate:predicate]];

}

#pragma mark-UISearchDisplayControllor Delegate Method
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    
//用户改变搜索字符串时，让列表的数据来源重新加载数据
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
     return YES;

}
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
    {
        [self filterContentForSearchText:self.searchDisplayController.searchBar.text  scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
        return YES;
        
    
    }


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







//改变第三个试图呈现内容
-(void)changeFilerDiseaseArray:(NSArray *)contentArray
{
    [self.filteredDiseaseArray removeAllObjects];
    [self.filteredDiseaseArray addObjectsFromArray:contentArray];
    
    
}






- (IBAction)headTrouched:(id)sender {
   
    
    [self.thirdView removeFromSuperview];
    
    //animation
    [UIView beginAnimations:@"view flip" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView transitionWithView:self.view
                      duration:0.2
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                        [self.view addSubview:self.HumanSearchResultView];
                    }
                    completion:NULL];
    [UIView commitAnimations];
    
   //enabled backToThirdViewBtn
    self.backToThirdViewBtn.enabled=YES;
    self.backToThirdViewBtn.title=@"Back";
    self.Theme.text=@"Head";
    
    
    //改变呈现内容
    [self changeFilerDiseaseArray:self.headDiseaseArray];
    
    [self.DiseaseView reloadData];
    
}

- (IBAction)neckTouched:(id)sender {[self.thirdView removeFromSuperview];
    
    //animation
    [UIView beginAnimations:@"view flip" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView transitionWithView:self.view
                      duration:0.2
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                        [self.view addSubview:self.HumanSearchResultView];
                    }
                    completion:NULL];
    [UIView commitAnimations];
    
    //enabled backToThirdViewBtn
    self.backToThirdViewBtn.enabled=YES;
    self.backToThirdViewBtn.title=@"Back";
    self.Theme.text=@"Neck";
    
    
    //改变呈现内容
    [self changeFilerDiseaseArray:self.neckDiseaseArray];
    
    [self.DiseaseView reloadData];
}

- (IBAction)armTouched:(id)sender {
    [self.thirdView removeFromSuperview];
    
    //animation
    [UIView beginAnimations:@"view flip" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView transitionWithView:self.view
                      duration:0.2
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                        [self.view addSubview:self.HumanSearchResultView];
                    }
                    completion:NULL];
    [UIView commitAnimations];
    
    //enabled backToThirdViewBtn
    self.backToThirdViewBtn.enabled=YES;
    self.backToThirdViewBtn.title=@"Back";
    self.Theme.text=@"Arm";
    
    
    //改变呈现内容
    [self changeFilerDiseaseArray:self.armDiseaseArray];
    
    [self.DiseaseView reloadData];
}

- (IBAction)abdomenTouched:(id)sender {
    [self.thirdView removeFromSuperview];
    
    //animation
    [UIView beginAnimations:@"view flip" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView transitionWithView:self.view
                      duration:0.2
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                        [self.view addSubview:self.HumanSearchResultView];
                    }
                    completion:NULL];
    [UIView commitAnimations];
    
    //enabled backToThirdViewBtn
    self.backToThirdViewBtn.enabled=YES;
    self.backToThirdViewBtn.title=@"Back";
    self.Theme.text=@"Abdomen";
    
    
    //改变呈现内容
    [self changeFilerDiseaseArray:self.abdomenDiseaseArray];
    
    [self.DiseaseView reloadData];
}

- (IBAction)handTouched:(id)sender {
    [self.thirdView removeFromSuperview];
    
    //animation
    [UIView beginAnimations:@"view flip" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView transitionWithView:self.view
                      duration:0.2
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                        [self.view addSubview:self.HumanSearchResultView];
                    }
                    completion:NULL];
    [UIView commitAnimations];
    
    //enabled backToThirdViewBtn
    self.backToThirdViewBtn.enabled=YES;
    self.backToThirdViewBtn.title=@"Back";
    self.Theme.text=@"Hand";
    
    
    //改变呈现内容
    [self changeFilerDiseaseArray:self.handDiseaseArray];
    
    [self.DiseaseView reloadData];
}

- (IBAction)legTouched:(id)sender {
    [self.thirdView removeFromSuperview];
    
    //animation
    [UIView beginAnimations:@"view flip" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView transitionWithView:self.view
                      duration:0.2
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                        [self.view addSubview:self.HumanSearchResultView];
                    }
                    completion:NULL];
    [UIView commitAnimations];
    
    //enabled backToThirdViewBtn
    self.backToThirdViewBtn.enabled=YES;
    self.backToThirdViewBtn.title=@"Back";
    self.Theme.text=@"Leg";
    
    
    //改变呈现内容
    [self changeFilerDiseaseArray:self.legDiseaseArray];
    
    [self.DiseaseView reloadData];
}

- (IBAction)breastTouched:(id)sender {
    [self.thirdView removeFromSuperview];
    
    //animation
    [UIView beginAnimations:@"view flip" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView transitionWithView:self.view
                      duration:0.2
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                        [self.view addSubview:self.HumanSearchResultView];
                    }
                    completion:NULL];
    [UIView commitAnimations];
    
    //enabled backToThirdViewBtn
    self.backToThirdViewBtn.enabled=YES;
    self.backToThirdViewBtn.title=@"Back";
    self.Theme.text=@"Breast";
    
    
    //改变呈现内容
    [self changeFilerDiseaseArray:self.breastDiseaseArray];
    
    [self.DiseaseView reloadData];
}


- (IBAction)bactToThirdView:(id)sender {
    [UIView beginAnimations:@"view flip" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView transitionWithView:self.view
                      duration:0.2
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{ [self.view addSubview:self.thirdView]; }
                    completion:NULL];
    [UIView commitAnimations];
    self.backToThirdViewBtn.enabled=NO;
    self.backToThirdViewBtn.title=nil;
}
- (IBAction)showToSearchBar:(id)sender {
//    self.navigationItem.title=nil;
//    [self.navigationItem.titleView addSubview:self.searchView];
     self.navigationItem.titleView=self.searchView;
    self.showSearchBarBtn.enabled=NO;
    self.navigationItem.rightBarButtonItem=nil;
    self.TitleLabel.hidden=YES;
    
    
}
@end
