//
//  MapViewActionButton.swift
//  UberClone
//
//  Created by Julio Cabrera on 2024-07-05.
//

import SwiftUI

struct MapViewActionButton: View {
    
    @Binding var showLocationSearchView: Bool

    
    
    var body: some View {
        Button {
            withAnimation(.spring()){
                showLocationSearchView.toggle()
            }
        } label: {
            Image(systemName: showLocationSearchView ? "arrow.left" : "line.3.horizontal")
                .font(.title2)
                .foregroundColor(.black)
                .padding()
                .background(.white)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 6)
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
    }
}

#Preview {
    MapViewActionButton(showLocationSearchView: .constant(true))
}
