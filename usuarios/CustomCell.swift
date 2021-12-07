//
//  CustomCell.swift
//  usuarios
//
//  Created by mac16 on 05/12/21.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var avatarimg: UIImageView!
    @IBOutlet weak var PrecioLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
