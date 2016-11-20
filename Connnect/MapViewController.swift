import UIKit
import MapKit

struct MapViewState {
    static var hasBeenZoomed = false
}

public struct MapRegionIdentifiers {
    public static let work = "WorkRegion"
}

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet public weak var mapView: MKMapView!
    
    var regionRadius: Double = 500
    
    var locationManager = AppDelegate.shared.locationManager
    
    var workLocations: [CLCircularRegion]? {
        return locationManager.monitoredRegions.flatMap { $0 as? CLCircularRegion }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        MapViewState.hasBeenZoomed = false
        locationManager.delegate = AppDelegate.shared
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        mapView.delegate = self
        drawWorkLocations(workLocations: workLocations)
    }
    

    @IBAction func handleLongPress(sender: UILongPressGestureRecognizer) {
        let location = sender.location(in: mapView)
        //make coordinated from where the user pressed
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        
        if sender.state == .began {
            addOverLayAtCoordinate(coord: coordinate)
        } else if sender.state == .ended {
            let myRegion = CLCircularRegion(center: coordinate, radius: regionRadius, identifier: "regionIdentifier")
        
            locationManager.startMonitoring(for: myRegion)
            
        }
    }
    
    func addOverLayAtCoordinate(coord: CLLocationCoordinate2D) {
        //remove existing overlays
        let existingOverlays = mapView.overlays
        mapView.removeOverlays(existingOverlays)
        //add a circle over lay where the user pressed
        let circle = MKCircle(center: coord, radius: regionRadius)
        mapView.add(circle)
    }
    
    func drawWorkLocations( workLocations: [CLCircularRegion]?) {
        //draw the current work locations if it is not nil
        workLocations?.map { location in
            return MKCircle(center: location.center, radius: self.regionRadius)
            }.forEach(mapView.add)
    }
    
    
    
    
    public func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        //only do this map zooming thing once
        if MapViewState.hasBeenZoomed == false {
            MapViewState.hasBeenZoomed = true
            if let userCoordinates = userLocation.location?.coordinate {
                //stoping location updates
                //                locationManager.manager.stopUpdatingLocation()
                locationManager.stopUpdatingLocation()
                
                if mapView.overlays.count > 0 {
                    
                    //zoom the map so it shows the user and the overlays
                    if let overlay = mapView.overlays.first as? MKCircle {
                        let mapRect = mapRectToFitCoordinate(one: userCoordinates,
                                                             andCoordinate: overlay.coordinate)
                        let insets = UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40)
                        mapView.setVisibleMapRect(mapRect,
                                                  edgePadding: insets, animated: true)
                    }
                    
                } else {
                    //zoom the map to the users location
                    //not sure how far away from work the person is, so give them a good zoom 2km
                    let region = MKCoordinateRegionMakeWithDistance(userCoordinates, 2000, 2000)
                    mapView.setRegion(region, animated: true)
                }
            }
        }
    }
    
    public func mapView(_ mapView: MKMapView,
                        rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        return (overlay as? MKCircle)?.defaultRenderer ?? MKCircle.clearRenderer(center: overlay.coordinate)
    }
    
    public func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        addOverLayAtCoordinate(coord: view.annotation!.coordinate)
        
        
        
        let myRegion = CLCircularRegion(center: view.annotation!.coordinate, radius: regionRadius, identifier: "regionIdentifier")
        locationManager.startMonitoring(for: myRegion)
        
    }
    
    func mapRectToFitCoordinate(one: CLLocationCoordinate2D,
                                andCoordinate two: CLLocationCoordinate2D) -> MKMapRect {
        let a = MKMapPointForCoordinate(one)
        let b = MKMapPointForCoordinate(two)
        return MKMapRectMake(min(a.x, b.x), min(a.y, b.y), abs(a.x - b.x), abs(a.y-b.y))
    }
    
    
}

//extension MapViewController: MKMapViewDelegate {
//    
//
//    
//}

extension MKCircle {
    var defaultRenderer: MKCircleRenderer {
        let renderer = MKCircleRenderer(circle: self)
        renderer.fillColor = AppColors.Cayenne
        renderer.strokeColor = AppColors.Cayenne
        renderer.lineWidth = 5
        renderer.alpha = 0.75
        return renderer
    }
    static func clearRenderer(center: CLLocationCoordinate2D) -> MKCircleRenderer {
        let renderer = MKCircleRenderer(circle: MKCircle(center: center, radius: 100))
        renderer.alpha = 0.0
        return renderer
    }
}


