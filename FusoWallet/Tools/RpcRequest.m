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
    NSString *availSeedString = availSeed.toHexString;
    
    SNKeyFactory *keypairFactory = [[SNKeyFactory alloc] init];
    id<SNKeypairProtocol>keypair = [keypairFactory createKeypairFromSeed:availSeed error:nil];
    NSString *privateKey = keypair.privateKey.rawData.toHexString;
    NSString *publicKey = keypair.publicKey.rawData.toHexString;
    
    SS58AddressFactory *factory = [[SS58AddressFactory alloc] init];
    NSString *address = [factory addressFromPublicKey:keypair.publicKey
                                                 type:SNAddressTypeGenericSubstrate
                                                error:&error];
    NSNumber *type = [factory typeFromAddress:address error:nil];
    NSData *accoutId = [factory accountIdFromAddress:address type:SNAddressTypeGenericSubstrate error:&error];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"walletName"] = @"";
    dic[@"passphrase"] = @"";
    dic[@"mnemonics"] = mnemonicString;
    dic[@"seed"] = seed.toHexString;
    dic[@"privateKey"] = privateKey;
    dic[@"publicKey"] = publicKey;
    dic[@"address"] = address;
    dic[@"accoutId"] = accoutId;
    dic[@"type"] = type;
    dic[@"keypair"] = keypair.rawData;
    dic[@"transferInfo"] = @[].mutableCopy;
    return dic;
   
}
- (NSDictionary *)fromPrivateKeyGetInfo:(NSString *)privateKeyString {
 /*   {
        accoutId = {length = 32, bytes = 0x6c36305b 2d521b34 37e6d642 637b755d ... 5f99d370 7125b158 };
        address = 5EWb8GhFHHF4xwoVakh2o35XDmr727jxEZqXZGS2KhJzuyrC;
        keypair = {length = 96, bytes = 0x73e3cbaa 550754a7 b7c05245 4833dfa2 ... 5f99d370 7125b158 };
        mnemonics = "carbon mixed fortune shield hour extra goddess picture frozen light dance error";
        passphrase = "";
        privateKey = 73e3cbaa550754a7b7c052454833dfa263e98a62718b200516ab21d7e8334d0e362ac640910b5ead22b12d2d12943b1192802fb0dc8f582323abe93260e978cf;
        publicKey = 6c36305b2d521b3437e6d642637b755d5b8a4a64c22c02d25f99d3707125b158;
        seed = d283955664a09307329f1aac4346f62ca7669f199fde586d573aa469ea0d3ec9ca426e604ff9b5d20eff75e0f767e633296b9fde2d9ecee7313ea8298b4185f2;
        transferInfo =     (
        );
        type = 42;
        walletName = "";
    }
*/
    NSError *error;

    NSData *privateKeyData = [[NSData alloc] initWithHexString:privateKeyString error:&error];

    if (error != nil) {
        NSString *message = [error localizedDescription];
        [RpcRequest showMesage:message];
        return nil;
    }
    NSString * encode = @"bd/ZtUL3oq0TrhYVy8mfcIq55jHWa9vWiDeZMquWzh8AgAAAAQAAAAgAAABiQUy1OjpAVrWA3nBHi4XCsm1tz4TD+O1GI7+ngVdCDwCacuUxtjGZEJBfX7BOxE3ygmXjGf+tATg+3udvGUyH4hGp5VOU2btO+KOOahPTJnY+LuTvmndX7QCZ2HWPXtgyvS44Vope3yW/SUdZM5e+U3XyT5L6WagVm2lErN3Grl4jICbLF3y8i7MLtszJadzfJTGr+FksjsNWv4Ib";
    
     
    SNPrivateKey *privateKey = [[SNPrivateKey alloc] initWithRawData:privateKeyData
                                                                 error:&error];

//    StorageKeyObjc *ob = [[StorageKeyObjc alloc]init];
//
//    NSData *data = [ob testEcdsaExtrinsicAndReturnError:&error];

//    if (error != nil) {
//        NSString *message = [error localizedDescription];
//        [RpcRequest showMesage:message];
//        return nil;
//    }
    NSData *ed25519 = [privateKey toEd25519Data];
    NSData *ed25519Data = [ed25519 subdataWithRange:NSMakeRange(0, 32)];
    
    EDPrivateKey *edPrivatekey = [[EDPrivateKey alloc]initWithRawData:ed25519Data error:&error];
        if (error != nil) {
            NSString *message = [error localizedDescription];
            [RpcRequest showMesage:message];
            return nil;
        }
    id<IRCryptoKeypairProtocol>edFactory = [[EDKeyFactory alloc]deriveFromPrivateKey:edPrivatekey error:&error];
    if (error != nil) {
        NSString *message = [error localizedDescription];
        [RpcRequest showMesage:message];
        return nil;
    }
        uint8_t secret_out[SR25519_SECRET_SIZE];
        sr25519_from_ed25519_bytes(secret_out, edFactory.publicKey.rawData.bytes);
    //
        NSData *pRawData = [NSData dataWithBytes:secret_out length:SR25519_SECRET_SIZE];
    NSData *cRawData = [pRawData subdataWithRange:NSMakeRange(0, 32)];
    SNPublicKey *publicKey = [[SNPublicKey alloc]initWithRawData:cRawData error:&error];
    if (error != nil) {
        NSString *message = [error localizedDescription];
        [RpcRequest showMesage:message];
        return nil;
    }
//    uint8_t secret_out[SR25519_SECRET_SIZE];
//    sr25519_from_ed25519_bytes(secret_out, data.bytes);
//
//    self.rawData = [NSData dataWithBytes:secret_out length:SR25519_SECRET_SIZE];
    
    
//    IRIrohaKeyFactory *keyFactory = [[IRIrohaKeyFactory alloc] init];
////    SNKeypair *edPrivateKey =  [SNKeyFactory alloc];
//    if (error != nil) {
//        NSString *message = [error localizedDescription];
//        [RpcRequest showMesage:message];
//        return nil;
//    }
//    id<IRCryptoKeypairProtocol> keypair = [keyFactory deriveFromPrivateKey:privateKey error:&error];
//
//    if (error != nil) {
//        NSString *message = [error localizedDescription];
//        [RpcRequest showMesage:message];
//        return nil;
//    }
    SS58AddressFactory *factory = [[SS58AddressFactory alloc]init];
    NSString *address = [factory addressFromPublicKey:publicKey
                                                 type:SNAddressTypeGenericSubstrate
                                                error:&error];

    if (error != nil) {
        NSString *message = [error localizedDescription];
        [RpcRequest showMesage:message];
        return nil;
    }

    SNKeypair *keypair = [[SNKeypair alloc]initWithPrivateKey:privateKey publicKey:publicKey];
    
    NSNumber *type = [factory typeFromAddress:address error:nil];
    NSData *accoutId = [factory accountIdFromAddress:address type:SNAddressTypeGenericSubstrate error:&error];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"walletName"] = @"";
    dic[@"passphrase"] = @"";
    dic[@"mnemonics"] = @"";
    dic[@"seed"] = @"";
    dic[@"privateKey"] = privateKey;
    dic[@"publicKey"] = @"";
    dic[@"address"] = address;
    dic[@"accoutId"] = accoutId;
    dic[@"type"] = type;
    dic[@"keypair"] = keypair.rawData;
    dic[@"transferInfo"] = @[].mutableCopy;
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

+ (void)saveObjectForUser:(id)object key:(NSString *)key{
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

//二维码生成
+(void)creatQRCode:(NSString *)shareString imagView:(UIImageView *)imgView{
    
    //二维码滤镜
    
    CIFilter *filter=[CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //恢复滤镜的默认属性
    
    [filter setDefaults];
    
    //将字符串转换成NSData
    
    NSData *data=[shareString dataUsingEncoding:NSUTF8StringEncoding];
    
    //通过KVO设置滤镜inputmessage数据
    
    [filter setValue:data forKey:@"inputMessage"];
    
    //获得滤镜输出的图像
    
    CIImage *outputImage=[filter outputImage];
    
    //将CIImage转换成UIImage,并放大显示
    
    imgView.image=[RpcRequest createNonInterpolatedUIImageFormCIImage:outputImage withSize:imgView.size.height];
    
    
    
    //如果还想加上阴影，就在ImageView的Layer上使用下面代码添加阴影
    
    imgView.layer.shadowOffset=CGSizeMake(0, 0.5);//设置阴影的偏移量
    
    imgView.layer.shadowRadius=1;//设置阴影的半径
    
    imgView.layer.shadowColor=[UIColor blackColor].CGColor;//设置阴影的颜色为黑色
    
    imgView.layer.shadowOpacity=0.3;
    
    
    
}

//改变二维码大小

+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    
    CGRect extent = CGRectIntegral(image.extent);
    
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 创建bitmap;
    
    size_t width = CGRectGetWidth(extent) * scale;
    
    size_t height = CGRectGetHeight(extent) * scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    
    CGContextScaleCTM(bitmapRef, scale, scale);
    
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 保存bitmap到图片
    
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    UIImage *img = [UIImage imageWithCGImage:scaledImage];
    CGColorSpaceRelease(cs);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    CGImageRelease(scaledImage);
    UIGraphicsEndImageContext();
    return img;
    
}

- (void)changeStatusBarColor:(UIColor *)color isRemove:(BOOL)isRemove{
if (@available(iOS 13.0, *)) {
    if (!_statusBarView) {
        _statusBarView = [[UIView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.windowScene.statusBarManager.statusBarFrame] ;
        _statusBarView.backgroundColor = color;
        
    }
    if (isRemove) {
        [_statusBarView removeFromSuperview];
    }else{
        [[UIApplication sharedApplication].keyWindow addSubview:_statusBarView];
    }
   
} else {
    // Fallback on earlier versions
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
       if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
           statusBar.backgroundColor = color;
       }
}
}

+ (void)showMesage:(NSString *)msg{
   [ISMessages showCardAlertWithTitle:NSLocalizedString(@"温馨提示", nil)
               message:msg
               duration:1.2f
                hideOnSwipe:YES
               hideOnTap:YES
               alertType:ISAlertTypeSuccess
               alertPosition:ISAlertPositionTop
               didHide:^(BOOL finished) {
                  NSLog(@"Alert did hide.");
               
   }];
}

+ (void)deleteFile:(NSString *)fileName{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExist = [fileManager fileExistsAtPath:fileName];
    if (isExist) {
        NSError *error;
        [fileManager removeItemAtPath:fileName error:&error];
    }
  
}
@end
