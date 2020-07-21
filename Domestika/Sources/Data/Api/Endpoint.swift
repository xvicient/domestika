//
//  Endpoint.swift
//  Domestika
//
//  Created by Xavier on 21/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get, post, put, patch, delete
}

struct Body {
    typealias Output = (data: Data, contentType: String)

    let generator: () throws -> (Output)

    init(generator: @escaping () throws -> (Output)) {
        self.generator = generator
    }
}

extension Body {
    static func json(params: [String: Any?]) -> Self {
        Body {
            let data = try JSONSerialization.data(withJSONObject: params)
            return (data, "application/json")
        }
    }
}

struct Endpoint {
    let path: String
    let method: HTTPMethod
    let headers: [String: String]?
    let queryParams: [String: String]?
    let body: Body?

    init(path: String, method: HTTPMethod, headers: [String: String]?, queryParams: [String: String]?, body: Body?) {
        self.path = path
        self.method = method
        self.headers = headers
        self.queryParams = queryParams
        self.body = body
    }

    func urlRequest(baseURL: String) throws -> URLRequest {
        guard let url = completeURL(baseURL: baseURL) else {
            throw APIError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue.uppercased()
        request.allHTTPHeaderFields = headers
        if let body = try body?.generator() {
            request.httpBody = body.data
            request.setValue(body.contentType, forHTTPHeaderField: "Content-Type")
        }
        return request
    }

    private func completeURL(baseURL: String) -> URL? {
        var urlComponents = URLComponents(string: baseURL + path)
        if let queryParams = queryParams {
            let queryItems = queryParams.reduce(into: [], { result, keyValue in
                result.append(URLQueryItem(name: keyValue.key, value: keyValue.value))
            })
            if urlComponents?.queryItems != nil {
                urlComponents?.queryItems?.append(contentsOf: queryItems)
            } else {
                urlComponents?.queryItems = queryItems
            }
        }
        return urlComponents?.url
    }
}
