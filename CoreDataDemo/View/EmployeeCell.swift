//
//  EmployeeCell.swift
//  CoreDataDemo
//
//  Created by Shridevi Sawant on 28/04/22.
//

import UIKit

class EmployeeCell: UITableViewCell {

    @IBOutlet weak var nameL: UILabel!
    
    @IBOutlet weak var idL: UILabel!
    @IBOutlet weak var salaryL: UILabel!
    @IBOutlet weak var cityL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
