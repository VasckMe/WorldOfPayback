//
//  HTTPRequestExecutorSpy.swift
//  WorldOfPaybackTests
//
//  Created by Anton Kasaryn on 3.03.24.
//

import Foundation
@testable import WorldOfPayback

final class HTTPRequestExecutorSpy: HTTPRequestExecutorProtocol {
    var callExecute = false
    var callExecuteCount = 0
    var stockError: Error?
    var stockSuccess: Any!
    
    func execute<T: Decodable>(request: HTTPRequest) async throws -> T {
        callExecute = true
        callExecuteCount += 1
        
        await Task(priority: .medium) {
          await withUnsafeContinuation { continuation in
            Thread.sleep(forTimeInterval: 1)
            continuation.resume()
          }
        }.value
        
        if let error = stockError {
            throw error
        } else {
            return stockSuccess as! T
        }
    }
}
