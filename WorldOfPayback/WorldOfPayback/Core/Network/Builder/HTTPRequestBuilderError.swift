//
//  HTTPRequestBuilderError.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 27.02.24.
//

enum HTTPRequestBuilderError: Error {
    case invalidBaseURL
    case invalidQueryParameters
    case invalidBody
    
    var description: String {
        switch self {
        case .invalidBaseURL:
            return "HTTPRequestBuilderError_invalidBaseURL_description".localized()
        case .invalidQueryParameters:
            return "HTTPRequestBuilderError_invalidQueryParameters_description".localized()
        case .invalidBody:
            return "HTTPRequestBuilderError_invalidBody_description".localized()
        }
    }
}
