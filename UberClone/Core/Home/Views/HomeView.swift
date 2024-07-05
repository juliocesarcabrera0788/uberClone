//
//  HomeView.swift
//  UberClone
//
//  Created by Julio Cabrera on 2024-07-04.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showLocationSearchView = false
    
    var body: some View {
        ZStack(alignment: .top) {
            
            UberMapViewRepresetable()
                .ignoresSafeArea()
            
            if showLocationSearchView {
                LocationSearchView()
            }else{
                LocationSearchActivationView()
                    .padding(.top, 72)
                    .onTapGesture {
                        withAnimation(.spring()){
                            showLocationSearchView.toggle()
                        }
                    }
            }
            
            MapViewActionButton(showLocationSearchView: $showLocationSearchView)
                .padding(.leading)
                .padding(.top, 4)
        }
    }
}

#Preview {
    HomeView()
}
