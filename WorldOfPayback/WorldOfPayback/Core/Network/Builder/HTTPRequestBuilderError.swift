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
}
