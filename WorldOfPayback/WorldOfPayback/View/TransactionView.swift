//
//  TransactionView.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 27.02.24.
//

import SwiftUI

struct TransactionView: View {
    
    @ObservedObject var viewModel: TransactionViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.transactionsToShow) { transaction in
                    TransactionCellView(transaction: transaction)
                }
                .navigationTitle("Transactions list")
                .toolbar(content: {
                    HStack(alignment: .center) {
                        if viewModel.isLoading {
                            ProgressView()
                        } else {
                            Button("Fetch") {
                                viewModel.fetchTransactions()
                            }
                        }
                        
                        Menu("Filter") {
                            Menu("Category") {
                                ForEach(PBTransactionCategory.allCases, id: \.id) { category in
                                    Button("\(category.title)", action: { viewModel.category = category })
                                }
                            }
                        }
                    }
                })
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        TransactionView()
//    }
//}
