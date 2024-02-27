//
//  HTTPRequestModelProtocol.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 27.02.24.
//

protocol HTTPRequestModelProtocol {
    var method: HTTPMethod { get }
    var path: HTTPPath { get }
    var query: [String: String]? { get }
    var header: [String: String]? { get }
    var body: Encodable? { get }
}
