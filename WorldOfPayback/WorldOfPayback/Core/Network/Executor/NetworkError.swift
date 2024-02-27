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
        // TODO: Error with localization
        // TODO: Languages
        return "Error"
    }
}
