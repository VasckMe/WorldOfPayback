//
//  WorldOfPaybackApp.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 27.02.24.
//

import SwiftUI

@main
struct WorldOfPaybackApp: App {
    
    @StateObject var networkMonitor = NetworkMonitor()
    
    var body: some Scene {
        WindowGroup {
            TransactionView(
                viewModel: TransactionViewModel(
                    networkService: ServiceAssembly.shared.mockNetworkService
                )
            )
            .environmentObject(networkMonitor)
        }
    }
}
