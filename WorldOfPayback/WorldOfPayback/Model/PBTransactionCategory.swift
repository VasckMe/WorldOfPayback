//
//  PBTransactionCategory.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 29.02.24.
//

enum PBTransactionCategory: CaseIterable {
    case all
    case first
    case second
    case third
    
    var id: Int {
        switch self {
        case .all:
            return 0
        case .first:
            return 1
        case .second:
            return 2
        case .third:
            return 3
        }
    }
    
    var title: String {
        switch self {
        case .all:
            return "All"
        case .first:
            return "1"
        case .second:
            return "2"
        case .third:
            return "3"
        }
    }
}
