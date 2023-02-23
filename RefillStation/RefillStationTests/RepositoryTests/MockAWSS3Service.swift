//
//  MockAWSS3Service.swift
//  RefillStationTests
//
//  Created by 천수현 on 2023/02/22.
//

import XCTest
@testable import RefillStation

final class MockAWSS3Service: AWSS3ServiceInterface {
    func upload(type: RefillStation.AWSS3Service.Bucket, image: UIImage?) async throws -> String {
        return ""
    }
}
