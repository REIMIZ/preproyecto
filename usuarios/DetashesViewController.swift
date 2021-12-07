//
//  DetashesViewController.swift
//  usuarios
//
//  Created by mac16 on 05/12/21.
//

import UIKit
import MapKit

class DetashesViewController: UIViewController, CLLocationManagerDelegate {
    

    
    @IBOutlet weak var praice: UILabel!
    @IBOutlet weak var DirTF: UITextField!
    @IBOutlet weak var names: UILabel!
    @IBOutlet weak var ProductosImg: UIImageView!
    
    var img = UIImage()
    var neim = ""
    var presio = ""
    var direccion: String?
    
    
    var manager = CLLocationManager()
    var latitud: CLLocationDegrees!
    var longitud: CLLocationDegrees!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ProductosImg.image = img
        names.text = neim
        praice.text = presio
        
        manager.delegate = self
        manager.requestWhenInUseAuthorization()

        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
        
    }
    

    @IBAction func regresoBtn(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    @IBAction func PedidoBtn(_ sender: UIButton) {
        direccion = DirTF.text
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "avanzar" {
            let objdestino = segue.destination as! MapaViewController
            objdestino.recibedir = direccion
            objdestino.latitud2 = latitud
            objdestino.longitud2 = longitud
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           if let location = locations.first{
               self.latitud = location.coordinate.latitude
               self.longitud = location.coordinate.longitude
           }
           
       }
    
    
}
