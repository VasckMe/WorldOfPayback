//
//  TransactionViewModel.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 27.02.24.
//

import Foundation

final class TransactionViewModel: ObservableObject {
    @Published var transactions: [PBTransaction] = []
    @Published var category: PBTransactionCategory = .all
    
    @Published var isLoading = false
    @Published var isError = false
        
    private let networkService: NetworkServiceProtocol
    
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
    
    var summaryValue: Int {
        return transactionsToShow.reduce(0) { $0 + $1.amount}
    }
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
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
