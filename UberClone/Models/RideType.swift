//
//  RideType.swift
//  UberClone
//
//  Created by Julio Cabrera on 2024-07-06.
//

import Foundation

enum RideType: Int, CaseIterable, Identifiable {
    
    case uberX
    case black
    case uberXL
    
    var id: Int { return rawValue }
    
    var descripcion: String {
        switch self {
        case .uberX : return "UberX"
        case .black : return "UberBlack"
        case .uberXL : return "UberXL"
        }
    }
    
    var imageName: String {
        switch self {
        case .uberX : return "Uber-X"
        case .black : return "Uber-black"
        case .uberXL : return "Uber-X"
        }
    }
}
