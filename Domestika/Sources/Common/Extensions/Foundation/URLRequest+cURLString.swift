//
//  URLRequest+cURLString.swift
//  Domestika
//
//  Created by Xavier on 21/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

import Foundation

extension URLRequest {
    var cURLString: String {
        var result = "curl -k "

        if let method = httpMethod {
            result += "-X \(method) \\\n"
        }

        if let headers = allHTTPHeaderFields {
            for (header, value) in headers {
                result += "-H \"\(header): \(value)\" \\\n"
            }
        }

        if let body = httpBody, !body.isEmpty, let string = String(data: body, encoding: .utf8), !string.isEmpty {
            result += "-d '\(string)' \\\n"
        }

        if let url = url {
            result += url.absoluteString
        }

        return result
    }
}
