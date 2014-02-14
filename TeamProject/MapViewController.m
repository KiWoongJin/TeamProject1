//
//  MapViewController.m
//  TeamProject
//
//  Created by SDT-1 on 2014. 2. 14..
//  Copyright (c) 2014년 hongik. All rights reserved.
//

#import "MapViewController.h"
#import "PictureUpViewController.h"
#import "TMapView.h"
#import "TMapGpsManager.h"
#define APP_KEY @"d273f335-235a-3b7d-83c2-6344fd4120e1"
#define TOOLBAR_HIGHT 110

@interface MapViewController ()<UISearchBarDelegate, TMapViewDelegate, TMapGpsManagerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;

@property (strong, nonatomic)TMapView *mapView;
@end

@implementation MapViewController{
    NSMutableArray *arr;
    NSMutableArray *arr2;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    
    [self.mapView clearCustomObjects];
    [arr removeAllObjects];
    
    NSString *keyword = searchBar.text;
    TMapPathData *path = [[TMapPathData alloc]init];
    NSArray *result = [path requestFindTitlePOI:keyword];
    NSLog(@"Number of POI : %d", result.count);
    TMapPoint *point = [[TMapPoint alloc]init];
    TMapPoint *temp = [[TMapPoint alloc]init];
    int i = 0;
    for (TMapPOIItem *item in result) {
        NSLog(@"Name : %@ - point : %@", [item getPOIName], [item getPOIPoint]);
        
        NSString *markerID = [NSString stringWithFormat:@"marker_%d", i++];
        TMapMarkerItem *marker = [[TMapMarkerItem alloc]init];
        [marker setTMapPoint:[item getPOIPoint]];
        [marker setIcon:[UIImage imageNamed:@"icon_clustering.png"]];
        
        marker.markerTitle = item.poiName;
      //  marker.
        [marker setCanShowCallout:YES];
        [marker setCalloutTitle:[item getPOIName]];
        [marker setCalloutSubtitle:[item getPOIAddress]];
        
        [arr addObject:[item getPOIName]];
        [arr2 addObject:[item getPOIPoint]];
        
        
        [self.mapView addCustomObject:marker ID:markerID];
        point = [item getPOIPoint];
    
    }
    temp = [arr2 objectAtIndex:0];
    [self.mapView setCenterPoint:temp];
    //[self.mapView setTrackingMode:YES];
    [self.table reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MAP_CELL"];
    cell.textLabel.text = [arr objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    PictureUpViewController *nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PICVC"];
//    nextVC.place2 = [NSString stringWithFormat:@"%@",[arr objectAtIndex:indexPath.row]];
//    NSLog(@"%@", nextVC.place2);
    //[UIApplication sharedApplication].keyWindow.rootViewController = nextVC;
  //  NSArray *temp = [[NSArray alloc]init];
    
   // temp = [self.navigationController viewControllers];
    
    NSArray *viewControllers = self.navigationController.viewControllers;
    UIViewController *rootViewController = [viewControllers objectAtIndex:viewControllers.count - 2];
    PictureUpViewController *nextVC = (UIViewController *)rootViewController;
    
    nextVC.place2 = [NSString stringWithFormat:@"%@",[arr objectAtIndex:indexPath.row]];
   
    [self.navigationController popViewControllerAnimated:YES];
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
	// Do any additional setup after loading the view.
    arr = [[NSMutableArray alloc]init];
    arr2 = [[NSMutableArray alloc]init];
    CGRect rect = CGRectMake(0, TOOLBAR_HIGHT, self.view.frame.size.width, 250);
    
    
    self.mapView = [[TMapView alloc]initWithFrame:rect];
    [self.mapView setSKPMapApiKey:APP_KEY];
    self.mapView.delegate = self;
    
    [self.mapView setDelegate:self];
    [self.view addSubview:self.mapView];
    [_mapView setGpsManagersDelegate:self];
    [_mapView setTrackingMode:![self.mapView getIsTracking]];
}
- (void)onCustomObjectClick:(TMapObject*)obj
{
    if([obj isMemberOfClass:[TMapMarkerItem class]])
    {
        TMapMarkerItem *item = (TMapMarkerItem *)obj;
        NSLog(@"TMapMarkerItem clicked:%@", item.markerTitle);
       // NSLog(@"%@", obj.accessibilityValue);
    }
    
}
- (void)onCustomObjectLongClick:(TMapObject*)obj
{
    if([obj isMemberOfClass:[TMapMarkerItem class]])
    {
        NSLog(@"TMapMarkerItem clicked:%@", obj);
    }
}
- (void)onLongClick:(TMapPoint*)TMP
{
    NSLog(@"%@", TMP);
}
-(void)backPressed: (id)sender
{
    [self.navigationController popViewControllerAnimated: YES]; // or popToRoot... if required.
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStyleBordered target:self action:@selector(backPressed:)];
    self.navigationItem.leftBarButtonItem = btn;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
