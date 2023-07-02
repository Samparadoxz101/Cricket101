//
//  SquadsTableViewCell.swift
//  Cricket101
//
//  Created by Shivam Vishwakarma on 02/07/23.
//

import UIKit

class SquadsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var teamAView: UIView!
    @IBOutlet weak var teamAPlayerName: UILabel!
    @IBOutlet weak var teamAplayerPicture: UIImageView!
    @IBOutlet weak var teamAPlayerStyle: UILabel!
    
    
    @IBOutlet weak var teamBView: UIView!
    @IBOutlet weak var teamBPlayerName: UILabel!
    @IBOutlet weak var teamBlayerPicture: UIImageView!
    @IBOutlet weak var teamBPlayerStyle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.teamAView.layer.cornerRadius = 10
        // Initialization code
    }    
}
