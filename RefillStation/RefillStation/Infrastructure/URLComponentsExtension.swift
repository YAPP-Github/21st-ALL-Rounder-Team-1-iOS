//
//  URLComponentsExtension.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/06.
//

import Foundation

extension URLComponents {
    func toURLRequest(method: HTTPMethod, httpBody: Data? = nil, contentType: String = "application/json") -> URLRequest? {
        guard let url = url else { return nil }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.name
        if let httpBody = httpBody {
            urlRequest.httpBody = httpBody
            urlRequest.addValue(contentType, forHTTPHeaderField: "Content-Type")
        }

        return urlRequest
    }
}
