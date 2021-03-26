//
//  NSString+Base64.m
//  BitNexusWallet
//
//  Created by Developer on 2021/2/3.
//

#import "NSString+Base64.h"
#import <IrohaCrypto/NSData+Hex.h>

@implementation NSString (Base64)
- (NSString *)base64EncodedString;{
NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
return [data base64EncodedStringWithOptions:0];
}

- (NSString *)base64DecodedString{
NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:0];
return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSData *)hexStringToNsdata{
    NSError *error = nil;
    NSString *prefix = @"0x";
    if ([self hasPrefix:prefix]) {
        NSString *filted = [self substringFromIndex:1];
        return [[NSData alloc]initWithHexString:filted error:&error];
    }else{
        return [[NSData alloc]initWithHexString:self error:&error];
    }
    
}
- (NSString *)hexStringToNsString{
    
    NSString *prefix = @"0x";
    if ([self hasPrefix:prefix]) {
        
        return [self substringFromIndex:1];;
    }else{
        return self;
    }
    
}
@end
