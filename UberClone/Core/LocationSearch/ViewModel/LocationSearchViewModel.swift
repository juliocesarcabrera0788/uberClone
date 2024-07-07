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
    @Published var selectedUberLocation: UberLocation?
    @Published var pickupTime: String?
    @Published var dropOffTime: String?
    
    private let searchCompleter = MKLocalSearchCompleter()
    var queryFragment:String = "" {
        didSet {
            searchCompleter.queryFragment = queryFragment
        }
    }
    
    var userLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
    
    //MARK: - Helpers
    func selectLocation(_ localSearch:MKLocalSearchCompletion){
        locationSeach(forLocalSearchCompletion: localSearch) { response, error in
           
            if let error = error {
                print("DEBUG: Location search failed with error \(error.localizedDescription)")
                return
            }
            guard let item = response?.mapItems.first else {return}
            let coordinate = item.placemark.coordinate
            self.selectedUberLocation = UberLocation(title: localSearch.title, coordinate: coordinate)
            
        }
    }
    
    func locationSeach(forLocalSearchCompletion localSearch: MKLocalSearchCompletion,
                       complition: @escaping MKLocalSearch.CompletionHandler){
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        
        let search = MKLocalSearch(request: searchRequest)
        
        search.start(completionHandler: complition)
    }
    
    func computeRidePrice(forType type: RideType) -> Double {
        guard let destCoordinate = selectedUberLocation?.coordinate else {return 0.0}
        guard let userCoordinate = self.userLocation else {return 0.0}
        
        let userLocation = CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
        let destination = CLLocation(latitude: destCoordinate.latitude, longitude: destCoordinate.longitude)
        
        let tripDistanceInMeters = userLocation.distance(from: destination)
        return type.computerPrice(for: tripDistanceInMeters)
    }
    
    func getDestinationRoute(from userLocation:CLLocationCoordinate2D, to destination:CLLocationCoordinate2D, complition: @escaping(MKRoute) -> Void){
        
        let userPlacemark = MKPlacemark(coordinate: userLocation)
        let destPlacemark = MKPlacemark(coordinate: destination)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: userPlacemark)
        request.destination = MKMapItem(placemark: destPlacemark)
        let directions = MKDirections(request: request)
        
        directions.calculate { response, error in
            if let error = error {
                print("Faild to get directions with error \(error.localizedDescription)")
                return
            }
            
            guard let route = response?.routes.first else {return}
            self.configurePickupAndDropOffTime(with: route.expectedTravelTime)
            complition(route)
        }
    }
    
    func configurePickupAndDropOffTime(with expectedTravelTime: Double){
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        pickupTime = formatter.string(from: Date())
        dropOffTime = formatter.string(from: Date() + expectedTravelTime)
    }
}


// MARK: - MKLocalSearchCompleterDelegate

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.result = completer.results
    }
}
