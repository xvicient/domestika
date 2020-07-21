//
//  APIClientLogger.swift
//  Domestika
//
//  Created by Xavier on 21/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

import Foundation

protocol APIClientLoggerApi {
    func logRequest(_ request: URLRequest)
    func logResponse(_ data: Data?, _ response: URLResponse?, _ error: Error?)
}

enum APIClientLoggerFactory {
    static func make() -> APIClientLoggerApi {
        APIClientLogger()
    }
}

struct APIClientLogger {}

extension APIClientLogger: APIClientLoggerApi {
    func logRequest(_ request: URLRequest) {
        print("====REQUEST=====\n\(request.cURLString)\n================")
    }

    func logResponse(_ data: Data?, _ response: URLResponse?, _ error: Error?) {
        // Source: https://stackoverflow.com/a/45803922
        let response = response as? HTTPURLResponse
        let urlString = response?.url?.absoluteString
        let components = NSURLComponents(string: urlString ?? "")

        var responseLog = ""
        if let urlString = urlString {
            responseLog += "\(urlString)"
            responseLog += "\n\n"
        }
        if let statusCode =  response?.statusCode {
            responseLog += "HTTP Status Code \(statusCode)\n"
        }
        if let host = components?.host {
            responseLog += "Host: \(host)\n"
        }
        for (key, value) in response?.allHeaderFields ?? [:] {
            responseLog += "\(key): \(value)\n"
        }
        if let body = data {
            let bodyString = String(data: body, encoding: .utf8) ?? "Can't render body. Not utf8 encoded"
            responseLog += "\n\(bodyString)\n"
        }
        if let error = error {
            responseLog += "\nError: \(error.localizedDescription)\n"
        }
        print("====RESPONSE====\n\(responseLog)\n================")
    }
}
