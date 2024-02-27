//
//  HTTPRequest.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 27.02.24.
//

import Foundation

enum HTTPRequest {
    case transactionGET
    
    var request: HTTPRequestModelProtocol {
        switch self {
        case .transactionGET:
            return HTTPRequestModel(method: .get, path: .transactions)
        }
    }
}
