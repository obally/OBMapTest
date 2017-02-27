//
//  ViewController.m
//  OBMapTestDemo
//
//  Created by obally on 17/2/27.
//  Copyright © 2017年 obally. All rights reserved.
//

#import "ViewController.h"
#import "OBHomeViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
@interface ViewController ()<MAMapViewDelegate,AMapSearchDelegate,AMapLocationManagerDelegate>
@property(nonatomic,strong)MAMapView *mapView;
@property(nonatomic,strong)AMapSearchAPI *mapSearch;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configMap]; //地图基本配置
    [self initMapView]; //初始化mapView 地图显示
    [self initLocationManager]; //初始化locationManager 主要用来定位
    [self initPOISearchMap]; //附近搜索
    [self addAnnotation];//添加大头钉
//    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(50, 100, 200, 50)];
//    button.backgroundColor = [UIColor redColor];
//    [self.view addSubview:button];
//    [button addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    
}

//地图基本配置
- (void)configMap
{
    //适配https
    [AMapServices sharedServices].enableHTTPS = YES;
    [AMapServices sharedServices].apiKey = @"abc9ca06568d304d22b6603e890bba11";
}
//初始化mapView 地图显示
- (void)initMapView
{
    //初始化地图
    MAMapView *mapView = [[MAMapView alloc]initWithFrame:self.view.bounds];
    self.mapView = mapView;
    mapView.delegate = self;
    [self.view addSubview:_mapView];
    
    //显示定位小蓝点
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
}
//初始化locationManager 主要用来定位
- (void)initLocationManager
{
    AMapLocationManager *manager = [[AMapLocationManager alloc]init];
    manager.delegate = self;
    manager.distanceFilter = 1;
    [manager startUpdatingLocation];
    
}
//附近搜索
- (void)initPOISearchMap
{
    //POI搜索
    self.mapSearch = [[AMapSearchAPI alloc]init];
    self.mapSearch.delegate = self;
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    
    request.location            = [AMapGeoPoint locationWithLatitude:39.990459 longitude:116.481476];
    request.keywords            = @"电影院";
    /* 按照距离排序. */
    request.sortrule            = 0;
    request.requireExtension    = YES;
    [self.mapSearch AMapPOIAroundSearch:request];
}
//添加大头钉
- (void)addAnnotation
{
    NSArray *array = @[@[@(39.989631),@(116.481018)],@[@(39.7),@(116.481018)],@[@(39.6),@(116.481018)]];
    for (int i= 0; i< array.count; i++) {
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        float longti = [array[i][0] floatValue];
        float lati = [array[i][1] floatValue];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(longti, lati);
        pointAnnotation.title = @"方恒国际";
        pointAnnotation.subtitle = @"阜通东大街6号";
        [_mapView addAnnotation:pointAnnotation];
    }
}
#pragma mark - MAMapViewDelegate
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location
{
    //    CLLocation *location = [locations lastObject];
    CLLocationDegrees latitude = location.coordinate.latitude;
    CLLocationDegrees longitude = location.coordinate.longitude;
    //some code
}
//大头针定义
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:reuseIndetifier];
        }
        annotationView.image = [UIImage imageNamed:@"hema"];
        //设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -18);
        return annotationView;
    }
    return nil;
}
#pragma mark - AMapSearchDelegate
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    
}

/**
 * @brief POI查询回调函数
 * @param request  发起的请求，具体字段参考 AMapPOISearchBaseRequest 及其子类。
 * @param response 响应结果，具体字段参考 AMapPOISearchResponse 。
 */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    
}

- (void)push
{
    OBHomeViewController *home = [[OBHomeViewController alloc]init];
    [self presentViewController:home animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
