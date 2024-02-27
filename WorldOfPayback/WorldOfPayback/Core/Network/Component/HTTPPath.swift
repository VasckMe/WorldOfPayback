//
//  HTTPPath.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 27.02.24.
//

import Foundation

enum HTTPPath {
    case transactions
    
    var string: String {
        switch self {
        case .transactions:
            return "/transactions"
        }
    }
}
