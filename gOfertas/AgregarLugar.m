//
//  AgregarLugar.m
//  gOfertas
//
//  Created by Luis de Jesus Martin Castillo on 01/09/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import "AgregarLugar.h"

@implementation AgregarLugar


- (void)viewDidLoad {
    [super viewDidLoad];

    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[_latitude doubleValue]
                                                            longitude:[_longitude doubleValue]
                                                                 zoom:16];
    _mapView = [GMSMapView mapWithFrame:CGRectMake(0, 0, self.mapContainer.frame.size.width,  self.mapContainer.frame.size.height) camera:camera];
    
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake([_latitude doubleValue], [_longitude doubleValue]);
    GMSMarker *marker = [GMSMarker markerWithPosition:position];
    
    marker.map = _mapView;
    
    [self.mapContainer addSubview:_mapView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard {
    [self.view endEditing:YES];
}

@end
