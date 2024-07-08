//
//  InitialView.swift
//  UberClone
//
//  Created by Julio Cabrera on 2024-07-08.
//

import SwiftUI



struct InitialView: View {
    @EnvironmentObject var authViewModel:AuthViewModel
    
    var body: some View {
        if authViewModel.userSession != nil {
            ProfileView()
        } else {
            LoginView()
        }
    }
}

#Preview {
    InitialView()
}
