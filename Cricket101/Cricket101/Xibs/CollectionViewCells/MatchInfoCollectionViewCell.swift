//
//  MatchInfoCollectionViewCell.swift
//  Cricket101
//
//  Created by Shivam Vishwakarma on 01/07/23.
//

import UIKit

class MatchInfoCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var cellBackgroundView: UIView!
    
    @IBOutlet weak var currentMatchImageView: UIImageView!
    
    @IBOutlet weak var team1Flag: UIImageView!
    
    @IBOutlet weak var team1Name: UILabel!
    
    @IBOutlet weak var team2Flag: UIImageView!
    
    @IBOutlet weak var team2Name: UILabel!
    
    @IBOutlet weak var containerStackView: UIStackView!
    
    @IBOutlet weak var currentScoreLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.currentMatchImageView.layer.cornerRadius = 10
        self.cellBackgroundView.layer.cornerRadius = 10
        // Initialization code
    }

}
