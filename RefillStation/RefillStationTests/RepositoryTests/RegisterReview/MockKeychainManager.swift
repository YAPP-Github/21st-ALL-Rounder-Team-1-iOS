//
//  MockKeychainManager.swift
//  RefillStationTests
//
//  Created by kong on 2023/02/27.
//

import Foundation
@testable import RefillStation

final class MockKeychainManager: KeychainManagerInterface {
    func addItem(key: Any, value: Any) -> Bool {
        true
    }
    func getItem(key: Any) -> Any? {
        nil
    }
    func updateItem(key: Any, value: Any) -> Bool {
        true
    }
    func deleteItem(key: String) -> Bool {
        true
    }
    func deleteUserToken() -> Result<Void, Error> {
        .success(())
    }
}
