//
//  UberMapViewRepresetable.swift
//  UberClone
//
//  Created by Julio Cabrera on 2024-07-04.
//

import SwiftUI
import MapKit


struct UberMapViewRepresetable: UIViewRepresentable {
    
    
    let mapView = MKMapView()
    //let locationManager = LocationManager.shared
    
    @Binding var mapState: MapViewState
    @EnvironmentObject var locationViewModel:LocationSearchViewModel
    
    func makeUIView(context:Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
        switch mapState {
        case .noInput:
            context.coordinator.clearMapViewAndRecenterOnUserLocation()
            break
        case .searchingForLocation:
            break
        case .locationSelected:
            if let coordinate = locationViewModel.selectedUberLocation?.coordinate{
                context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate)
                context.coordinator.configurePolyLine(withDestinationCoordinate: coordinate)
            }
            break
        case .polyLineAdded:
            break
        }

        
    }
    
    
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
    
}


extension UberMapViewRepresetable {
    
    class MapCoordinator: NSObject, MKMapViewDelegate {
    
        //MARK: Properties
        
        let parent: UberMapViewRepresetable
        var userLocationCoordinate: CLLocationCoordinate2D?
        var currentRegion: MKCoordinateRegion?
        
        //MARK: Lifecycle
        
        init(parent: UberMapViewRepresetable) {
            self.parent = parent
            super.init()
        }
        
        //MARK: MKMapViewDelegate
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            self.userLocationCoordinate = userLocation.coordinate
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            
            self.currentRegion = region
            
            parent.mapView.setRegion(region, animated: true)
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let polyLine = MKPolylineRenderer(overlay: overlay)
            polyLine.strokeColor = .systemBlue
            polyLine.lineWidth = 6
            return polyLine
        }
        //MARK: Helpers
        
        func addAndSelectAnnotation(withCoordinate coordinate:CLLocationCoordinate2D){
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            
            let anno = MKPointAnnotation()
            anno.coordinate = coordinate
            
            parent.mapView.addAnnotation(anno)
            parent.mapView.selectAnnotation(anno, animated: true)
                        
        }
        
        func configurePolyLine(withDestinationCoordinate coordinate:CLLocationCoordinate2D){
            guard let userLocationCoordinate = self.userLocationCoordinate else {return}
            parent.locationViewModel.getDestinationRoute(from: userLocationCoordinate, to: coordinate) { route in
                self.parent.mapView.addOverlay(route.polyline)
                self.parent.mapState = .polyLineAdded
                let rect = self.parent.mapView.mapRectThatFits(route.polyline.boundingMapRect, edgePadding: .init(top: 64, left: 32, bottom: 500, right: 32))
                
                self.parent.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
        }
        
        func clearMapViewAndRecenterOnUserLocation(){
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            parent.mapView.removeOverlays(parent.mapView.overlays)
            
            if let currentRegion = currentRegion {
                parent.mapView.setRegion(currentRegion, animated: true)
            }
        }
    }
}
