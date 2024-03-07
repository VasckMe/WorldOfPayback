//
//  TransactionView.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 27.02.24.
//

import SwiftUI

struct TransactionView: View {
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @StateObject var viewModel: TransactionViewModel
    @State var showNetworkAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.transactionsToShow) { TransactionCellView(transaction: $0) }
                Text(viewModel.summaryLabel)
                    .font(.title)
                    .bold()
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if !networkMonitor.isConnected {
                        Text(viewModel.offlineLabel)
                            .bold()
                            .foregroundColor(.red)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        Button(viewModel.fetchButtonTitleLabel) {
                            viewModel.fetchTransactions()
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu(viewModel.filterMenuLabel) {
                        Menu(viewModel.categoryMenuLabel) {
                            ForEach(PBTransactionCategory.allCases, id: \.id) { category in
                                Button(category.title, action: { viewModel.category = category })
                            }
                        }
                    }
                }
            }
            
            .alertWithError(
                isPresented: $viewModel.isError,
                message: viewModel.errorMessage,
                action: viewModel.alertAnswerLabel
            )
            .navigationTitle(viewModel.titleLabel)
        }
        .onAppear {
            viewModel.fetchTransactions()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView(
            viewModel: TransactionViewModel(
                networkService: ServiceAssembly.shared.mockNetworkService,
                persistenceStorageService: ServiceAssembly.shared.persistenceService,
                dataProvider: DataProvider.shared.transactionViewDataProvider
            )
        )
        .environmentObject(NetworkMonitor())
    }
}
