//
//  HTTPRequestExecutorTest.swift
//  WorldOfPaybackTests
//
//  Created by Anton Kasaryn on 3.03.24.
//

import XCTest
@testable import WorldOfPayback

final class HTTPRequestExecutorTest: XCTestCase {

    private var sut: HTTPRequestExecutorChecker!
        
    override func setUpWithError() throws {
        sut = HTTPRequestExecutorChecker()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testExecuteSuccess() async throws {
        sut.resultSuccess = "Success"
        
        let data: String? = try? await sut.execute(request: .transactionGET)
        
        XCTAssertTrue(sut.calledMethod)
        XCTAssertEqual(sut.callMethodCount, 1)
        XCTAssertNotNil(data)
    }
    
    func testExecuteFailure() async throws {
        sut.resultError = NetworkError.unknown
        
        do {
            let _: String? = try await sut.execute(request: .transactionGET)
        } catch {
            XCTAssertTrue(sut.calledMethod)
            XCTAssertEqual(sut.callMethodCount, 1)
            XCTAssertNotNil(error)
        }
    }
}
