//
//  ViewController.h
//  gOfertas
//
//  Created by Luis de Jesus Martin Castillo on 29/08/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@import GoogleMaps;

@interface Home : UIViewController<GMSMapViewDelegate,CLLocationManagerDelegate>

@property(nonatomic,strong) GMSMapView *mapView;
@property(nonatomic,strong) CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end

