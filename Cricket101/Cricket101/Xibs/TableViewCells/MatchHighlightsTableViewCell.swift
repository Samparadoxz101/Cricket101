//
//  MatchHighlightsTableViewCell.swift
//  Cricket101
//
//  Created by Shivam Vishwakarma on 01/07/23.
//

import UIKit

class MatchHighlightsTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var leagueLabel: UILabel!
    @IBOutlet weak var leagueValue: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var typeValue: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateValue: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeValue: UILabel!
    @IBOutlet weak var matchNumberLabel: UILabel!
    @IBOutlet weak var matchNumberValue: UILabel!
    @IBOutlet weak var venueLabel: UILabel!
    @IBOutlet weak var venueValue: UILabel!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    
    
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
