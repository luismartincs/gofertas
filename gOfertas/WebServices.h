//
//  WebServices.h
//  WebServices
//
//  Created by Luis de Jesus Martin Castillo on 15/07/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ObjectOferta;

@interface WebServices : NSObject

+ (NSDictionary *)getWeatherWithLatitude:(NSString *)latitude AndLongitude:(NSString*)longitude;
+ (NSDictionary *)getOfertasCercanasWithLatitude:(NSString*)latitude AndLongitude:(NSString*)longitude;
+ (NSDictionary *)getLugaresCercanosWithLatitude:(NSString*)latitude AndLongitude:(NSString*)longitude;
+ (NSDictionary *)getDetalleOferta:(NSInteger)ofertaid;


//================= Agregar

+ (NSDictionary *)reportarOferta:(ObjectOferta*)oferta;
+ (NSDictionary *)agregaLugarWithLatitude:(NSString *)latitude AndLongitude:(NSString*)longitude AndName:(NSString*)name;


+ (NSDictionary*) sendPost:(NSString*)postUrl forData:(NSString *)data andMode:(BOOL)mode;

@end
