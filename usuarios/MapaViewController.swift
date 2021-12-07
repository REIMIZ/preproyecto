//
//  MapaViewController.swift
//  usuarios
//
//  Created by mac16 on 07/12/21.
//

import UIKit
import MapKit

class MapaViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var manager = CLLocationManager()
    var latitud2: CLLocationDegrees!
    var longitud2: CLLocationDegrees!

    @IBOutlet weak var Map: MKMapView!
    
    var recibedir: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
      //  manager.requestWhenInUseAuthorization()

        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
        Map.delegate = self
        
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let alerta = UIAlertController(title: "Ubicacion", message: "Tu pedido fue hecho con exito, entregas de 5 a 7 dias ", preferredStyle: .alert )
               let accionAceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
    
        alerta.addAction(accionAceptar)
        present(alerta, animated: true, completion: nil)
        
        trazarRuta()
        
    }
    
    
    @IBAction func RegresarBtn(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
        
    }
    

 
    //Trazado de la ruta
        func prepararTrazadoRuta(coordenadasDestino:CLLocationCoordinate2D)
        {
            if let LAT = latitud2, let LON = longitud2
            {
                let coordenadasOrigen = CLLocationCoordinate2DMake(LAT, LON)
                //Lugar Origen-Destino
                let origenPlaceMK = MKPlacemark(coordinate: coordenadasOrigen)
                let destinoPlaceMK = MKPlacemark(coordinate: coordenadasDestino)
                
                //Creación del objeto MapKitItem
                let origenItem = MKMapItem(placemark: origenPlaceMK)
                let destinoItem = MKMapItem(placemark: destinoPlaceMK)
                
                //Creación de la solicitud de ruta
                let solicitudDestino = MKDirections.Request()
                solicitudDestino.source = origenItem
                solicitudDestino.destination = destinoItem
                
                //Definimos el medio de transporte
                solicitudDestino.transportType = .automobile
                solicitudDestino.requestsAlternateRoutes = true
                
                let direcciones = MKDirections(request: solicitudDestino)
                direcciones.calculate { (respuesta, error) in
                    //Guardamos la respuesta en una variable segura
                    guard let respuestaSegura = respuesta else {
                        if let error = error
                        {
                            print("Error al calcular la ruta: \(error.localizedDescription)")
                        }
                        return
                    }
                    print(respuestaSegura.routes.count)
                    let ruta = respuestaSegura.routes[0]
                    
                    //Agregar superposición al mapa
                    self.Map.addOverlay(ruta.polyline)
                    self.Map.setVisibleMapRect(ruta.polyline.boundingMapRect, animated: true)
                }
            }
        }
        
        //Mostrar ruta encima del mapa
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
            render.strokeColor = .orange
            return render
        }
        
        //Métodos del CLLocationManager
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            
        }
        
        //Trazado de ruta mediante la dirección recibida
        func trazarRuta()
        {
            if let direccion = recibedir
            {
                let geocoder = CLGeocoder()
                
                //Limpiamos el mapa
                let overlays = Map.overlays
                let anotaciones = Map.annotations
                
              Map.removeOverlays(overlays)
               Map.removeAnnotations(anotaciones)
                
                geocoder.geocodeAddressString(direccion) { (places: [CLPlacemark]?, error:Error?) in
                    //Creamos el destino para nuestra ruta
                    
                    guard let ruta = places?.first?.location else { return }
                    
                    if error == nil
                    {
                        //Dirección a la que nos vamos a mover
                        let place = places?.first
                        print("Lugar: \(places!)")
                        
                        //Hacemos un zoom al lugar que buscamos
                        let anotacion = MKPointAnnotation()
                        anotacion.coordinate = (place?.location?.coordinate)!
                        
                        //Definimos un nombre a nuestra anotación
                        anotacion.title = ""
                        
                        let span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
                        let region = MKCoordinateRegion(center: anotacion.coordinate, span: span)
                        
                        self.Map.setRegion(region, animated: true)
                        self.Map.addAnnotation(anotacion)
                        self.Map.selectAnnotation(anotacion, animated: true)
                        
                        //Mandamos llamar la función creada para trazar la ruta
                        self.prepararTrazadoRuta(coordenadasDestino: ruta.coordinate)
                        self.Map.showsUserLocation = true
                        
                        
                    } else {
                        print("Ubicación no encontrada")
                    }
                }
                
            }
        }
    

  

}
