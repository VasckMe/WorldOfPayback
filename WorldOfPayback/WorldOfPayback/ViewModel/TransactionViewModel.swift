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
    private let persistenceStorageService: PersistenceStorageServiceProtocol
    private let dataProvider: TransactionViewDataProviderProtocol
    
    init(
        networkService: NetworkServiceProtocol,
        persistenceStorageService: PersistenceStorageServiceProtocol,
        dataProvider: TransactionViewDataProviderProtocol
    ) {
        self.networkService = networkService
        self.persistenceStorageService = persistenceStorageService
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
                await handle(error: error)
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

// MARK: - Private

private extension TransactionViewModel {
    func handle(error: Error) async {
        guard let networkError = error as? NetworkError else {
            await MainActor.run {
                errorMessage = NetworkError.unknown.description
                isLoading = false
                isError = true
            }
            
            return
        }

        switch networkError {
        case .offline:
            let storedTransactions = try? await persistenceStorageService.getTransactions()
            
            await MainActor.run {
                if let transactions = storedTransactions {
                    self.transactions = transactions
                }
                
                errorMessage = networkError.description
                isLoading = false
                isError = true
            }
            
        default:
            await MainActor.run {
                errorMessage = networkError.description
                isLoading = false
                isError = true
            }
        }
    }
}
