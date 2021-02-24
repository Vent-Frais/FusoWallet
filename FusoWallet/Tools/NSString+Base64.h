//
//  NSString+Base64.h
//  BitNexusWallet
//
//  Created by Developer on 2021/2/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Base64)
/**
 *  转换为Base64编码
 */
 - (NSString *)base64EncodedString;
 /**
 *  将Base64编码还原
 */
 - (NSString *)base64DecodedString;

- (NSData *)hexStringToNsdata;
- (NSString *)hexStringToNsString;
@end

NS_ASSUME_NONNULL_END
