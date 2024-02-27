//
//  HTTPRequestBuilderProtocol.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 27.02.24.
//

import Foundation

protocol HTTPRequestBuilderProtocol {
    func build(httpRequest: HTTPRequest) throws -> URLRequest
}
