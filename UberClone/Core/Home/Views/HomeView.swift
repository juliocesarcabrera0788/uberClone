//
//  HomeView.swift
//  UberClone
//
//  Created by Julio Cabrera on 2024-07-04.
//

import SwiftUI

struct HomeView: View {
    
    @State private var mapState = MapViewState.noInput
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                
                UberMapViewRepresetable(mapState: $mapState)
                    .ignoresSafeArea()
                
                if mapState == .searchingForLocation {
                    LocationSearchView(mapState: $mapState )
                }else if mapState == .noInput{
                    LocationSearchActivationView()
                        .padding(.top, 72)
                        .onTapGesture {
                            withAnimation(.spring()){
                                mapState = .searchingForLocation
                            }
                        }
                }
                
                MapViewActionButton(mapState: $mapState)
                    .padding(.leading)
                    .padding(.top, 4)
            }
            
            if mapState == .locationSelected {
                RideRequestView()
                    .transition(.move(edge: .bottom))
            }
            
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    HomeView()
}
