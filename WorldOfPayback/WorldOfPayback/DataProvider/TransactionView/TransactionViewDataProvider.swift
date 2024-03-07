//
//  TransactionViewDataProvider.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 5.03.24.
//

final class TransactionViewDataProvider: TransactionViewDataProviderProtocol {
    var offlineLabel: String {
        return "TransactionView_Text_offline".localized()
    }
    
    var summaryLabel: String {
        return "TransactionView_Text_summary".localized()
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
    
    var errorLabel: String {
        return "Error".localized()
    }
}

