//
//  WebServices.m
//  WebServices
//
//  Created by Luis de Jesus Martin Castillo on 15/07/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import "WebServices.h"
#import "Declarations.h"

//#define nURLMain            @"http://dev-env.z3hhvavp5h.us-west-2.elasticbeanstalk.com/index.php/computomovil/"
#define nURLMain              @"http://computomovil.us-west-2.elasticbeanstalk.com/index.php/"

#define nURLByGeoCoord      @"getOfferByLatLon"
#define nURLSaveOffer       @"saveOffer"
#define nURLDetalle         @"getOfferById"
#define nURLSaveStore       @"saveStore"
#define nURLStores          @"getAllStores"

#define nGET                0
#define nPOST               1
#define nAPPID              @"e8f1d0d987b4020419429918efe795ce"

@implementation WebServices

//Metodos customizados

+ (NSDictionary *)getWeatherWithLatitude:(NSString *)latitude AndLongitude:(NSString*)longitude {
    print(NSLog(@"getWeatherWithLatitude"))
    NSMutableDictionary *diData = [[NSMutableDictionary alloc] init];
    NSString  *stData           = [diData JSONRepresentation];
    
    NSString *stURL = [nURLMain stringByAppendingString:nURLByGeoCoord];
    stURL           = [stURL stringByAppendingString:@"lat="];
    stURL           = [stURL stringByAppendingString:latitude];
    stURL           = [stURL stringByAppendingString:@"&lon="];
    stURL           = [stURL stringByAppendingString:longitude];
    
    return [self sendPost:stURL forData:stData andMode:nPOST];
}


+ (NSDictionary *)getOfertasCercanasWithLatitude:(NSString*)latitude AndLongitude:(NSString*)longitude{
    
    print(NSLog(@"getOfertasCercanasWithLatitude"))
    
    NSMutableArray *favs = (NSMutableArray*)[[[NSUserDefaults standardUserDefaults] objectForKey:@"favoritos"] mutableCopy];
    
    NSInteger radio = [[NSUserDefaults standardUserDefaults] integerForKey:@"radio"];
    
    NSString *stData = [@"" stringByAppendingString:@""];
    stData           = [stData stringByAppendingString:@"lat="];
    stData           = [stData stringByAppendingString:latitude];
    stData           = [stData stringByAppendingString:@"&lon="];
    stData           = [stData stringByAppendingString:longitude];
    stData           = [stData stringByAppendingString:@"&r="];
    stData           = [stData stringByAppendingFormat:@"%i",radio];
    stData           = [stData stringByAppendingString:@"&c="];
    
    BOOL first = YES;
    NSInteger count;
    
    for (NSInteger i=0; i < favs.count; i++){
        
        if([favs[i] integerValue] == 1){
            if (first) {
                
                stData = [stData stringByAppendingFormat:@"%i",(i+1)];
                first = NO;
            }else{
                
                stData = [stData stringByAppendingString:@","];
                stData = [stData stringByAppendingFormat:@"%i",(i+1)];
            }

        }else{
            count+=1;
        }
    }
    
    if(count == favs.count){
        stData = [stData stringByAppendingString:@"-1"];

    }
    
    
    
    NSString *stURL = [nURLMain stringByAppendingString:nURLByGeoCoord];
    
    return [self sendPost:stURL forData:stData andMode:nPOST];
    
}

+ (NSDictionary *)getLugaresCercanosWithLatitude:(NSString*)latitude AndLongitude:(NSString*)longitude{
    
    print(NSLog(@"getLugaresCercanosWithLatitude"))
    
    NSMutableDictionary *diData = [[NSMutableDictionary alloc] init];
    
    [diData setValue:latitude forKey:@"latitude"];
    [diData setValue:longitude forKey:@"longitude"];
    
    NSString  *stData           = [diData JSONRepresentation];
    
    NSString *stURL = [nURLMain stringByAppendingString:nURLStores];
    
    return [self sendPost:stURL forData:stData andMode:nPOST];
    
}

+ (NSDictionary *)getDetalleOferta:(NSInteger)ofertaid{
    
    print(NSLog(@"getOfertasCercanasWithLatitude"))
    
    NSString *stData = [@"" stringByAppendingString:@""];
    stData           = [stData stringByAppendingString:@"offer_id="];
    stData           = [stData stringByAppendingFormat:@"%i",ofertaid];
    
    
    NSString *stURL = [nURLMain stringByAppendingString:nURLDetalle];
    
    return [self sendPost:stURL forData:stData andMode:nPOST];

    
}

//AGREGAR

+ (NSDictionary *)reportarOferta:(ObjectOferta*)oferta{
    
    print(NSLog(@"reportarOferta"))
    
    NSString *stData = [@"" stringByAppendingString:@""];
    stData           = [stData stringByAppendingString:@"title="];
    stData           = [stData stringByAppendingString:oferta.titulo];
    stData           = [stData stringByAppendingString:@"&description="];
    stData           = [stData stringByAppendingString:oferta.descripcion];
    stData           = [stData stringByAppendingString:@"&score="];
    stData           = [stData stringByAppendingFormat:@"%i",oferta.calificacion];
    stData           = [stData stringByAppendingString:@"&category_id="];
    stData           = [stData stringByAppendingFormat:@"%i",oferta.categoriaid];
    stData           = [stData stringByAppendingString:@"&price="];
    stData           = [stData stringByAppendingFormat:@"%f",oferta.precio];
    stData           = [stData stringByAppendingString:@"&store_id="];
    stData           = [stData stringByAppendingFormat:@"%i",oferta.tiendaid];
    stData           = [stData stringByAppendingString:@"&lat="];
    stData           = [stData stringByAppendingFormat:@"%.6f",oferta.latitud];
    stData           = [stData stringByAppendingString:@"&lon="];
    stData           = [stData stringByAppendingFormat:@"%.6f",oferta.longitud];
    stData           = [stData stringByAppendingString:@"&picture="];
    stData           = [stData stringByAppendingString:@""];
    stData           = [stData stringByAppendingString:@"&url="];
    stData           = [stData stringByAppendingString:oferta.url];
    stData           = [stData stringByAppendingString:@"&is_nationalwide="];
    stData           = [stData stringByAppendingFormat:@"%i",oferta.esLocal];
    stData           = [stData stringByAppendingString:@"&user_id="];
    stData           = [stData stringByAppendingFormat:@"%i",oferta.usuarioid];
    
    NSString *stURL = [nURLMain stringByAppendingString:nURLSaveOffer];
    
    return [self sendPost:stURL forData:stData andMode:nPOST];
    
}

+ (NSDictionary *)agregaLugarWithLatitude:(NSString *)latitude AndLongitude:(NSString*)longitude AndName:(NSString*)name{
    
    print(NSLog(@"agregaLugarWithLatitude"))
    
    NSString *stData = [@"" stringByAppendingString:@""];
    stData           = [stData stringByAppendingString:@"lat="];
    stData           = [stData stringByAppendingString:latitude];
    stData           = [stData stringByAppendingString:@"&lon="];
    stData           = [stData stringByAppendingString:longitude];
    stData           = [stData stringByAppendingString:@"&name="];
    stData           = [stData stringByAppendingString:name];
    
    NSString *stURL = [nURLMain stringByAppendingString:nURLSaveStore];
    
    return [self sendPost:stURL forData:stData andMode:nPOST];
    
}

//Metodo comun

+ (NSDictionary*) sendPost:(NSString*)postUrl forData:(NSString *)data andMode:(BOOL)mode {
    @try {
        NSString *post;
        
        if (mode) {
            //Post method
            post = [[NSString alloc] initWithFormat:@"%@", data];
        }
        else {
            //Get method
            post = [[NSString alloc] initWithFormat:@""];
        }
        
        print(NSLog(@"post parameters: %@",post))
        
        post                    = [post stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
        NSURL *url              = [NSURL URLWithString:postUrl];
        print(NSLog(@"URL post  = %@", url))
        
        NSData *postData        = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        NSString *postLength    = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        
        if (mode) {
            [request setHTTPMethod:@"POST"];
        }
        else {
            [request setHTTPMethod:@"GET"];
        }
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"UAG_1.0" forHTTPHeaderField:@"User-Agent"];
        [request setHTTPBody:postData];
        
        [NSURLRequest requestWithURL:url];
        NSError *error = [[NSError alloc] init];
        NSHTTPURLResponse *response = nil;
        NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        NSString *dd = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
        
        //Check response
        print(NSLog(@"[response statusCode] %d",(int)[response statusCode]))
        print(NSLog(@"[response] %@",dd))
        
        if ([response statusCode] >=200 && [response statusCode] <308) {
            //get json response
            NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:urlData options:kNilOptions error:&error];
            print(NSLog(@"response received %@",jsonResponse))
            
            //return response
            return jsonResponse;
        }
        else { if (error) {print(NSLog(@"Error response")) return nil; } else {print(NSLog(@"Conect Fail"))return nil;}
            return nil;
        }
    }
    @catch (NSException * e) {print(NSLog(@"Exception")) return nil;}
}

@end
