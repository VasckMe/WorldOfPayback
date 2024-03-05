//
//  NetworkServiceTest.swift
//  WorldOfPaybackTests
//
//  Created by Anton Kasaryn on 3.03.24.
//

import XCTest
@testable import WorldOfPayback

final class NetworkServiceTest: XCTestCase {

    private var sut: NetworkServiceChecker!
    private var requestExecutorChecker: HTTPRequestExecutorChecker!
    private var persistenceStorageServiceChecker: PersistenceStorageServiceChecker!
    
    override func setUpWithError() throws {
        requestExecutorChecker = HTTPRequestExecutorChecker()
        persistenceStorageServiceChecker = PersistenceStorageServiceChecker()
        sut = NetworkServiceChecker(
            persistenceStorageService: persistenceStorageServiceChecker,
            requestExecutor: requestExecutorChecker
        )
    }

    override func tearDownWithError() throws {
        requestExecutorChecker = nil
        persistenceStorageServiceChecker = nil
        sut = nil
    }
    
    // MARK: - Test methods
    
    func testFetchTransactionsSuccess() async throws {
        requestExecutorChecker.resultSuccess = mockResponseTransactions
        
        let transactions = try? await sut.fetchTransactions()
    
        XCTAssertTrue(sut.calledMethod)
        XCTAssertEqual(sut.callMethodCount, 1)
        XCTAssertTrue(sut.didGetExecutorResponse)
        XCTAssertFalse(sut.didGetPersistenceResponse)
        XCTAssertNotNil(transactions)
        XCTAssertFalse(transactions?.isEmpty ?? true, "Transactions number can't be 0")
        XCTAssertEqual(transactions?.count, 2, "Transactions must be equal to 2")
    }
    
    func testFetchTransactionsPersistenceSuccess() async throws {
        requestExecutorChecker.resultError = NetworkError.offline
        persistenceStorageServiceChecker.getTransactionResultSuccess = mockTransactions
        
        let transactions = try? await sut.fetchTransactions()
    
        XCTAssertTrue(sut.calledMethod)
        XCTAssertEqual(sut.callMethodCount, 1)
        XCTAssertTrue(sut.didGetExecutorResponse)
        XCTAssertTrue(sut.didGetPersistenceResponse)
        XCTAssertNotNil(transactions)
        XCTAssertFalse(transactions?.isEmpty ?? true, "Transactions number can't be 0")
        XCTAssertEqual(transactions?.count, 2, "Transactions must be equal to 2")
    }
    
    func testFetchTransactionsFailure() async throws {
        requestExecutorChecker.resultError = NetworkError.unknown
        persistenceStorageServiceChecker.getTransactionResultError = PersistenceStorageManagerError.unknown
        
        
        do {
            let _ = try await sut.fetchTransactions()
        } catch {
            XCTAssertNotNil(error)
            XCTAssertTrue(sut.calledMethod)
            XCTAssertEqual(sut.callMethodCount, 1)
            XCTAssertTrue(sut.didGetExecutorResponse)
            XCTAssertFalse(sut.didGetPersistenceResponse)
        }
    }
}

// MARK: - Mocked models

private let mockResponseTransactions: PBTransactionsResponse = PBTransactionsResponse(items: [
    PBTransactionResponse(
        partnerDisplayName: "First",
        alias: PBTransactionAliasResponse(reference: "1"),
        category: 0,
        transactionDetail: PBTransactionDetailResponse(
            description: "-",
            bookingDate: "2022-07-24T10:59:05+0200",
            value: PBTransactionValueResponse(
                amount: 10,
                currency: "PBP"
            )
        )
    ),
    
    PBTransactionResponse(
        partnerDisplayName: "Second",
        alias: PBTransactionAliasResponse(reference: "2"),
        category: 1,
        transactionDetail: PBTransactionDetailResponse(
            description: "-",
            bookingDate: "2022-07-24T10:59:05+0200",
            value: PBTransactionValueResponse(
                amount: 10,
                currency: "PBP"
            )
        )
    )
])

private let mockTransactions = [
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
