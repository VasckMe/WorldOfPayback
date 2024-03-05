//
//  HTTPRequestExecutorChecker.swift
//  WorldOfPaybackTests
//
//  Created by Anton Kasaryn on 3.03.24.
//

import Foundation
@testable import WorldOfPayback

final class HTTPRequestExecutorChecker: HTTPRequestExecutorProtocol {
    var calledMethod = false
    var callMethodCount = 0
    var resultError: Error?
    var resultSuccess: Any!
    
    func execute<T: Decodable>(request: HTTPRequest) async throws -> T {
        calledMethod = true
        callMethodCount += 1
        
        await Task(priority: .medium) {
            
          await withUnsafeContinuation { continuation in
            Thread.sleep(forTimeInterval: 1)
            continuation.resume()
          }
            
        }.value
        
        if let error = resultError {
            throw error
        } else {
            return resultSuccess as! T
        }
    }
}
