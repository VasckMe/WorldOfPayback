//
//  PersistenceStorageServiceTest.swift
//  WorldOfPaybackTests
//
//  Created by Anton Kasaryn on 3.03.24.
//

import XCTest
@testable import WorldOfPayback

final class PersistenceStorageServiceTest: XCTestCase {
    private var sut: PersistenceStorageServiceChecker!
        
    override func setUpWithError() throws {
        sut = PersistenceStorageServiceChecker()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    // MARK: - Test methods
    
    func testSaveSuccess() async throws {
        try await sut.save(transactions: [])
        
        XCTAssertNil(sut.saveResultError)
        XCTAssertTrue(sut.calledSaveMethod)
        XCTAssertEqual(sut.callSaveMethodCount, 1)
    }
    
    func testSaveFailure() async throws {
        sut.saveResultError = PersistenceStorageManagerError.invalidContextSave
        
        try await sut.save(transactions: [])
        
        XCTAssertNotNil(sut.saveResultError)
        XCTAssertTrue(sut.calledSaveMethod)
        XCTAssertEqual(sut.callSaveMethodCount, 1)
    }
    
    func testGetTransactionsSuccess() async throws {
        sut.getTransactionResultSuccess = [
            PBTransaction(
                id: 1,
                partnerDisplayName: "First",
                category: 0,
                description: "First_Description",
                bookingDate: Date(),
                amount: 19,
                currency: "PBP"
            ),
            PBTransaction(
                id: 2,
                partnerDisplayName: "Second",
                category: 1,
                description: "Second_Description",
                bookingDate: Date(),
                amount: 7,
                currency: "PBP"
            )
        ]
        
        let transactions = try await sut.getTransactions()
        
        XCTAssertFalse(transactions.isEmpty, "Transactions number can't be 0")
        XCTAssertEqual(transactions.count, 2, "Transactions must be equal to 2")
        XCTAssertTrue(sut.calledGetTransactionsMethod)
        XCTAssertEqual(sut.callGetTransactionsMethodCount, 1)
        XCTAssertNil(sut.getTransactionResultError)
    }
    
    func testGetTransactionsFailure() async throws {
        sut.getTransactionResultError = PersistenceStorageManagerError.invalidContextFetch
        
        do {
            let _ = try await sut.getTransactions()
        } catch {
            XCTAssertNotNil(error)
            XCTAssertTrue(sut.calledGetTransactionsMethod)
            XCTAssertEqual(sut.callGetTransactionsMethodCount, 1)
        }
    }
}
