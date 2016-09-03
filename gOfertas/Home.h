//
//  ViewController.h
//  gOfertas
//
//  Created by Luis de Jesus Martin Castillo on 29/08/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "WebServices.h"
#import "Declarations.h"
#import "OfertasCercanas.h"

@import GoogleMaps;

@interface Home : UIViewController<GMSMapViewDelegate,CLLocationManagerDelegate>

@property(nonatomic,strong) GMSMapView *mapView;
@property(nonatomic,strong) NSMutableDictionary *markersOffers;
@property(nonatomic,strong) CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (nonatomic,strong) NSString *latitude;
@property (nonatomic,strong) NSString *longitude;
@property (nonatomic,strong) GMSMarker *marker;

@end

