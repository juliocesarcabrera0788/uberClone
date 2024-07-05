//
//  LocationSearchViewModel.swift
//  UberClone
//
//  Created by Julio Cabrera on 2024-07-05.
//

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject {
    
    //MARK: - Properties
    
    @Published var result = [MKLocalSearchCompletion] ()
    private let searchCompleter = MKLocalSearchCompleter()
    var queryFragment:String = "" {
        didSet {
            searchCompleter.queryFragment = queryFragment
        }
    }
    
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
    
}


// MARK: - MKLocalSearchCompleterDelegate

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.result = completer.results
    }
}
