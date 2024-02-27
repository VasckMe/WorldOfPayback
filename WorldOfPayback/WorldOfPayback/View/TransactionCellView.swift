//
//  TransactionCellView.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 27.02.24.
//

import SwiftUI

struct TransactionCellView: View {
    
    let transaction: PBTransaction
    
    var body: some View {
        NavigationLink(destination: TransactionDetailedView(transaction: transaction)) {
            VStack(alignment: .leading) {
                Text("\(transaction.partnerDisplayName)")
            }
        }
    }
}

struct TransactionCellView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionCellView(
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
