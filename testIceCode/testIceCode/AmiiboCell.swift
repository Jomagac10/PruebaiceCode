//
//  AmiiboCell.swift
//  testIceCode
//
//  Created by Jose Manuel García Chávez on 5/31/19.
//  Copyright © 2019 Unam. All rights reserved.
//

import Foundation
import UIKit

class AmiiboCell: UITableViewCell {
    
    //MARK: Custom table view cell
    
    @IBOutlet weak var _Image : UIImageView!
    @IBOutlet weak var _Name : UILabel!
    @IBOutlet weak var _Series : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor(red: 37/255, green: 161/255, blue: 142/255, alpha: 1)
        _Name.textColor = UIColor(red: 151/255, green: 252/255, blue: 223/255, alpha: 1)
        _Series.textColor = UIColor(red: 151/255, green: 252/255, blue: 223/255, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
