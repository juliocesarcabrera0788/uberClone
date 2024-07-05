//
//  MapViewActionButton.swift
//  UberClone
//
//  Created by Julio Cabrera on 2024-07-05.
//

import SwiftUI

struct MapViewActionButton: View {
    
    @Binding var mapState: MapViewState

    
    
    var body: some View {
        Button {
            withAnimation(.spring()){
               actionForState(mapState)
            }
        } label: {
            Image(systemName: imageNameForState(mapState))
                .font(.title2)
                .foregroundColor(.black)
                .padding()
                .background(.white)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 6)
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
    }
    
    func imageNameForState(_ state:MapViewState)-> String{
        switch state {
        case .noInput:
            return "line.3.horizontal"
        case .searchingForLocation, .locationSelected:
            return "arrow.left"
        }
    }
    
    func actionForState(_ state:MapViewState){
        switch state {
        case .noInput:
            print("No Input")
        case .searchingForLocation:
            mapState = .noInput
        case .locationSelected:
            mapState = .noInput
        }
    }
}

#Preview {
    MapViewActionButton(mapState: .constant(.noInput))
}
