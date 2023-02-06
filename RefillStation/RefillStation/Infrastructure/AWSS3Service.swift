//
//  AWSS3Service.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/06.
//

import UIKit
import AWSS3
import ClientRuntime
import AWSClientRuntime

enum AWSS3Error: Error {
    case imageDataConvertFailed
}

public class AWSS3Service {
    enum BucketType {
        case review
        case store

        var bucketName: String {
            return "pump-img-bucket"
        }

        var URL: String {
            switch self {
            case .review:
                return "https://pump-img-bucket.s3.ap-northeast-2.amazonaws.com/review"
            case .store:
                return "https://pump-img-bucket.s3.ap-northeast-2.amazonaws.com/store"
            }
        }
    }

    let client: S3Client

    public init() async {
        do {
            client = try await S3Client()
        } catch {
            fatalError()
        }
    }

    func uploadImage(type: BucketType, key: String, image: UIImage?) async throws -> String {
        guard let imageData = image?.jpegData(compressionQuality: 1) else { throw AWSS3Error.imageDataConvertFailed }
        let dataStream = ByteStream.from(data: imageData)

        let input = PutObjectInput(
            body: dataStream,
            bucket: type.bucketName,
            key: key
        )

        _ = try await client.putObject(input: input)

        return type.URL + "/\(key)"
    }
}
