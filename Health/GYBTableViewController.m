//
//  GYBTableViewController.m
//  TableView
//
//  Created by Mac on 5/17/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import "GYBTableViewController.h"
#import"GYBTableViewCell.h"
#import "DPMeterView.h"
#import "UIBezierPath+BasicShapes.h"
#import "GYBDetailViewController.h"

@interface GYBTableViewController ()
@property (nonatomic,strong)NSMutableDictionary *listItem;
@property (nonatomic,strong)NSMutableDictionary *Statue;
@property (nonatomic,strong)NSArray *key;


-(void)initNameDataDiction;
//-(void)initLocationData;
-(void)initStatusData;

@end

@implementation GYBTableViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
          }
    return self;
}

-(void)initStatusData
{
   static NSString *a = @"0.1";
   static NSString *b = @"0.5";
   static NSString *c = @"0.8";
   self.listItem = [NSMutableDictionary dictionary];
    
        //初始化nameLabel 状态字典
       [self.listItem setObject:a forKey:@"father"];
       [self.listItem setObject:b forKey:@"mother"];
       [self.listItem setObject:c forKey:@"son"];
    
    NSLog(@"%@",[self.listItem objectForKey:@"son"]);
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
//    GYBDetailViewController *detailViewController=[[GYBDetailViewController alloc]init];
//    
//    [self.navigationController pushViewController:detailViewController animated:YES];
//    NSLog(@"%d",indexPath.row);

}
//

//添加点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GYBDetailViewController *detailViewController=[[GYBDetailViewController alloc]initWithNibName:@"GYBDetailViewController" bundle:nil];
    detailViewController.navigationItem.title=[self.key objectAtIndex:indexPath.row];
//
//
UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                   style:UIBarButtonItemStylePlain target:nil action:nil];
    detailViewController.navigationItem.backBarButtonItem = backButton;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
//    NSLog(@"%d",indexPath.row);
    
}

#pragma mark- Star status  UI object

- (void)updateProgressWithDelta:(CGFloat)delta animated:(BOOL)animated
{
    NSArray *shapeViews = [self shapeViews];
    for (DPMeterView *shapeView in shapeViews) {
        if (delta < 0) {
            [shapeView minus:fabs(delta) animated:animated];
        } else {
            [shapeView add:fabs(delta) animated:animated];
        }
    }
    
//    self.title = [NSString stringWithFormat:@"%.2f%%",
//                  [(DPMeterView *)[shapeViews lastObject] progress]*100];
}

- (NSArray *)shapeViews
{
    NSMutableArray *shapeViews = [NSMutableArray array];
//    
//    if (self.shape4StarView && [self.shape4StarView isKindOfClass:[DPMeterView class]])
//        [shapeViews addObject:self.shape4StarView];
    
//    if (self.shape2View && [self.shape2View isKindOfClass:[DPMeterView class]])
//        [shapeViews addObject:self.shape2View];
//    
//    if (self.shape3View && [self.shape3View isKindOfClass:[DPMeterView class]])
//        [shapeViews addObject:self.shape3View];
//    
//    if (self.shape4View && [self.shape4View isKindOfClass:[DPMeterView class]])
//        [shapeViews addObject:self.shape4View];
//    
//    if (self.shape5View && [self.shape5View isKindOfClass:[DPMeterView class]])
//        [shapeViews addObject:self.shape5View];
    
    return [NSArray arrayWithArray:shapeViews];
}
-(void)initNameDataDiction
{
    
    //初始化key Array
     self.key = [[NSArray alloc] initWithObjects:@"father",@"mother",@"son",nil];
    NSLog(@"%@",[self.key objectAtIndex:0]);

    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self updateProgressWithDelta:0.6 animated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];

   
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self initNameDataDiction];
    [self initStatusData];
    
    
    [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, 320, 64)];
//    //[self.navigationbar setBackgroundColor:[UIColor darkGrayColor]];
    self.navigationController.navigationBar.translucent=YES;
    
    // UIApperance
    [[DPMeterView appearance] setTrackTintColor:[UIColor lightGrayColor]];
    [[DPMeterView appearance] setProgressTintColor:[UIColor darkGrayColor]];
    
//    // shape 4 -- 3 Stars
//    [self.shape4StarView setMeterType:DPMeterTypeLinearHorizontal];
//    [self.shape4StarView setShape:[UIBezierPath stars:5 shapeInFrame:self.shape4StarView.frame].CGPath];
//    self.shape4StarView.progressTintColor = [UIColor colorWithRed:255/255.f green:199/255.f blue:87/255.f alpha:1.f];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 3;
}
//行缩进

-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = [indexPath row];
    return row;
}
//改变行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    static BOOL nibsRegistered = NO;
    
    static NSString *Cellidentifier=@"cell1";
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"GYBTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:Cellidentifier];
        nibsRegistered = YES;
    }
    
    
    GYBTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:Cellidentifier forIndexPath:indexPath];
    NSUInteger row=[indexPath row];
  
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.nameLabel.text=[self.key objectAtIndex:row];

    // shape 4 -- 3 Stars
    [cell.statueView setMeterType:DPMeterTypeLinearHorizontal];
    [cell.statueView setShape:[UIBezierPath stars:5 shapeInFrame:cell.statueView.frame].CGPath];
    cell.statueView.progressTintColor = [UIColor colorWithRed:255/255.f green:199/255.f blue:87/255.f alpha:1.f];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    //从字典中读取string 然后转化为CGFloat
    NSString *key=cell.nameLabel.text;
    
    NSString *Delta=[self.listItem objectForKey:key];
    float floatString = [Delta floatValue];
//    NSLog(@"%@",Delta);
    CGFloat f = (CGFloat)floatString;
    
    //set statue Value
    cell.statueValue=&(f);
    [cell updateProgressWithDelta:*(cell.statueValue) animated:YES];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
//     cell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;
    
    return cell;
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

@end
