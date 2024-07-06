//
//  RideRequestView.swift
//  UberClone
//
//  Created by Julio Cabrera on 2024-07-06.
//

import SwiftUI

struct RideRequestView: View {
    var body: some View {
        VStack{
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48, height: 6)
            
            //trip info view
            HStack{
                VStack{
                    Circle()
                        .fill(Color(.systemGray))
                        .frame(width: 8, height: 8)
                    
                    Rectangle()
                        .fill(Color(.systemGray))
                        .frame(width: 1, height: 32)
                    
                    Rectangle()
                        .fill(.black)
                        .frame(width: 8, height: 8)
                }
                
                VStack(alignment: .leading, spacing: 24){
                    HStack{
                        Text("Current location")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.gray)
                        
                        Spacer()
                        
                        Text("1:30 PM")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray)
                        
                    }
                    .padding(.bottom, 10)
                    
                    HStack{
                        Text("Starbucks Coffe")
                            .font(.system(size: 16, weight: .semibold))
                            
                        
                        Spacer()
                        
                        Text("1:45 PM")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray)
                        
                    }
                }
                .padding(.leading, 8)
            }
            .padding()
            
            Divider()
            
            //ride type selection view
            Text("SUGGESTED RIDES")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding()
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal){
                HStack(spacing: 12){
                    ForEach(0 ..< 3, id: \.self){ _ in
                        VStack(alignment: .leading){
                            Image("Uber-X")
                                .resizable()
                                .scaledToFit()
                            
                            VStack(spacing: 4) {
                                Text("Uber-X")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.gray)
                                
                                Text("$22.04")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.gray)
                            }
                            .padding(8)
                            
                            
                        }
                        .frame(width: 112, height: 140)
                        .background(Color(.systemGroupedBackground))
                        .cornerRadius(10)
                    }
                }
            }
            .padding(.horizontal)
            
            Divider()
                .padding(.vertical, 8)
            //payment option view
            
            HStack(spacing:12){
                Text("Visa")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(6)
                    .background(.blue)
                    .cornerRadius(4)
                    .foregroundColor(.white)
                    .padding(.leading)
                
                Text("**** 1234")
                    .fontWeight(.bold)
                    
                Spacer()
                
                Image(systemName: "chevron.right")
                    .imageScale(.medium)
                    .padding()
            }
            .frame(height:50)
            .background(Color(.systemGroupedBackground))
            .cornerRadius(10)
            .padding(.horizontal)
            
            //request ride button
            Button{
                
            }label: {
                Text("CONFIRM RIDE")
                    .fontWeight(.bold)
                    .frame(width:UIScreen.main.bounds.width - 32, height: 50)
                    .background(.blue)
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }
        }
        .background(.white)
    }
}

#Preview {
    RideRequestView()
}