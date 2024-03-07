//
//  NetworkServiceTests.swift
//  WorldOfPaybackTests
//
//  Created by Anton Kasaryn on 3.03.24.
//

import XCTest
@testable import WorldOfPayback

final class NetworkServiceTest: XCTestCase {

    private var sut: NetworkServiceSpy!
    private var requestExecutorChecker: HTTPRequestExecutorSpy!
    
    override func setUpWithError() throws {
        requestExecutorChecker = HTTPRequestExecutorSpy()
        sut = NetworkServiceSpy(
            requestExecutor: requestExecutorChecker
        )
    }

    override func tearDownWithError() throws {
        requestExecutorChecker = nil
        sut = nil
    }
    
    // MARK: - Test methods
    
    func testFetchTransactionsSuccess() async throws {
        requestExecutorChecker.stockSuccess = mockResponseTransactions
        
        let transactions = try await sut.fetchTransactions()
        
        XCTAssertNotNil(transactions)
        XCTAssertTrue(sut.callFetch)
        XCTAssertEqual(sut.callFetchCount, 1)
        XCTAssertFalse(transactions.isEmpty, "Transactions number can't be 0")
        XCTAssertEqual(transactions.count, 2, "Transactions must be equal to 2")
    }
    
    func testFetchTransactionsFailure() async throws {
        requestExecutorChecker.stockError = NetworkError.unknown
        
        do {
            let _ = try await sut.fetchTransactions()
        } catch {
            XCTAssertNotNil(error)
            XCTAssertTrue(sut.callFetch)
            XCTAssertEqual(sut.callFetchCount, 1)
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
