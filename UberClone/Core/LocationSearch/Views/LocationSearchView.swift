//
//  LocationSearchView.swift
//  UberClone
//
//  Created by Julio Cabrera on 2024-07-05.
//

import SwiftUI

struct LocationSearchView: View {
    
    @State private var startLocationText = ""
    @Binding var showLocationSerchView: Bool
    @EnvironmentObject var viewModel: LocationSearchViewModel
    
    var body: some View {
        VStack{
            //header
            HStack{
                VStack{
                    Circle()
                        .fill(Color(.systemGray))
                        .frame(width: 6, height: 6)
                    
                    Rectangle()
                        .fill(Color(.systemGray))
                        .frame(width: 1, height: 24)
                    
                    Rectangle()
                        .fill(.black)
                        .frame(width: 6, height: 6)
                }
                
                VStack{
                    TextField("Current location", text: $startLocationText)
                        .frame(height: 32)
                        .background(
                            Color(.systemGroupedBackground)
                        )
                        .padding(.trailing)
                    
                    TextField("Where to?", text: $viewModel.queryFragment)
                        .frame(height: 32)
                        .background(
                            Color(.systemGray4)
                        )
                        .padding(.trailing)
                }
            }
            .padding(.horizontal)
            .padding(.top, 64)
            
            Divider()
                .padding(.vertical)
            
            
            //list
            ScrollView{
                VStack(alignment: .leading){
                    ForEach(viewModel.result, id: \.self){ result in
                        LocationSearchResultCell(title: result.title, subTitle: result.subtitle)
                            .onTapGesture {
                                
                                viewModel.selectLocation(result)
                                
                                showLocationSerchView.toggle()
                                
                            }
                    }
                }
            }
            
        }
        .background(.white)
    }
}

#Preview {
    LocationSearchView(showLocationSerchView: .constant(false))
}
