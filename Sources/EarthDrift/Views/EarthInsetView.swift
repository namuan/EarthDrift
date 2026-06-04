import SwiftUI
import MapKit

struct EarthInsetView: NSViewRepresentable {
    let coordinate: CLLocationCoordinate2D

    private static let fullEarthDistance: CLLocationDistance = 20_000_000

    func makeNSView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.mapType = .satellite
        mapView.showsCompass = false
        mapView.showsScale = false
        mapView.pointOfInterestFilter = .excludingAll
        mapView.isRotateEnabled = false
        mapView.isScrollEnabled = false
        mapView.isZoomEnabled = false
        mapView.isPitchEnabled = false
        mapView.delegate = context.coordinator

        let camera = MKMapCamera(
            lookingAtCenter: CLLocationCoordinate2D(latitude: 0, longitude: 0),
            fromDistance: Self.fullEarthDistance,
            pitch: 0,
            heading: 0
        )
        mapView.camera = camera

        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        context.coordinator.annotation = annotation

        logDebug("EarthInsetView.makeNSView: coord=(\(String(format: "%.3f", coordinate.latitude)), \(String(format: "%.3f", coordinate.longitude)))")

        return mapView
    }

    func updateNSView(_ mapView: MKMapView, context: Context) {
        context.coordinator.annotation?.coordinate = coordinate
        let insetCamera = MKMapCamera(
            lookingAtCenter: coordinate,
            fromDistance: Self.fullEarthDistance,
            pitch: 0,
            heading: 0
        )
        mapView.camera = insetCamera
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    final class Coordinator: NSObject, MKMapViewDelegate {
        var annotation: MKPointAnnotation?

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard !(annotation is MKUserLocation) else { return nil }
            let identifier = "position"
            var view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            if view == nil {
                view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view?.wantsLayer = true
                view?.layer?.backgroundColor = NSColor.systemOrange.cgColor
                view?.layer?.borderColor = NSColor.white.cgColor
                view?.layer?.borderWidth = 1.5
                view?.layer?.cornerRadius = 3
                view?.frame = NSRect(x: 0, y: 0, width: 6, height: 6)
            }
            view?.annotation = annotation
            return view
        }
    }
}
