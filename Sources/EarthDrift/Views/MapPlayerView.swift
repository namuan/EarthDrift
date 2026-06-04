import SwiftUI
import MapKit

struct MapPlayerView: NSViewRepresentable {
    let controller: CameraController

    func makeNSView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.mapType = .satelliteFlyover
        mapView.showsCompass = false
        mapView.showsScale = false
        mapView.showsTraffic = false
        mapView.showsBuildings = false
        mapView.pointOfInterestFilter = .excludingAll
        mapView.isRotateEnabled = false
        mapView.isScrollEnabled = false
        mapView.isZoomEnabled = false
        mapView.isPitchEnabled = false
        mapView.camera = controller.camera
        return mapView
    }

    func updateNSView(_ mapView: MKMapView, context: Context) {
        mapView.camera = controller.camera
    }
}
