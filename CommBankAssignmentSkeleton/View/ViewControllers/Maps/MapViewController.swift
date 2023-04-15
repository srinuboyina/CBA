//
//  MapViewController.swift
//  CommBankAssignmentSkeleton
//
//  Created by apple on 14/04/23.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    var atm:ATM!
    let mapView: MKMapView = MKMapView(frame: .zero)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        self.view.backgroundColor = .white
        self.title = "ATM Location"
        self.accessibilityLabel = "Map View"
        addAnnotation(atm: atm)
    }
    
    private func setupMapView() {
        view.addSubview(mapView)
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([ mapView.topAnchor.constraint(equalTo: view.topAnchor, constant:topbarHeight + 20)])
        mapView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        mapView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
    }
    
    func addAnnotation(atm: ATM){
        let annotation = MKPointAnnotation()
        annotation.title = atm.name + " " + atm.address
        annotation.coordinate = CLLocationCoordinate2D(latitude: atm.location.lat, longitude: atm.location.lng)
        let coordinateRegion = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 800, longitudinalMeters: 800)
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.addAnnotation(annotation)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
            annotationView?.image = UIImage(named: "CBAFindUsAnnotationIconATM")
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
}
