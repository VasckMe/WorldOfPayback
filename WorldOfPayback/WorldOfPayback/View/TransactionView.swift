//
//  TransactionView.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 27.02.24.
//

import SwiftUI

struct TransactionView: View {
    
    let models: [PBTransaction] = [
        PBTransaction(id: 0, partnerDisplayName: "Anon", category: 0, description: "Description", bookingDate: Date(), amount: 10, currency: "PBP"),
        PBTransaction(id: 1, partnerDisplayName: "Ymos", category: 0, description: "Description2", bookingDate: Date(), amount: 19, currency: "PBP")
    ]
    
    var body: some View {
        
        NavigationView {
            List(models) { transaction in
                TransactionCellView(transaction: transaction)
            }
        }.navigationTitle("Transaction List")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView()
    }
}
