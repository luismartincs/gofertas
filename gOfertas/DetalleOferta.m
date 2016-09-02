//
//  DetalleOferta.m
//  gOfertas
//
//  Created by Luis de Jesus Martin Castillo on 02/09/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import "DetalleOferta.h"

@interface DetalleOferta ()

@end

@implementation DetalleOferta

- (void)viewDidLoad {
    [super viewDidLoad];
    _loadingView = [[LoadingView alloc] init];

}

-(void)viewWillAppear:(BOOL)animated{
    print(NSLog(@"Detalles de %i",_ofertaid))
    [self queueLoadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Web Services


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
    mjsonGeo = [WebServices getDetalleOferta:_ofertaid];
}

-(void)didLoadData{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [_loadingView removeFromSuperview];

        ObjectOferta *of  = [Parser parseOferta];
        
        NSNumber *price = [NSNumber numberWithDouble:of.precio];
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
        NSString *numberAsString = [numberFormatter stringFromNumber:price];
        
        _ofertaTxt.text = of.titulo;
        _categoriaTxt.text = of.categoria;
        _lugarTxt.text = of.tienda;
        _precioTxt.text = numberAsString;
        _nacionalTxt.text = of.esLocal==0?@"No":@"Si";
        _urlTxt.text = of.url;
        _descripcionTxt.text = of.descripcion;
        
        UIImage *star = [UIImage imageNamed:@"star.png"];
        UIImage *starg = [UIImage imageNamed:@"starg.png"];
        
        for (int i=0; i < 5; i++) {
            
            UIImageView *starv = [[UIImageView alloc] init];
            
            
            if(i < of.calificacion){
                starv.image = star;
            }else{
                starv.image = starg;
            }
            
            starv.frame = CGRectMake(0+(20*i),0, 20, 20);
            
            [_rankContainer addSubview:starv];
            
        }

        
    });
}

@end
