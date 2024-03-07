//
//  PersistenceStorageServiceTests.swift
//  WorldOfPaybackTests
//
//  Created by Anton Kasaryn on 3.03.24.
//

import XCTest
@testable import WorldOfPayback

final class PersistenceStorageServiceTest: XCTestCase {
    private var sut: PersistenceStorageServiceSpy!
        
    override func setUpWithError() throws {
        sut = PersistenceStorageServiceSpy()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    // MARK: - Test methods
    
    func testSaveSuccess() async throws {
        try await sut.save(
            transactions: [PBTransaction(
            id: 0,
            partnerDisplayName: "name",
            category: 1,
            description: nil,
            bookingDate: Date(),
            amount: 4,
            currency: "PBP"
        )])
        
        XCTAssertNil(sut.stockSaveError)
        XCTAssertTrue(sut.callSave)
        XCTAssertEqual(sut.callSaveCount, 1)
        XCTAssertEqual(sut.stockSaveTransactions.count, 1)
    }
    
    func testSaveFailure() async throws {
        sut.stockSaveError = PersistenceStorageManagerError.invalidContextSave
        
        do {
            try await sut.save(transactions: [])
        } catch {
            XCTAssertNotNil(sut.stockSaveError)
            XCTAssertTrue(sut.callSave)
            XCTAssertEqual(sut.callSaveCount, 1)
        }
    }
    
    func testGetTransactionsSuccess() async throws {
        sut.stockGetTransactions = [
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
        do {
            let transactions = try await sut.getTransactions()
            XCTAssertFalse(transactions.isEmpty, "Transactions number can't be 0")
            XCTAssertEqual(transactions.count, 2, "Transactions must be equal to 2")
            XCTAssertTrue(sut.callGetTransactions)
            XCTAssertEqual(sut.callGetTransactionsCount, 1)
            XCTAssertNil(sut.stockGetTransactionsError)
        } catch {
            fatalError("Unexpected error")
        }
    }
    
    func testGetTransactionsFailure() async throws {
        sut.stockGetTransactionsError = PersistenceStorageManagerError.invalidContextFetch
        
        do {
            let _ = try await sut.getTransactions()
        } catch {
            XCTAssertNotNil(error)
            XCTAssertTrue(sut.callGetTransactions)
            XCTAssertEqual(sut.callGetTransactionsCount, 1)
        }
    }
}
