//
//  File.swift
//  FusoWallet
//
//  Created by Developer on 2021/2/19.
//

import Foundation
import FearlessUtils

//createStorageKeyWithModuleName:@"System" serviceName:@"Account" identifier:_accoutId hasher:[[Blake128Concat alloc]init] error:&error]
@objc class StorageKeyObjc: NSObject {

 @objc func createAccountInfoStorageKey(accountId: Data)
    throws -> Data {
    
   let accountStorageKey = try StorageKeyFactory().accountInfoKeyForId(accountId)
   return accountStorageKey
 }
}
