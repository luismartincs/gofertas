//
//  Declarations.h
//  WebServices
//
//  Created by Luis de Jesus Martin Castillo on 15/07/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "SBJson.h"
#import "ObjectMapper.h"

#import "ObjectUsuario.h"
#import "ObjectLugar.h"
#import "ObjectOferta.h"
#import "ObjectResponse.h"
#import "Parser.h"
#import "AlertProvider.h"

#define ERROR               @"Error"
#define REGISTRO_USUARIO    @"Registro Usuario"
#define CAMPO_VACIO         @"Los campos no pueden estar vacíos"
#define PASSWORD_IGUALES    @"Las contraseñas deben coincidir"
#define EMAIL_INCORRECTO    @"El formato de correo electrónico es incorrecto"
#define USERNAME_INVALIDO   @"El nombre de usuario ya esta en uso"
#define nDebugEnable        1
#define print(x)            if(nDebugEnable){(x);}


extern NSDictionary         *mjsonGeo;
extern NSMutableArray *maIntroTitles;
extern NSMutableArray *maIntroImgs;

@interface Declarations : NSObject


@end
