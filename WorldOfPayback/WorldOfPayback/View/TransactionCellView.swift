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
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(transaction.partnerDisplayName)
                        .bold()
                    Text(transaction.description ?? "-")
                    Text(transaction.timeString)
                        .underline(color: .black)
                }
                
                Spacer()
                
                Text(transaction.valueString)
            }
            .padding()
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
