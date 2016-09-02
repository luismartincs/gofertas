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

#import "ObjectLugar.h"
#import "ObjectOferta.h"
#import "ObjectResponse.h"
#import "Parser.h"
#import "AlertProvider.h"

#define ERROR               @"Error"
#define CAMPO_VACIO         @"Los campos no pueden estar vacíos"
#define nDebugEnable        1
#define print(x)            if(nDebugEnable){(x);}


extern NSDictionary         *mjsonGeo;

@interface Declarations : NSObject


@end
