//
//  AWSS3Service.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/06.
//

import UIKit
import AWSS3
import AWSCore

enum AWSS3Error: Error {
    case imageDataConvertFailed
}

public class AWSS3Service {
    enum Bucket {
        case review
        case store

        static let bucketName = "pump-img-bucket"
        static let baseURL = "https://pump-img-bucket.s3.ap-northeast-2.amazonaws.com"

        var name: String {
            switch self {
            case .review:
                return "review"
            case .store:
                return "store"
            }
        }
    }

    private var path: String {
        guard let path = Bundle.main.path(forResource: "AWSAccessKey", ofType: "plist") else { return "" }
        return path
    }

    private var accessKey: String {
        guard let dictionary = NSDictionary(contentsOfFile: path),
              let key = dictionary["AWS_ACCESS_KEY"] as? String else { return "" }
        return key
    }

    private var secretKey: String {
        guard let dictionary = NSDictionary(contentsOfFile: path),
              let key = dictionary["AWS_SECRET_KEY"] as? String else { return "" }
        return key
    }

    private var region: String {
        guard let dictionary = NSDictionary(contentsOfFile: path),
              let key = dictionary["AWS_REGION"] as? String else { return "" }
        return key
    }

    static let shared = AWSS3Service()

    init() {
        let credentialsProvider = AWSStaticCredentialsProvider(accessKey: accessKey, secretKey: secretKey)
        let configuration = AWSServiceConfiguration(region: .APNortheast2, credentialsProvider: credentialsProvider)
        AWSServiceManager.default().defaultServiceConfiguration = configuration

        let tuConf = AWSS3TransferUtilityConfiguration()
        tuConf.isAccelerateModeEnabled = false

        AWSS3TransferUtility.register(
            with: configuration!,
            transferUtilityConfiguration: tuConf,
            forKey: "utility-key"
        )
    }

    func upload(type: Bucket, image: UIImage?, completion: @escaping (Result<String, Error>) -> Void) {
        guard let transferUtility = AWSS3TransferUtility.s3TransferUtility(forKey: "utility-key"),
              let imageData = image?.jpegData(compressionQuality: 1) else { return }

        let id = UUID().uuidString
        let fileKey = "\(type.name)/\(id).jpeg"

        transferUtility.uploadData(
            imageData,
            bucket: Bucket.bucketName,
            key: fileKey,
            contentType: "image/jpeg",
            expression: nil) { task, error in
                print(error)
                guard error == nil else { return }
                completion(.success(Bucket.baseURL + "/" + fileKey))
            }
    }
}
