//
//  HTTPRequest.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 27.02.24.
//

import Foundation

enum HTTPRequest {
    case transactionGET
    
    var request: RequestModelProtocol {
        switch self {
        case .transactionGET:
            return RequestModel(method: .get, path: .transactions)
        }
    }
}
