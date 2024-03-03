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
    
    var offlineLabel: String {
        return "TransactionView_Text_offline".localized()
    }
    
    var summaryLabel: String {
        return "TransactionView_Text_summary".localized() + ": " + String(transactionsToShow.reduce(0) { $0 + $1.amount})
    }
    
    var titleLabel: String {
        return "TransactionView_title".localized()
    }
    
    var fetchButtonTitleLabel: String {
        return "TransactionView_Button_fetch_title".localized()
    }
    
    var filterMenuLabel: String {
        return "TransactionView_Menu_filter_title".localized()
    }
    
    var categoryMenuLabel: String {
        return "TransactionView_Menu_category_title".localized()
    }
    
    var alertAnswerLabel: String {
        return "TransactionView_Alert_answer".localized()
    }
    
    var networkOfflineLabel: String {
        return "NetworkError_offline_description".localized()
    }
    
    var errorLabel: String {
        return "Error".localized()
    }
    
    private let networkService: NetworkServiceProtocol
    
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
