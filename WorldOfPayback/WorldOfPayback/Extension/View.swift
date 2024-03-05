//
//  View.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 5.03.24.
//

import SwiftUI

extension View {
    func alertWithError(isPresented: Binding<Bool>, message: String, action: String) -> some View {
        alert("Error".localized(), isPresented: isPresented) {
            Button(action, action: {})
        } message: {
            Text(message)
        }
    }
}
