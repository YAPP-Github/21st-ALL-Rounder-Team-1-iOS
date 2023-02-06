//
//  URLComponentsExtension.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/06.
//

import Foundation

extension URLComponents {
    func toURLRequest<HTTPBody: Encodable>(method: HTTPMethod, body: HTTPBody? = nil) -> URLRequest? {
        guard let url = url else { return nil }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.name
        if let body = body {
            urlRequest.httpBody = try? JSONEncoder().encode(body)
        }

        return urlRequest
    }
}
