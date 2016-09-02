//
//  AgregarLugar.h
//  gOfertas
//
//  Created by Luis de Jesus Martin Castillo on 01/09/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface AgregarLugar : UIViewController

@property(nonatomic,strong) GMSMapView *mapView;
@property (strong, nonatomic) IBOutlet UIView *mapContainer;
@property (nonatomic,strong) NSString *latitude;
@property (nonatomic,strong) NSString *longitude;

@end
