//
//  ViewController.m
//  gOfertas
//
//  Created by Luis de Jesus Martin Castillo on 29/08/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import "Home.h"
#import "SWRevealViewController.h"
#import "ReportarOferta.h"

@import GoogleMaps;

@interface Home ()

@end

@implementation Home

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                            longitude:151.20
                                                                 zoom:6];
    _mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    _mapView.myLocationEnabled = YES;
    _mapView.settings.myLocationButton = YES;
    self.view = _mapView;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    

    UIButton *reportButton = [[UIButton alloc] initWithFrame:CGRectMake((screenWidth/2) - 40, screenHeight - 100, 80, 80)];
    [reportButton setImage:[UIImage imageNamed:@"report.png"] forState:UIControlStateNormal];
    
    [reportButton addTarget:self action:@selector(reportar) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:reportButton];
    
    
    [self startStandardUpdates];
    

}

#pragma mark - Web Services


-(void)queueLoadData{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //[_indicator startAnimating];
    
    NSOperationQueue *queue = [NSOperationQueue new];
    
    NSInvocationOperation *opGet = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadData) object:nil];
    
    [queue addOperation:opGet];
    
    NSInvocationOperation *opDidGet = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(didLoadData) object:nil];
    
    [opDidGet addDependency:opGet];
    
    [queue addOperation:opDidGet];
    
    
}

-(void)loadData{
    mjsonGeo = [WebServices getOfertasCercanasWithLatitude:_latitude AndLongitude:_longitude];
}

-(void)didLoadData{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;


    dispatch_async(dispatch_get_main_queue(), ^{
        
        ObjectResponse *object  = [Parser parseGeoObject];
        
        [_mapView clear];
        
        UIImage *imgLow = [UIImage imageNamed:@"markl.png"];
        UIImage *imgMid = [UIImage imageNamed:@"markm.png"];
        UIImage *imgHigh = [UIImage imageNamed:@"markh.png"];

        
        for (ObjectOferta *ob in object.ofertas) {
                        
            CLLocationCoordinate2D position = CLLocationCoordinate2DMake(ob.latitud, ob.longitud);
            GMSMarker *marker = [GMSMarker markerWithPosition:position];
            marker.title = ob.titulo;
            
            if(ob.calificacion >= 4){
                marker.icon = imgHigh;
            }else if(ob.calificacion <= 2){
                marker.icon = imgLow;
            }else{
                marker.icon = imgMid;
            }
            
            marker.map = _mapView;
        }
        
        
    });
}




#pragma mark - Segues

-(void)reportar{
    [self performSegueWithIdentifier:@"Reportar" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if([segue.destinationViewController isKindOfClass:[OfertasCercanas class]]){
        
        OfertasCercanas *destination = [segue destinationViewController];
        
        destination.latitude = _latitude;
        destination.longitude = _longitude;
        
    }else if([segue.destinationViewController isKindOfClass:[UINavigationController class]]){
        

        UINavigationController *nav = (UINavigationController*)[segue destinationViewController];
        ReportarOferta *destination =  (ReportarOferta*)nav.childViewControllers.lastObject;
        destination.latitude = _latitude;
        destination.longitude = _longitude;
        
    }
}

- (void)startStandardUpdates
{
    // Create the location manager if this object does not
    // already have one.
    if (nil == _locationManager)
        _locationManager = [[CLLocationManager alloc] init];
    
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    // Set a movement threshold for new events.
    _locationManager.distanceFilter = 100; //; kCLDistanceFilterNone; // meters
    
    if([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedAlways){
        [_locationManager requestAlwaysAuthorization];
       print( NSLog(@"Request auth"));
    }
    
    [_locationManager startUpdatingLocation];
}

- (void)startSignificantChangeUpdates
{
    // Create the location manager if this object does not
    // already have one.
    if (nil == _locationManager)
        _locationManager = [[CLLocationManager alloc] init];
    
    _locationManager.delegate = self;
    [_locationManager startMonitoringSignificantLocationChanges];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    // If it's a relatively recent event, turn off updates to save power.
    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    
    if (abs(howRecent) < 15.0) {

        _latitude = [NSString stringWithFormat:@"%+.6f",location.coordinate.latitude];

        _longitude = [NSString stringWithFormat:@"%+.6f",location.coordinate.longitude];

        print(NSLog(@"latitude %@, longitude %@",_latitude,_longitude));
        
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:location.coordinate.latitude
                                                                longitude:location.coordinate.longitude
                                                                    zoom:16];
        _mapView.camera = camera;
        
        [self queueLoadData];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
