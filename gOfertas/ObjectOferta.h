//
//  ObjectOferta.h
//  gOfertas
//
//  Created by Luis de Jesus Martin Castillo on 31/08/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ObjectOferta : NSObject

@property (nonatomic,strong) NSString *titulo;
@property (nonatomic,strong) NSString *descripcion;
@property (nonatomic,strong) NSString *tienda;
@property (nonatomic,strong) NSString *categoria;

@property (nonatomic) NSInteger calificacion;
@property (nonatomic) NSInteger categoriaid;
@property (nonatomic) double precio;
@property (nonatomic) NSInteger tiendaid;
@property (nonatomic) double latitud;
@property (nonatomic) double longitud;
@property (nonatomic,strong) NSString *foto;
@property (nonatomic,strong) NSString *url;
@property (nonatomic) NSInteger esLocal;
@property (nonatomic) NSInteger usuarioid;
@property (nonatomic) NSInteger ofertaid;

@property (nonatomic,strong) UIImage *imageSource;

@end
