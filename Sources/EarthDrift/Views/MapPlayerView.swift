import SwiftUI
import MapKit

struct MapPlayerView: NSViewRepresentable {
    let camera: MKMapCamera
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
        mapView.camera = camera
        controller.mainMapView = mapView
        logDebug("MapPlayerView.makeNSView: registered mainMapView")
        return mapView
    }

    func updateNSView(_ mapView: MKMapView, context: Context) {
        logDebug("MapPlayerView.updateNSView: camera remote center=(\(String(format: "%.3f", camera.centerCoordinate.latitude)), \(String(format: "%.3f", camera.centerCoordinate.longitude)))")
        mapView.camera = camera
    }
}
