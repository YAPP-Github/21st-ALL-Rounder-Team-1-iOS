//
//  KeychainManager.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/24.
//

import Foundation

final class KeychainManager {

    static let shared = KeychainManager()

    private init() {}

    func addItem(key: Any, value: Any) -> Bool {
        let addQuery: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecValueData: (value as AnyObject).data(using: String.Encoding.utf8.rawValue) as Any
        ]

        let result: Bool = {
            let status = SecItemAdd(addQuery as CFDictionary, nil)
            if status == errSecSuccess {
                return true
            } else if status == errSecDuplicateItem {
                return updateItem(key: key, value: value)
            }

            print("addItem Error : \(status.description))")
            return false
        }()

        return result
    }

    func getItem(key: Any) -> Any? {
        let getQuery: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnAttributes: true,
            kSecReturnData: true
        ]
        var item: CFTypeRef?
        let result = SecItemCopyMatching(getQuery as CFDictionary, &item)

        if result == errSecSuccess {
            if let existingItem = item as? [String: Any],
               let data = existingItem[kSecValueData as String] as? Data,
               let password = String(data: data, encoding: .utf8) {
                return password
            }
        }

        print("getItem Error : \(result.description)")
        return nil
    }

    func updateItem( key: Any, value: Any) -> Bool {
        let prevQuery: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                              kSecAttrAccount: key]
        let updateQuery: [CFString: Any] = [kSecValueData: (value as AnyObject).data(using: String.Encoding.utf8.rawValue) as Any]

        let result: Bool = {
            let status = SecItemUpdate(prevQuery as CFDictionary, updateQuery as CFDictionary)
            if status == errSecSuccess { return true }

            print("updateItem Error : \(status.description)")
            return false
        }()

        return result
    }

    func deleteItem(key: String) -> Bool {
        let deleteQuery: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                            kSecAttrAccount: key]
        let status = SecItemDelete(deleteQuery as CFDictionary)
        if status == errSecSuccess { return true }

        print("deleteItem Error : \(status.description)")
        return false
    }
}