//
//  ObjectResponse.h
//  WebServices
//
//  Created by Luis de Jesus Martin Castillo on 15/07/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjectResponse : NSObject

@property (nonatomic, strong) NSArray *offers;
@property (nonatomic, strong) NSArray *stores;

@property (nonatomic,strong) NSString *state;
@property (nonatomic,strong) NSString *message;

@end
