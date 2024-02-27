//
//  TransactionDetailedView.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 27.02.24.
//

import SwiftUI

struct TransactionDetailedView: View {
    let transaction: PBTransaction
    
    var body: some View {
        VStack {
            Text("\(transaction.partnerDisplayName)")
            Text("\(transaction.description ?? "-")")
        }
    }
}

struct TransactionDetailedView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDetailedView(
            transaction: PBTransaction(
                id: 1,
                partnerDisplayName: "Ymos",
                category: 0,
                description: "Description2",
                bookingDate: Date(),
                amount: 19,
                currency: "PBP"
            )
        )
    }
}
