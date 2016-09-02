//
//  OCMapperConfig.m
//  WebServices
//
//  Created by Luis de Jesus Martin Castillo on 15/07/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import "Declarations.h"
#import "OCMapper.h"
#import "OCMapperConfig.h"

@implementation OCMapperConfig

+(void)configure{
    
    InCodeMappingProvider *inCodeMappingProvider = [[InCodeMappingProvider alloc] init];
    CommonLoggingProvider *commonLoggingProvider = [[CommonLoggingProvider alloc] initWithLogLevel:LogLevelInfo];
    
    [[ObjectMapper sharedInstance] setMappingProvider:inCodeMappingProvider];
    [[ObjectMapper sharedInstance] setLoggingProvider:commonLoggingProvider];
 
    [inCodeMappingProvider mapFromDictionaryKey:@"ofertas"
                                  toPropertyKey:@"ofertas"
                                 withObjectType:[ObjectOferta class]
                                       forClass:[ObjectResponse class]];
    
    [inCodeMappingProvider mapFromDictionaryKey:@"lugares"
                                  toPropertyKey:@"lugares"
                                 withObjectType:[ObjectLugar class]
                                       forClass:[ObjectResponse class]];

}

@end
