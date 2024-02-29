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
                Text("TransactionView_Text_summary".localized() + " " + String(viewModel.summaryValue))
                    .font(.title)
                    .bold()
                .navigationTitle("TransactionView_title".localized())
                .toolbar(content: {
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        Button("TransactionView_Button_fetch_title".localized()) {
                            viewModel.fetchTransactions()
                        }
                    }
                    
                    Menu("TransactionView_Menu_filter_title".localized()) {
                        Menu("TransactionView_Menu_category_title".localized()) {
                            ForEach(PBTransactionCategory.allCases, id: \.id) { category in
                                Button("\(category.title)", action: { viewModel.category = category })
                            }
                        }
                    }
                })
            }
            .onChange(of: networkMonitor.isConnected) { showNetworkAlert = $0 == false}
            .alert("NetworkError_offline_description".localized(), isPresented: $showNetworkAlert) {
                Button("TransactionView_Alert_answer".localized(), action: {})
            }
            .alert("Error".localized(), isPresented: $viewModel.isError, actions: {
                Button("TransactionView_Alert_answer".localized(), action: {})
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
