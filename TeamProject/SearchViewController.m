//
//  SearchViewController.m
//  TeamProject
//
//  Created by SDT-1 on 2014. 1. 24..
//  Copyright (c) 2014년 hongik. All rights reserved.
//

#import "SearchViewController.h"
#import "TMapView.h"
#import "TMapGpsManager.h"

#define APP_KEY @"d273f335-235a-3b7d-83c2-6344fd4120e1"
#define TOOLBAR_HIGHT 110

@interface SearchViewController () <UISearchBarDelegate, TMapViewDelegate, TMapGpsManagerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic)TMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *table;
@end

@implementation SearchViewController{
    NSMutableArray *arr;
}
- (void)locationChanged:(TMapPoint*)newTmp
{
    //    DLOG(@"%@", newTmp);
}
- (void)headingChanged:(double)heading
{
    //    DLOG(@"%f", heading);
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
    int i = 0;
    for (TMapPOIItem *item in result) {
        NSLog(@"Name : %@ - point : %@", [item getPOIName], [item getPOIPoint]);
        
        NSString *markerID = [NSString stringWithFormat:@"marker_%d", i++];
        TMapMarkerItem *marker = [[TMapMarkerItem alloc]init];
        [marker setTMapPoint:[item getPOIPoint]];
        [marker setIcon:[UIImage imageNamed:@"icon_clustering.png"]];
        
        [marker setCanShowCallout:YES];
        [marker setCalloutTitle:[item getPOIName]];
        [marker setCalloutSubtitle:[item getPOIAddress]];
        
        [arr addObject:[item getPOIName]];
        
        
        [self.mapView addCustomObject:marker ID:markerID];
        point = [item getPOIPoint];
    }
    [self.mapView setCenterPoint:point];
    NSLog(@"%@",point);
   // [self.mapView setTrackingMode:YES];
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
    CGRect rect = CGRectMake(0, TOOLBAR_HIGHT, self.view.frame.size.width, 250);
    
    self.mapView = [[TMapView alloc]initWithFrame:rect];
    [self.mapView setSKPMapApiKey:APP_KEY];
    self.mapView.delegate = self;
    
    [self.view addSubview:self.mapView];
    [_mapView setGpsManagersDelegate:self];
    [_mapView setTrackingMode:![self.mapView getIsTracking]];
    
    TMapCircle* circle =
    [[TMapCircle alloc] initWithCoordinate:CLLocationCoordinate2DMake(37.508997, 126.891581)]; [circle setRadius:100];
    [circle setCircleLineWidth:5];
    [circle setCircleAreaAlpha:0.8];
    [_mapView addTMapCircleID:@"circle_ 01" Circle:circle];
   // TMapGpsManager *gps = [[TMapGpsManager alloc]init];
  //  TMapPoint * point = [[TMapPoint alloc]initWithLon:37.508997 Lat:126.891581];
    //[_mapView setLocationPoint:point];
//    NSLog(@"%@", point);
//    TMapCircle *circle = [[TMapCircle alloc] initWithCoordinate:CLLocationCoordinate2DMake(37.508997, 126.891581)];
//    [circle setCircleAreaColor:CGColorCreateCopyWithAlpha([[UIColor blueColor] CGColor], 0.2)];
//  
//    [circle setCenterPoint:point];
//    [circle setCircleRadius:200];
//    [circle setCircleLineColor:[UIColor redColor].CGColor];
//    [circle setCircleLineWidth:5];
//    [circle setCircleAreaAlpha:4];
//    [_mapView addTMapCircleID:@"circle_ 02" Circle:circle];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
