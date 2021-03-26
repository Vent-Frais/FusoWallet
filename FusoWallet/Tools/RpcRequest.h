//
//  RpcRequest.h
//  BitNexusWallet
//
//  Created by Developer on 2021/2/2.
//
typedef void(^responseBlock)(NSDictionary *_Nonnull);
#import <Foundation/Foundation.h>
#import "WebSocketManager.h"
#import <IrohaCrypto/sr25519.h>


NS_ASSUME_NONNULL_BEGIN

@interface RpcRequest : NSObject<WebSocketManagerDelegate>
@property (strong, nonatomic) id<IRMnemonicProtocol>mnemonic;
@property (strong, nonatomic) NSData *availSeed;
@property (strong, nonatomic) id<SNKeypairProtocol>keypair;
@property (strong, nonatomic) NSString *privateKey;
@property (strong, nonatomic) NSString *publicKey;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSNumber *type;
@property (strong, nonatomic) NSData *accoutId;
@property (strong, nonatomic) NSString *storageKey;
@property (strong, nonatomic) id<SNKeypairProtocol>currentKeypair;
@property (copy ,nonatomic) responseBlock block;
@property (nonatomic, strong) UIView *statusBarView;

+ (instancetype)shared;

+ (NSMutableAttributedString *)getString:(NSString *)firstStr andFontSize:(NSInteger)fontSize firstFontColor:(UIColor *)color secondStr:(NSString *)secondStr andSecondFontSize:(NSInteger)secondfontSize secondFontColor:(UIColor *)secondColor;
+ (CGSize)AttributedStringSize:(NSAttributedString *)aString;

- (void)initWithPassphrase:(NSString *)passphrase;//获取seed
- (NSString *)CreatMnemonicString;//随机创建助记词
- (NSDictionary *)fromMnemonicGetInfo:(NSString *)mnemonicString passphrase:(NSString *)passphrase;//从助记词推导账号信息
- (NSDictionary *)fromPrivateKeyGetInfo:(NSString *)privateKeyString; //从私钥推导账号
- (NSString *)sign:(id<SNKeypairProtocol>)keypair signDataString:(NSString *)signDataString;//签名校验
- (void)rpcRequest:(NSString *)mothod params:(NSArray *)paramsArray;//网络请求

+ (void) saveObjectForUser:(id)object key:(NSString *)key;
/** 获取信息 */
+ (id)getTheObjectForKey:(NSString *) key;
/** 移除信息 */
+ (void) userRemoveObjByKey:(NSString *)key;

+ (UIViewController *)hl_getRootViewController;
+ (UIWindow *)hl_getRootWindow;

+ (NSString *)timeIntervalToTimeString:(long long)second customDateFormat:(nullable NSString *)dataFormatStr;

+(void)showMesage:(NSString *)msg;
//二维码生成
+ (void)creatQRCode:(NSString *)shareString imagView:(UIImageView *)imgView;

- (void)changeStatusBarColor:(UIColor *)color isRemove:(BOOL)isRemove;

+ (void)deleteFile:(NSString *)fileName;

@end

NS_ASSUME_NONNULL_END
