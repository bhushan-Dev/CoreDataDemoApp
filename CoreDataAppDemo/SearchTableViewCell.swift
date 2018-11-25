//
//  SearchTableViewCell.swift
//  CoreDataAppDemo
//
//  Created by Bhushan Udawant on 25/11/18.
//  Copyright © 2018 Bhushan Udawant. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    // MARK: IBOutlets

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
