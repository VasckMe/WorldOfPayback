//
//  NetworkError.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 27.02.24.
//

enum NetworkError: Error {
    case badResponse
    case badParsing
    case offline
    case unknown
    
    var description: String {
        switch self {
        case .badResponse:
            return "NetworkError_badResponse_description".localized()
        case .badParsing:
            return "NetworkError_badParsing_description".localized()
        case .offline:
            return "NetworkError_offline_description".localized()
        case .unknown:
            return "NetworkError_unknown_description".localized()
        }
    }
}
