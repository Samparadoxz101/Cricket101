//
//  PlayerInfoViewController.swift
//  Cricket101
//
//  Created by Shivam Vishwakarma on 02/07/23.
//

import UIKit

class PlayerInfoViewController: BaseVC {
    
    @IBOutlet weak var infoStackView: UIStackView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var battingLabel: UILabel!
    @IBOutlet weak var battingStyleLabel: UILabel!
    @IBOutlet weak var battingAvg: UILabel!
    @IBOutlet weak var bowlingLabel: UILabel!
    @IBOutlet weak var bowlingStyleLabel: UILabel!
    @IBOutlet weak var bowlingAvg: UILabel!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var transperentView: UIView!
    var playerData:Player?
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        tap.delegate = self
        self.transperentView.addGestureRecognizer(tap)
        prepareView()
        // Do any additional setup after loading the view.
    }
    func prepareView() {
        self.popUpView.layer.cornerRadius = 15
        self.popUpView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        setUpData()
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    func setUpData(){
        var str =  ""
        if let name = playerData?.nameFull{
            str = name
        }
        var order = ""
        if let position = playerData?.position{
            order = position
        }
        if let captian = playerData?.iscaptain {
            if captian {
                str = str + " (c)"
            }
        }
        if let keeper = playerData?.iskeeper {
            if keeper {
                str = str + " (wk)"
            }
        }
        self.nameLabel.text = "Name: \(str) | at: \(order)"
        self.battingLabel.text = "Batting Style: \(playerData?.batting.style.rawValue ?? "")"
        self.battingStyleLabel.text = "Strike rate: \(playerData?.batting.strikerate ?? "")"
        self.battingAvg.text = "Runs: \(playerData?.batting.runs ?? "") | Avg: \(playerData?.batting.average ?? "")"
        self.bowlingLabel.text = "Bowling"
        self.bowlingStyleLabel.text = "Economy: \(playerData?.bowling.economyrate ?? "")"
        self.bowlingAvg.text = "Wickets: \(playerData?.bowling.wickets ?? "") | Avg:\(playerData?.bowling.average ?? "")"
    }
}
