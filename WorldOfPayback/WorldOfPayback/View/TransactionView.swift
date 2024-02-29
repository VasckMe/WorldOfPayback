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
                .navigationTitle("TransactionView_title".localized())
                .toolbar(content: {
                    HStack(alignment: .center) {
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
//import Foundation
//import UIKit
//extension String {
//    var localized: String {
//        return NSLocalizedString(
//            self,
//            tableName: "Localizable",
//            bundle: .main,
//            value: self,
//            comment: self
//        )
//    }
//}
