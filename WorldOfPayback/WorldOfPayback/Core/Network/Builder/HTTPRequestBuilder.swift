//
//  HTTPRequestBuilder.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 27.02.24.
//

import Foundation

final class HTTPRequestBuilder: HTTPRequestBuilderProtocol {
    #if PROD || RELEASE
    private let baseURLString = "https://api.payback.com"
    #elseif DEBUG
    private let baseURLString = "https://api-test.payback.com"
    #endif
    
    func build(httpRequest: HTTPRequest) throws -> URLRequest {
        do {
            let url = try buildURL(request: httpRequest.request)
            return try buildURLRequest(url: url, request: httpRequest.request)
        } catch {
            throw error
        }
    }
}

// MARK: - Private
    
private extension HTTPRequestBuilder {
    func buildURL(request: HTTPRequestModelProtocol) throws -> URL {
        guard let baseURL = URL(string: baseURLString) else {
            throw HTTPRequestBuilderError.invalidBaseURL
        }
        
        return try buildURL(url: baseURL, request: request)
    }
    
    func buildURL(url: URL, request: HTTPRequestModelProtocol) throws -> URL {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw HTTPRequestBuilderError.invalidBaseURL
        }
        
        components.path += request.path.string
        
        if let queryItems = buildQueryParameters(request: request) {
            components.queryItems = queryItems
        }
        
        guard let url = components.url else {
            throw HTTPRequestBuilderError.invalidQueryParameters
        }
        
        return url
    }
    
    private func buildQueryParameters(request: HTTPRequestModelProtocol) -> [URLQueryItem]? {
        guard let parameters = request.query else {
            return nil
        }
        
        return parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
    
    private func buildURLRequest(url: URL, request: HTTPRequestModelProtocol) throws -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        let body = try buildBody(request: request)
        urlRequest.httpBody = body
        
        urlRequest = addHeaders(from: request, to: urlRequest)
        
        return urlRequest
    }
    
    private func buildBody(request: HTTPRequestModelProtocol) throws -> Data? {
        guard let body = request.body else {
            return nil
        }
        
        do {
            return try JSONEncoder().encode(body)
        } catch {
            throw HTTPRequestBuilderError.invalidBody
        }
    }
    
    private func addHeaders(from request: HTTPRequestModelProtocol, to urlRequest: URLRequest) -> URLRequest {
        var headers: [String: String] = [:]
        
        if let header = request.header {
            headers = header
        }
        
        var updatedURLRequest = urlRequest
        
        for (key, value) in headers {
            updatedURLRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        return updatedURLRequest
    }
}

