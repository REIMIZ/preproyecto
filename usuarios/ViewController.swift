//
//  ViewController.swift
//  usuarios
//
//  Created by mac16 on 05/12/21.
//

import UIKit

class ViewController: UIViewController {
    
    

    @IBOutlet weak var productView: UITableView!
    
    let friends = ["chika", "hutao", "icon1", "inicial", "rem", "ren"]
    let precio = ["150", "200", "100", "120", "110", "140" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productView.delegate = self
        productView.dataSource = self
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = productView.dequeueReusableCell(withIdentifier: "customCell") as! CustomCell
        let friend = friends[indexPath.row]
        let price = precio[indexPath.row]
        celda.avatarimg.image = UIImage(named: friend)
        celda.nameLbl.text = friend
        celda.PrecioLbl.text = price
        
        return celda
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detallazos") as? DetashesViewController  {
            vc.img = UIImage(named: friends[indexPath.row])!
            vc.neim = friends[indexPath.row]
            vc.presio = precio[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalles" {
            let objEditarC = segue.destination as! DetashesViewController
            
        }
    }
    
    
}

