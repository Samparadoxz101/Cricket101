//
//  SingleLabelTableViewCell.swift
//  Cricket101
//
//  Created by Shivam Vishwakarma on 02/07/23.
//

import UIKit

class SingleLabelTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var TitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView.layer.cornerRadius = 10
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
