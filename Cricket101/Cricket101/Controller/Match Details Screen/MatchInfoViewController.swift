//
//  MatchInfoViewController.swift
//  Cricket101
//
//  Created by Shivam Vishwakarma on 01/07/23.
//

import UIKit

class MatchInfoViewController: BaseVC {
    
    @IBOutlet weak var scrollPager: ScrollPager!
    @IBOutlet weak var informationTableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    var arrayTeamData = [Team]()
    var playersArr = [Player]()
    var teamA = true
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
    }
    func prepareView(){
        self.prepareTableView()
        self.backButton.setImage(UIImage(named: "Back")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.backButton.tintColor = UIColor.white
        self.performOperation()
        self.prepareTableView()
        self.setScrollPager()
    }
    func prepareTableView(){
        self.informationTableView.backgroundColor = .clear
        self.informationTableView.delegate = self
        self.informationTableView.dataSource = self
        self.informationTableView.register(UINib(nibName: "SquadsTableViewCell", bundle: nil), forCellReuseIdentifier: "SquadsTableViewCell")
        self.informationTableView.reloadData()
    }
    func setScrollPager() {
        self.scrollPager.indicatorColor = UIColor.white
        self.scrollPager.selectedTextColor = UIColor.white
        self.scrollPager.textColor = UIColor.white
        self.scrollPager.backgroundColor = .clear
        self.scrollPager.objScrollPagerDelegate = self
        self.scrollPager.isFixTabs = true
        self.scrollPager.BTNBackgroundColor = .clear
        self.scrollPager.selectedBTNBackgroundColor = .clear
        self.scrollPager.fontiPhone = UIFont.boldSystemFont(ofSize: 14)
        self.scrollPager.fontIpad = UIFont.boldSystemFont(ofSize: 22)
        self.scrollPager.selectedFontIphone = UIFont.boldSystemFont(ofSize: 14)
        self.scrollPager.selectedFontIpad = UIFont.boldSystemFont(ofSize: 22)
        self.scrollPager.numberOfTabs = self.arrayTeamData.count
        self.scrollPager.addSegmentsWithTitles(segmentTitles: ["\(arrayTeamData[0].nameFull)","\(arrayTeamData[1].nameFull)"])
    }
    func populateData(data:Welcome){
        let teamsArray = data.teams
        if(teamsArray.count > 0){
            for teamData in teamsArray.enumerated() {
                self.arrayTeamData.append(teamData.element.value)
            }
        }
        
    }
    func performOperation(){
        let playersList = arrayTeamData[0].players
        for i in playersList {
            let a = i.value
            playersArr.append(a)
        }
        self.playersArr = self.playersArr.sorted {
            Int($0.position) ?? 0 < Int($1.position) ?? 0
        }
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated:true)
    }
    
}
extension MatchInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playersArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SquadsTableViewCell", for: indexPath) as? SquadsTableViewCell else {
            return SquadsTableViewCell()
        }
        let vm = MatchDetailsVCVM()
        vm.setupCellMatchInfoViewController(tableCell: cell, cellIndex: indexPath.row, playersArr: self.playersArr)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "MatchBannerViewController", bundle: nil)
        let playerInfoVC = storyboard.instantiateViewController(withIdentifier: "PlayerInfoViewController") as! PlayerInfoViewController
        playerInfoVC.playerData = playersArr[indexPath.row]
        playerInfoVC.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(playerInfoVC, animated: true)
    }
}
extension MatchInfoViewController:ScrollPagerDelegate{
    func ScrollPager(scrollPager: ScrollPager, changedIndex: Int) {
        if changedIndex == 0 {
            playersArr.removeAll()
            let playersList = arrayTeamData[0].players
            for i in playersList {
                let a = i.value
                playersArr.append(a)
            }
        } else {
            playersArr.removeAll()
            let playersList = arrayTeamData[1].players
            for i in playersList {
                let a = i.value
                playersArr.append(a)
            }
        }
        self.playersArr = self.playersArr.sorted {
            Int($0.position) ?? 0 < Int($1.position) ?? 0
        }
        self.informationTableView.reloadData()
    }
}
