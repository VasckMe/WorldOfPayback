//
//  HTTPRequestExecutorTests.swift
//  WorldOfPaybackTests
//
//  Created by Anton Kasaryn on 3.03.24.
//

import XCTest
@testable import WorldOfPayback

final class HTTPRequestExecutorTest: XCTestCase {
    private var sut: HTTPRequestExecutorSpy!
        
    override func setUpWithError() throws {
        sut = HTTPRequestExecutorSpy()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    // MARK: - Test methods
    
    func testExecuteSuccess() async throws {
        sut.stockSuccess = "Success"
        
        let data: String = try await sut.execute(request: .transactionGET)
        XCTAssertNotNil(data)
        XCTAssertTrue(sut.callExecute)
        XCTAssertEqual(sut.callExecuteCount, 1)
    }
    
    func testExecuteFailure() async throws {
        sut.stockError = NetworkError.unknown
        
        do {
            let _: String? = try await sut.execute(request: .transactionGET)
        } catch {
            XCTAssertNotNil(error)
            XCTAssertTrue(sut.callExecute)
            XCTAssertEqual(sut.callExecuteCount, 1)
        }
    }
}
