//
//  TransactionViewDataProviderProtocol.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 5.03.24.
//

protocol TransactionViewDataProviderProtocol {
    var offlineLabel: String { get }
    var summaryLabel: String { get }
    var titleLabel: String { get }
    var fetchButtonTitleLabel: String { get }
    var filterMenuLabel: String { get }
    var categoryMenuLabel: String { get }
    var alertAnswerLabel: String { get }
    var errorLabel: String { get }
}
