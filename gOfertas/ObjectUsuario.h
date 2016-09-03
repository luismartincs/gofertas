//
//  ObjectUsuario.h
//  gOfertas
//
//  Created by Luis de Jesus Martin Castillo on 02/09/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjectUsuario : NSObject

@property(nonatomic,strong) NSString *state;
@property(nonatomic,strong) NSString *message;
@property(nonatomic,strong) NSString *email;
@property(nonatomic) NSInteger usuarioid;

@end
