//
//  UberCloneApp.swift
//  UberClone
//
//  Created by Julio Cabrera on 2024-07-04.
//

import SwiftUI
import Firebase


@main
struct UberCloneApp: App {
    
    @StateObject var locationViewModel = LocationSearchViewModel()
    @StateObject var authViewModel = AuthViewModel()
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            InitialView()
                .environmentObject(locationViewModel)
                .environmentObject(authViewModel)
        }
    }
}
