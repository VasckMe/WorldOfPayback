//
//  TransactionViewModelTests.swift
//  WorldOfPaybackTests
//
//  Created by Anton Kasaryn on 7.03.24.
//

import XCTest
@testable import WorldOfPayback

final class TransactionViewModelTests: XCTestCase {

    var sut: TransactionViewModel!
    
    override func setUpWithError() throws {
        let dataProvider = TransactionViewDataProvider()
        
        sut = TransactionViewModel(
            networkService: DummyNetworkService(),
            persistenceStorageService: DummyPersistenceStorageService(),
            dataProvider: dataProvider
        )
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testLocalizationLabels() {
        switch Locale.current.language.languageCode {
        case "pl":
            XCTAssertEqual(sut.offlineLabel, "Nieaktywny")
            XCTAssertEqual(sut.summaryLabel, "Suma: 0")
            XCTAssertEqual(sut.titleLabel, "Lista transakcji")
            XCTAssertEqual(sut.fetchButtonTitleLabel, "Pobierz")
            XCTAssertEqual(sut.filterMenuLabel, "Filtr")
            XCTAssertEqual(sut.categoryMenuLabel, "Kategoria")
            XCTAssertEqual(sut.alertAnswerLabel, "Ok")
            XCTAssertEqual(sut.errorLabel, "Błąd")
        case "en":
            XCTAssertEqual(sut.offlineLabel, "Offline")
            XCTAssertEqual(sut.summaryLabel, "Sum: 0")
            XCTAssertEqual(sut.titleLabel, "Transaction List")
            XCTAssertEqual(sut.fetchButtonTitleLabel, "Fetch")
            XCTAssertEqual(sut.filterMenuLabel, "Filter")
            XCTAssertEqual(sut.categoryMenuLabel, "Category")
            XCTAssertEqual(sut.alertAnswerLabel, "Ok")
            XCTAssertEqual(sut.errorLabel, "Error")
        default:
            XCTAssertEqual(sut.offlineLabel, "Offline")
        }
    }
}
