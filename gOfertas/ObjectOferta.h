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
@property (nonatomic) double latitud;
@property (nonatomic) double longitud;
@property (nonatomic) NSInteger calificacion;
@property (nonatomic,strong) NSString *imageUrl;

@property (nonatomic,strong) UIImage *imageSource;

@end
