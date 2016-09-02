//
//  AgregarLugar.h
//  gOfertas
//
//  Created by Luis de Jesus Martin Castillo on 01/09/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "LoadingView.h"
#import "WebServices.h"
#import "Declarations.h"

@interface AgregarLugar : UIViewController

@property (strong,nonatomic) LoadingView *loadingView;

@property(nonatomic,strong) GMSMapView *mapView;
@property (strong, nonatomic) IBOutlet UIView *mapContainer;
@property (nonatomic,strong) NSString *latitude;
@property (nonatomic,strong) NSString *longitude;
@property (strong, nonatomic) IBOutlet UITextField *nombreTxt;
- (IBAction)guardar:(id)sender;

@end
