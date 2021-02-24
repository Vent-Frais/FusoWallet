//
//  RpcRequest.m
//  BitNexusWallet
//
//  Created by Developer on 2021/2/2.
//
/*
{"jsonrpc":"2.0","result":{"methods":["account_nextIndex","author_hasKey","author_hasSessionKeys","author_insertKey","author_pendingExtrinsics","author_removeExtrinsic","author_rotateKeys","author_submitAndWatchExtrinsic","author_submitExtrinsic","author_unwatchExtrinsic","babe_epochAuthorship","chain_getBlock","chain_getBlockHash","chain_getFinalisedHead","chain_getFinalizedHead","chain_getHead","chain_getHeader","chain_getRuntimeVersion","chain_subscribeAllHeads","chain_subscribeFinalisedHeads","chain_subscribeFinalizedHeads","chain_subscribeNewHead","chain_subscribeNewHeads","chain_subscribeRuntimeVersion","chain_unsubscribeAllHeads","chain_unsubscribeFinalisedHeads","chain_unsubscribeFinalizedHeads","chain_unsubscribeNewHead","chain_unsubscribeNewHeads","chain_unsubscribeRuntimeVersion","childstate_getKeys","childstate_getStorage","childstate_getStorageHash","childstate_getStorageSize","grandpa_proveFinality","grandpa_roundState","grandpa_subscribeJustifications","grandpa_unsubscribeJustifications","offchain_localStorageGet","offchain_localStorageSet","payment_queryInfo","state_call","state_callAt","state_getKeys","state_getKeysPaged","state_getKeysPagedAt","state_getMetadata","state_getPairs","state_getReadProof","state_getRuntimeVersion","state_getStorage","state_getStorageAt","state_getStorageHash","state_getStorageHashAt","state_getStorageSize","state_getStorageSizeAt","state_queryStorage","state_queryStorageAt","state_subscribeRuntimeVersion","state_subscribeStorage","state_unsubscribeRuntimeVersion","state_unsubscribeStorage","subscribe_newHead","sync_state_genSyncSpec","system_accountNextIndex","system_addLogFilter","system_addReservedPeer","system_chain","system_chainType","system_dryRun","system_dryRunAt","system_health","system_localListenAddresses","system_localPeerId","system_name","system_networkState","system_nodeRoles","system_peers","system_properties","system_removeReservedPeer","system_resetLogFilter","system_syncState","system_version","unsubscribe_newHead"],"version":1},"id":"0"}
 */
#import "RpcRequest.h"
static RpcRequest *_instance = nil;
@implementation RpcRequest

+ (instancetype)shared{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
        
    });
    return _instance;
}
//+ (id) allocWithZone:(struct _NSZone *)zone
// {
//     return [RpcRequest shared];
// }
// 
// - (id) copyWithZone:(struct _NSZone *)zone
// {
//     return [RpcRequest shared];
// }
+ (NSMutableAttributedString *)getString:(NSString *)firstStr andFontSize:(NSInteger)fontSize firstFontColor:(UIColor *)color secondStr:(NSString *)secondStr andSecondFontSize:(NSInteger)secondfontSize secondFontColor:(UIColor *)secondColor{
    //第一段
    NSDictionary *attrDict1 = @{ NSFontAttributeName: [UIFont fontWithName:@"OPPOSans-M" size:fontSize],
                                 NSForegroundColorAttributeName: color };
    NSAttributedString *attrStr1 = [[NSAttributedString alloc] initWithString: firstStr attributes: attrDict1];
    
    //第二段
    NSDictionary *attrDict2 = @{ NSFontAttributeName: [UIFont fontWithName:@"OPPOSans-M" size:fontSize],
                                 NSForegroundColorAttributeName: secondColor };
    NSAttributedString *attrStr2 = [[NSAttributedString alloc] initWithString: secondStr attributes: attrDict2];

    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithAttributedString: attrStr1];
    [attributedStr appendAttributedString: attrStr2];
    
    
    return attributedStr;
}
+ (CGSize)AttributedStringSize:(NSAttributedString *)aString{
    CGSize attSize = [aString boundingRectWithSize:CGSizeMake(MAXFLOAT, 32) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    return attSize;
}
- (void)initWithPassphrase:(NSString *)passphrase{
    if (!_mnemonic) {
        [self CreatMnemonicString];
    }
    NSError *error = nil;
    SNBIP39SeedCreator *seedCreator = [[SNBIP39SeedCreator alloc] init];
    NSData *seed = [seedCreator deriveSeedFrom:_mnemonic.entropy
                                    passphrase:passphrase//@""
                                         error:&error];
    NSString *seedString = [seed toHexString];
    _availSeed = [seed subdataWithRange:NSMakeRange(0, 32)];
    
    SNKeyFactory *keypairFactory = [[SNKeyFactory alloc] init];
    id<SNKeypairProtocol>keypair = [keypairFactory createKeypairFromSeed:_availSeed error:nil];
    _privateKey = [keypair.privateKey.rawData toHexString];
    _publicKey = [keypair.publicKey.rawData toHexString];
    
    SS58AddressFactory *factory = [[SS58AddressFactory alloc] init];
    _address = [factory addressFromPublicKey:keypair.publicKey
                                                 type:SNAddressTypeGenericSubstrate
                                                error:&error];
    _type = [factory typeFromAddress:_address error:nil];
    _accoutId = [factory accountIdFromAddress:_address type:SNAddressTypeGenericSubstrate error:&error];
}

- (NSString *)CreatMnemonicString{
    NSError *error = nil;
    IRMnemonicCreator *mnemonicCreator = [[IRMnemonicCreator alloc] initWithLanguage:IREnglish];
    _mnemonic = [mnemonicCreator randomMnemonic:IREntropy128 error:&error];
    return [_mnemonic toString];
}
- (NSString *)getStorageKey{
    NSError *error = nil;
//    StorageKeyFactoryProtocol
    StorageKeyObjc *sf = [[StorageKeyObjc alloc]init];
    NSData *storagekeyData = [sf createAccountInfoStorageKeyWithAccountId:_accoutId error:&error];
    _storageKey = [storagekeyData toHexString];
    return _storageKey;
}
- (NSDictionary *)fromMnemonicGetInfo:(NSString *)mnemonicString passphrase:(NSString *)passphrase{
    NSError *error = nil;
    IRMnemonicCreator *mnemonicCreator = [IRMnemonicCreator defaultCreator];
    id<IRMnemonicProtocol>mnemonic = [mnemonicCreator mnemonicFromList:mnemonicString error:&error];
    SNBIP39SeedCreator *seedCreator = [[SNBIP39SeedCreator alloc]init];
    NSData *seed = [seedCreator deriveSeedFrom:mnemonic.entropy passphrase:passphrase error:&error];
    NSData *availSeed = [seed subdataWithRange:NSMakeRange(0, 32)];
    
    SNKeyFactory *keypairFactory = [[SNKeyFactory alloc] init];
    id<SNKeypairProtocol>keypair = [keypairFactory createKeypairFromSeed:availSeed error:nil];
    NSString *privateKey = [keypair.privateKey.rawData toHexString];
    NSString *publicKey = [keypair.publicKey.rawData toHexString];
    
    SS58AddressFactory *factory = [[SS58AddressFactory alloc] init];
    NSString *address = [factory addressFromPublicKey:keypair.publicKey
                                                 type:SNAddressTypeGenericSubstrate
                                                error:&error];
    NSNumber *type = [factory typeFromAddress:address error:nil];
    NSData *accoutId = [factory accountIdFromAddress:address type:SNAddressTypeGenericSubstrate error:&error];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"mnemonics"] = mnemonicString;
    dic[@"privateKey"] = privateKey;
    dic[@"publicKey"] = publicKey;
    dic[@"address"] = address;
    dic[@"accoutId"] = accoutId;
    dic[@"type"] = type;
    dic[@"keypair"] = keypair.rawData;
    
    return dic;

}
- (NSString *)sign:(id<SNKeypairProtocol>)keypair signDataString:(NSString *)signDataString{
    NSData *signData = [signDataString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error = nil;
    SNSigner *signer = [[SNSigner alloc]initWithKeypair:keypair];
    SNSignature *signature = [signer sign:signData error:&error];
    NSString *signString = [signature.rawData base64EncodedStringWithOptions:0];
    
    SNSignatureVerifier *verifier = [[SNSignatureVerifier alloc]init];
    BOOL isRight = [verifier verify:signature forOriginalData:signData usingPublicKey:keypair.publicKey];
    
    return isRight ? signString : @"";

}
- (void)rpcRequest:(NSString *)mothod params:(NSArray *)paramsArray{
        [WebSocketManager shared].delegate = self;
        [WebSocketManager shared].method = mothod;
        [WebSocketManager shared].paramsArray = paramsArray;
        [[WebSocketManager shared]connectServer];
}
- (void)webSocketManagerDidReceiveMessageWithDic:(NSDictionary *)dic{
    if (self.block) {
        self.block(dic);
    }
}

+ (void) saveObjectForUser:(id)object key:(NSString *)key{
    if (!kObjectIsEmpty(object)){
//    if (object && ![object isKindOfClass:[NSNull class]]) {
        [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

}
+ (id)getTheObjectForKey:(NSString *) key{

    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (void) userRemoveObjByKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}
+ (UIViewController *)hl_getRootViewController{
    UIWindow* window = nil;
       if (@available(iOS 13.0, *)) {
           for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes)
           {
              if (windowScene.activationState == UISceneActivationStateForegroundActive)
              {
                   window = windowScene.windows.firstObject;
        
                   break;
              }
           }
       }else{
           #pragma clang diagnostic push
           #pragma clang diagnostic ignored "-Wdeprecated-declarations"
               // 这部分使用到的过期api
            window = [UIApplication sharedApplication].keyWindow;
           #pragma clang diagnostic pop
       }
    if([window.rootViewController isKindOfClass:NSNull.class]){
        return nil;
    }
    return window.rootViewController;
}
+ (UIWindow *)hl_getRootWindow{
    UIWindow* window = nil;
       if (@available(iOS 13.0, *)) {
           for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes)
           {
              if (windowScene.activationState == UISceneActivationStateForegroundActive)
              {
                   window = windowScene.windows.firstObject;
        
                   break;
              }
           }
       }else{
           #pragma clang diagnostic push
           #pragma clang diagnostic ignored "-Wdeprecated-declarations"
               // 这部分使用到的过期api
            window = [UIApplication sharedApplication].keyWindow;
           #pragma clang diagnostic pop
       }
    
    return window;
}

+ (NSString *)timeIntervalToTimeString:(long long)second customDateFormat:(nullable NSString *)dataFormatStr{
    
    NSString * dateFormat = @"HH:mm:ss MM/dd/yyyy";
    
    if (dataFormatStr) {
        dateFormat = dataFormatStr;
    }
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:second];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    NSTimeZone* timeZone = [NSTimeZone systemTimeZone];

    [dateFormatter setTimeZone:timeZone];

    NSString *dateAndTime =  [dateFormatter stringFromDate:date2];

    return dateAndTime;
}
@end
