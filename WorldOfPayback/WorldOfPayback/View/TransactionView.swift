//
//  TransactionView.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 27.02.24.
//

import SwiftUI

struct TransactionView: View {
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @ObservedObject var viewModel: TransactionViewModel
    @State var showNetworkAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.transactionsToShow) { transaction in
                    TransactionCellView(transaction: transaction)
                }
                
                Text(viewModel.summaryLabel)
                    .font(.title)
                    .bold()
                    .navigationTitle(viewModel.titleLabel)
                
                    .toolbar(content: {
                        if viewModel.isLoading {
                            ProgressView()
                        } else {
                            Button(viewModel.fetchButtonTitleLabel) {
                                viewModel.fetchTransactions()
                            }
                        }
                        
                        Menu(viewModel.filterMenuLabel) {
                            Menu(viewModel.categoryMenuLabel) {
                                ForEach(PBTransactionCategory.allCases, id: \.id) { category in
                                    Button(category.title, action: { viewModel.category = category })
                                }
                            }
                        }
                    })
            }
            .onChange(of: networkMonitor.isConnected) { showNetworkAlert = $0 == false}
            .alert(viewModel.networkOfflineLabel, isPresented: $showNetworkAlert) {
                Button(viewModel.alertAnswerLabel, action: {})
            }
            .alert(viewModel.errorLabel, isPresented: $viewModel.isError, actions: {
                Button(viewModel.alertAnswerLabel, action: {})
            }, message: {
                Text(viewModel.errorMessage)
            })
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        TransactionView()
//    }
//}
