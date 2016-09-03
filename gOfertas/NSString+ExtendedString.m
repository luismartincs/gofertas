//
//  NSString+ExtendedString.m
//  gOfertas
//
//  Created by Luis de Jesus Martin Castillo on 02/09/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import "NSString+ExtendedString.h"

@implementation NSString (ExtendedString)

-(BOOL)isValidEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    NSString *trimmedText = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    return [emailTest evaluateWithObject:trimmedText];

}

@end
