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

-(void)queueLoadData{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self.navigationController.view addSubview:_loadingView];
    
    NSOperationQueue *queue = [NSOperationQueue new];
    
    NSInvocationOperation *opGet = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadData) object:nil];
    
    [queue addOperation:opGet];
    
    NSInvocationOperation *opDidGet = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(didLoadData) object:nil];
    
    [opDidGet addDependency:opGet];
    
    [queue addOperation:opDidGet];
    
}

-(void)loadData{
    mjsonGeo = [WebServices agregaLugarWithLatitude:_latitude AndLongitude:_longitude AndName:_nombreTxt.text];
}

-(void)didLoadData{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [_loadingView removeFromSuperview];
        
        ObjectResponse *object  = [Parser parseGeoObject];
        
        if([object.state isEqualToString:@"SUCCESS POST"]){
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            print(NSLog(@"ERROR %@",object.message))
        }
        
    });
}

- (IBAction)guardar:(id)sender {
    if(![_nombreTxt.text isEqualToString:@""]){
        [self dismissKeyboard];
        [self queueLoadData];
    }else{
        [AlertProvider showMessage:CAMPO_VACIO andTitle:ERROR inController:self];
    }
}
@end
