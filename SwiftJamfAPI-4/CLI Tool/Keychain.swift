//
//  Keychain.swift
//
//  Created by Armin Briegel on 2022-11-01.
//

import Foundation

// built from the sample code here
// https://developer.apple.com/documentation/security/keychain_services/keychain_items

// I changed the class of the item to "internet password"
// which makes it easier to manually create the item in keychain
// and re-use items created when accessing the site in Safari

// this reply here https://developer.apple.com/forums/thread/688612
// recommended to use NSDictionary for the query dict to
// avoid a lot of boiler plate type casting

struct Keychain {
  enum KeychainError: Error {
    case noPassword                 // no matching item found
    case duplicateItem              // found more than on matching item
    case unexpectedPasswordData     // could not read item data
    case unhandledError(OSStatus)   // other errors
  }
  
  static func save(password: String, service: String, account: String, label: String? = nil) throws {
    // if label is unset, use service as the label
    // this matches what keychain app does when creating a new item
    let safeLabel = label ?? service
    
    // when item already exists, use update instead
    if let _ = try? getPassword(service: service, account: account) {
      try update(password: password, service: service, account: account, label: label)
      return
    }
    
    let passwordData = Data(password.utf8)
    
    // create the Add Query Dict
    let query: NSDictionary = [kSecClass: kSecClassInternetPassword,
                         kSecAttrService: service,
                           kSecAttrLabel: safeLabel,
                         kSecAttrAccount: account,
                           kSecValueData: passwordData]
    // add the item
    let status = SecItemAdd(query, nil)
    
    if status == errSecDuplicateItem {
      throw KeychainError.duplicateItem
    }
    
    guard status == errSecSuccess else {
      throw KeychainError.unhandledError(status)
    }
  }
  
  static func update(password: String, service: String, account: String, label: String? = nil) throws {
    let passwordData = Data(password.utf8)
    
    // if label is unset, use service as the label
    let safeLabel = label ?? service
    
    // prepare a search query
    let query: NSDictionary = [kSecAttrService: service,
                               kSecAttrAccount: account,
                                     kSecClass: kSecClassInternetPassword]
    
    // prepare new attributes
    let attributes: NSDictionary = [kSecValueData: passwordData,
                                    kSecAttrLabel: safeLabel]
    // execute the update
    let status = SecItemUpdate(query, attributes)
    
    guard status != errSecItemNotFound else {
      throw KeychainError.noPassword
    }
    
    guard status == errSecSuccess else {
      throw KeychainError.unhandledError(status)
    }
  }
  
  static func getPassword(service: String, account: String) throws -> String {
    // create the search query
    let query: NSDictionary = [kSecClass: kSecClassInternetPassword,
                         kSecAttrService: service,
                         kSecAttrAccount: account,
                          kSecMatchLimit: kSecMatchLimitOne,
                          kSecReturnData: true]
    
    var item: CFTypeRef?
    let status = SecItemCopyMatching(query, &item)
    
    guard status != errSecItemNotFound
    else {
      throw KeychainError.noPassword
    }
    
    guard status == errSecSuccess
    else {
      throw KeychainError.unhandledError(status)
    }
    
    // extract the result
    guard let passwordData = item as? Data,
          let password = String(data: passwordData, encoding: String.Encoding.utf8)
    else {
      throw KeychainError.unexpectedPasswordData
    }
    
    return password
  }
  
  static func delete(service: String, account: String) throws {
    // prepare the query dict
    let query: NSDictionary = [kSecClass: kSecClassInternetPassword,
                         kSecAttrService: service,
                         kSecAttrAccount: account]
    
    // delete the item
    let status = SecItemDelete(query)
    
    guard status != errSecItemNotFound
    else {
      throw KeychainError.noPassword
    }
    
    guard status == errSecSuccess else {
      throw KeychainError.unhandledError(status)
    }
  }
}
