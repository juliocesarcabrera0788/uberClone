//
//  SettingsRowView.swift
//  UberClone
//
//  Created by Julio Cabrera on 2024-07-08.
//

import SwiftUI

struct SettingsRowView: View {
    
    let imageName:String
    let title:String
    let tintColor:Color
    
    var body: some View {
        HStack(spacing:12){
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(tintColor)
            
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
        }
    }
}

#Preview {
    SettingsRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
}
