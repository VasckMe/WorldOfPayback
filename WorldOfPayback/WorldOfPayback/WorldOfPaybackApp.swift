//
//  WorldOfPaybackApp.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 27.02.24.
//

import SwiftUI

@main
struct WorldOfPaybackApp: App {
    var body: some Scene {
        WindowGroup {
            TransactionView(
                viewModel: TransactionViewModel(
                    networkService: MockNetworkService()
//                        executor: HTTPRequestExecutor(builder: HTTPRequestBuilder())
//                    )
                )
            )
        }
    }
}
