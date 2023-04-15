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
    @IBOutlet weak var map: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Map"
        map.delegate = self
        addAnnotation(atm: atm)
    }
    
    func addAnnotation(atm: ATM){
        let annotation = MKPointAnnotation()
        annotation.title = atm.name + " " + atm.address
        annotation.coordinate = CLLocationCoordinate2D(latitude: atm.location.lat, longitude: atm.location.lng)
        let coordinateRegion = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 800, longitudinalMeters: 800)
        map.setRegion(coordinateRegion, animated: true)
        map.addAnnotation(annotation)
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
