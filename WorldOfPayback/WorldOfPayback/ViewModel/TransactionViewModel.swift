//
//  TransactionViewModel.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 27.02.24.
//

import Foundation

final class TransactionViewModel: ObservableObject {
    @Published var category: PBTransactionCategory = .all
    @Published var isLoading = false
    @Published var isError = false
    @Published private var transactions: [PBTransaction] = []
    
    var errorMessage = ""
    
    var transactionsToShow: [PBTransaction] {
        switch category {
        case .all: 
            return transactions
                .sorted(by: { $0.bookingDate > $1.bookingDate })
        default:
            return transactions
                .filter { $0.category == category.id }
                .sorted(by: { $0.bookingDate > $1.bookingDate })
        }
    }
    
    private let networkService: NetworkServiceProtocol
    private let dataProvider: TransactionViewDataProviderProtocol
    
    init(networkService: NetworkServiceProtocol, dataProvider: TransactionViewDataProviderProtocol) {
        self.networkService = networkService
        self.dataProvider = dataProvider
    }
    
    func fetchTransactions() {
        isLoading = true
        Task {
            do {
                let transactions = try await networkService.fetchTransactions()
                await MainActor.run {
                    self.transactions = transactions
                    isLoading = false
                }
            } catch {
                await MainActor.run {
                    errorMessage = (error as? NetworkError)?.description ?? "Error".localized()
                    isLoading = false
                    isError = true
                }
            }
        }
    }
}

extension TransactionViewModel {
    var offlineLabel: String {
        return dataProvider.offlineLabel
    }
    
    var summaryLabel: String {
        let summary = transactionsToShow.reduce(0) { $0 + $1.amount}
        return dataProvider.summaryLabel + ": " + String(summary)
    }
    
    var titleLabel: String {
        return dataProvider.titleLabel
    }
    
    var fetchButtonTitleLabel: String {
        return dataProvider.fetchButtonTitleLabel
    }
    
    var filterMenuLabel: String {
        return dataProvider.filterMenuLabel
    }
    
    var categoryMenuLabel: String {
        return dataProvider.categoryMenuLabel
    }
    
    var alertAnswerLabel: String {
        return dataProvider.alertAnswerLabel
    }
    
    var networkOfflineLabel: String {
        return dataProvider.networkOfflineLabel
    }
    
    var errorLabel: String {
        return dataProvider.errorLabel
    }
}
