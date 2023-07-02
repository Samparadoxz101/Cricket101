//
//  MatchDetailsVCVM.swift
//  Cricket101
//
//  Created by Shivam Vishwakarma on 02/07/23.
//

import Foundation
import UIKit


class MatchDetailsVCVM: NSObject{
    // MARK: - Initiate Api call
    func getAllMatchData(success: @escaping (_ withsuccess: [Welcome]) -> Void) {
        let helper = AllDetailsHelper()
        var allDetailsArray = [Welcome]()
        let group = DispatchGroup()
        group.enter()
        helper.getAllData(Url: "https://demo.sportz.io/nzin01312019187360.json"){success in
            print("success")
            allDetailsArray.append(success)
            group.leave()
        } failure: { errorMsg in
            print("fail")
            group.leave()
        }
        group.enter()
        helper.getAllData(Url: "https://demo.sportz.io/nzin01312019187360.json"){success in
            print("success")
            allDetailsArray.append(success)
            group.leave()
        } failure: { errorMsg in
            print("fail")
            group.leave()
        }
        group.notify(queue: .main) {
            success(allDetailsArray)
        }
    }
    // MARK: - Setup cell for tableview in MatchBannetViewController
    func setupCellMatchBannerViewController(tableCell: UITableViewCell, cellIndex: Int,indexNumber:Int, data: [Welcome]?) {
        if let cell = tableCell as? MatchHighlightsTableViewCell{
            cell.containerView.layer.cornerRadius = 10
            cell.leagueLabel.text = "Series:"
            cell.typeLabel.text = "Type:"
            cell.dateLabel.text = "Date:"
            cell.timeLabel.text = "Time:"
            cell.venueLabel.text = "Venue:"
            cell.matchNumberLabel.text = "Match Number:"
            cell.leagueValue.text = data?[indexNumber].matchdetail.series.tourName
            cell.typeValue.text = data?[indexNumber].matchdetail.match.type
            cell.dateValue.text = data?[indexNumber].matchdetail.match.date
            cell.timeValue.text = data?[indexNumber].matchdetail.match.time
            cell.venueValue.text = data?[indexNumber].matchdetail.venue.name
            cell.matchNumberValue.text = data?[indexNumber].matchdetail.match.number
        }
        
    }
    
    //MARK: - Setup cell for tableview in MatchBannetViewController
    func setupCellMatchInfoViewController(tableCell: UITableViewCell, cellIndex: Int,playersArr: [Player]) {
        if let cell = tableCell as? SquadsTableViewCell{
            let name = playersArr[cellIndex].nameFull
            var str = name
            
            let position = playersArr[cellIndex].position
            let order = position
            
            if let captian = playersArr[cellIndex].iscaptain {
                if captian {
                    str = str + " (c)"
                }
            }
            if let keeper = playersArr[cellIndex].iskeeper {
                if keeper {
                    str = str + " (wk)"
                }
            }
            cell.teamAPlayerName?.text = str
            cell.teamAPlayerStyle?.text = "Batting order:\(order)"
        }
    }
    
}
