//
//  ObjectLugar.h
//  gOfertas
//
//  Created by Luis de Jesus Martin Castillo on 01/09/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjectLugar : NSObject

@property (nonatomic) NSInteger storeid;
@property (nonatomic,strong) NSString *name;
@property (nonatomic) double latitud;
@property (nonatomic) double longitud;

@end
