//
//  NetworkService.swift
//  RefillStation
//
//  Created by kong on 2022/12/20.
//

import Foundation
import Alamofire

public enum NetworkError: Error {

}

extension Alamofire.DataTask: Cancellable { }

protocol NetworkServiceInterface {

}

final class NetworkService: NetworkServiceInterface {

}
