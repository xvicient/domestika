//
//  ApiClient.swift
//  Domestika
//
//  Created by Xavier on 21/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case invalidInput
    case httpCode(Int, Data?)
    case failedDecoding(Error)
    case unexpectedResponse
    case other(Error)
}

protocol APIClientApi {
    var baseURL: String { get }
    func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, APIError>) -> Void)
}

enum APIClientFactory {
    static func make(baseURL: String,
                     session: URLSession,
                     logger: APIClientLoggerApi?) -> APIClientApi {
        APIClient(baseURL: baseURL,
                  session: session,
                  logger: logger)
    }
}

struct APIClient {
    enum Defaults {
        static let successfulStatusCodes = 200 ..< 300
        static let jsonDecoder: JSONDecoder = {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return decoder
        }()
    }

    let baseURL: String
    let session: URLSession
    let logger: APIClientLoggerApi?
}

extension APIClient: APIClientApi {
    func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, APIError>) -> Void) {
        request(endpoint, successfulStatusCodes: Defaults.successfulStatusCodes, jsonDecoder: Defaults.jsonDecoder, completion: completion)
    }

    func request<T: Decodable>(_ endpoint: Endpoint,
                               successfulStatusCodes: Range<Int> = Defaults.successfulStatusCodes,
                               jsonDecoder: JSONDecoder = Defaults.jsonDecoder,
                               completion: @escaping (Result<T, APIError>) -> Void) {
        var request: URLRequest
        do {
            request = try endpoint.urlRequest(baseURL: baseURL)
        } catch {
            return DispatchQueue.main.async {
                completion(.failure(error as? APIError ?? .other(error)))
            }
        }

        logger?.logRequest(request)

        session.dataTask(with: request) { [logger] data, response, error in
            logger?.logResponse(data, response, error)

            let result: Result<T, APIError> = APIClient.mapToResult(jsonDecoder, data, response, error, successfulStatusCodes)

            return DispatchQueue.main.async {
                completion(result)
            }
        }
        .resume()
    }
}

private extension APIClient {
    static func mapToResult<T: Decodable>(_ jsonDecoder: JSONDecoder,
                                          _ data: Data?,
                                          _ response: URLResponse?,
                                          _ error: Error?,
                                          _ successfulStatusCodes: Range<Int>) -> Result<T, APIError> {
        return Result {
            if let error = error {
                throw APIError.other(error)
            }
            guard let data = data,
                let code = (response as? HTTPURLResponse)?.statusCode else {
                throw APIError.unexpectedResponse
            }
            guard successfulStatusCodes.contains(code) else {
                throw APIError.httpCode(code, data)
            }
            do {
                let element = try jsonDecoder.decode(T.self, from: data)
                return element
            } catch {
                if T.self == NoResult.self {
                    return NoResult() as! T
                }
                throw APIError.failedDecoding(error)
            }
        }
        .mapError { $0 as! APIError }
    }
}
