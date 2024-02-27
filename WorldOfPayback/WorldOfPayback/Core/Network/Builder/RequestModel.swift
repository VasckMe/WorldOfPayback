//
//  RequestModel.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 27.02.24.
//

struct RequestModel: RequestModelProtocol {
    var method: HTTPMethod
    var path: HTTPPath
    var query: [String: String]?
    var header: [String: String]?
    var body: Encodable?
}
