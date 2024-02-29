//
//  PBTransaction.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 27.02.24.
//

import Foundation

struct PBTransaction: Identifiable, Hashable {
    let id: Int
    let partnerDisplayName: String
    let category: Int
    let description: String?
    let bookingDate: Date
    let amount: Int
    let currency: String
    
    var valueString: String {
        return "\(amount) \(currency)"
    }
    
    var timeString: String {
        let formatter = HelperUtilities.dateFormatter
        formatter.dateFormat = DateFormat.HHmm.rawValue
        let dateString = formatter.string(from: bookingDate)
        return dateString
    }
}

extension PBTransaction {
    init?(response: PBTransactionResponse) {
        let formatter = HelperUtilities.dateFormatter
        formatter.dateFormat = DateFormat.long.rawValue
        
        guard
            let id = Int(response.alias.reference),
            let date = formatter.date(from: response.transactionDetail.bookingDate)
        else {
            return nil
        }
        
        self.init(
            id: id,
            partnerDisplayName: response.partnerDisplayName,
            category: response.category,
            description: response.transactionDetail.description,
            bookingDate: date,
            amount: response.transactionDetail.value.amount,
            currency: response.transactionDetail.value.currency
        )
    }
    
    init?(model: Transaction) {
        guard
            let displayName = model.partnerDisplayName,
            let bookingDate = model.bookingDate,
            let currency = model.currency
        else {
            return nil
        }
        
        self.init(
            id: Int(model.id),
            partnerDisplayName: displayName,
            category: Int(model.category),
            description: model.transactionDescription,
            bookingDate: bookingDate,
            amount: Int(model.amount),
            currency: currency
        )
    }
}
