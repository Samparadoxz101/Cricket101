//
//  MatchBannerViewController.swift
//  Cricket101
//
//  Created by Shivam Vishwakarma on 30/06/23.
//

import UIKit
import Foundation

class MatchBannerViewController: BaseVC {
    
    @IBOutlet weak var background_View: UIView!
    @IBOutlet weak var matchBanner: UICollectionView!
    @IBOutlet weak var matchHighlightsTableView: UITableView!
    
    var presentController: UIViewController!
    var allDatatArray = [Welcome]()
    var match1 = true
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellSize = CGSize(width:self.matchBanner.frame.size.width , height: self.matchBanner.frame.size.height)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        layout.minimumLineSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        matchBanner.setCollectionViewLayout(layout, animated: true)
        self.matchHighlightsTableView.backgroundColor = .clear
        self.prepareView()
    }
    func prepareView(){
        print("i am alive")
        self.prepareCollectionView()
        self.prepareTableView()
        //self.performOperation()
    }
    func performOperation(){
//        let vm = MatchDetailsVCVM()
//         let helper = AllDetailsHelper()
//         vm.getAllMatchData(){success in
//             print("success")
//             self.allDatatArray = success
//         }
    }
    func prepareCollectionView(){
        self.matchBanner.backgroundColor = .clear
        self.matchBanner.delegate = self
        self.matchBanner.dataSource = self
        self.matchBanner.register(UINib(nibName: "MatchInfoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MatchInfoCollectionViewCell")
        self.matchBanner.reloadData()
        self.matchBanner.layoutIfNeeded()
    }
    
    func prepareTableView(){
        self.matchHighlightsTableView.backgroundColor = .clear
        self.matchHighlightsTableView.delegate = self
        self.matchHighlightsTableView.dataSource = self
        self.matchHighlightsTableView.register(UINib(nibName: "MatchHighlightsTableViewCell", bundle: nil), forCellReuseIdentifier: "MatchHighlightsTableViewCell")
        self.matchHighlightsTableView.register(UINib(nibName: "SingleLabelTableViewCell", bundle: nil), forCellReuseIdentifier: "SingleLabelTableViewCell")
        self.matchHighlightsTableView.reloadData()
    }
    
}
extension MatchBannerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MatchInfoCollectionViewCell", for: indexPath) as? MatchInfoCollectionViewCell else {
            return MatchInfoCollectionViewCell()
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "MatchBannerViewController", bundle: nil)
        let MatchInfoVC = storyboard.instantiateViewController(withIdentifier: "MatchInfoViewController") as! MatchInfoViewController
        if indexPath.row == 0 {
            MatchInfoVC.populateData(data: allDatatArray[0])
        } else {
            MatchInfoVC.populateData(data: allDatatArray[1])
        }
        self.navigationController?.pushViewController(MatchInfoVC, animated: true)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let collectionView = scrollView as? UICollectionView else {
            return
        }
        let visibleCells = collectionView.visibleCells
        if let firstVisibleCell = visibleCells.first as? MatchInfoCollectionViewCell {
            let indexPath = collectionView.indexPath(for: firstVisibleCell)
            if indexPath?.row == 0 {
                self.match1 = true
            } else {
                self.match1 = false
            }
            self.matchHighlightsTableView.reloadData()
        }
    }
}
extension MatchBannerViewController:UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: "SingleLabelTableViewCell") as? SingleLabelTableViewCell else {
            return SingleLabelTableViewCell()
        }
        cell.TitleLabel.text = "Match Info"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MatchHighlightsTableViewCell", for: indexPath) as? MatchHighlightsTableViewCell else {
            return MatchHighlightsTableViewCell()
        }
        let vm = MatchDetailsVCVM()
        if match1{
            vm.setupCellMatchBannerViewController(tableCell: cell, cellIndex: indexPath.section, indexNumber: 0, data: self.allDatatArray)
        }else {
            vm.setupCellMatchBannerViewController(tableCell: cell, cellIndex: indexPath.section, indexNumber: 1, data: self.allDatatArray)
        }
        return cell
    }
    
}
