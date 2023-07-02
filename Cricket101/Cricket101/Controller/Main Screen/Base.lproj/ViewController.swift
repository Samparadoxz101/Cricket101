//
//  ViewController.swift
//  Cricket101
//
//  Created by Shivam Vishwakarma on 01/07/23.
//

import UIKit
import AVFoundation

class StartViewController: BaseVC {
    @IBOutlet weak var splashImage: UIImageView!
    var allDatatArray = [Welcome]()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let cricket101 = UIImage.gifImageWithName("LaunchGif")
        self.splashImage.image = cricket101
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        self.startAnimation()
    }
    
    // MARK: - Animation Delay
    func startAnimation()
    {
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.performOperation(sender:)), userInfo: nil, repeats: false)
    }
    // MARK: - Api calling
    @objc func performOperation(sender : Timer){
        let vm = MatchDetailsVCVM()
        vm.getAllMatchData(){success in
            print("success")
            self.allDatatArray = success
            self.splashTimeOut()
        }
    }
    func splashTimeOut()
    {
        let storyboard = UIStoryboard(name: "MatchBannerViewController", bundle: nil)
        let MatchBannerVC = storyboard.instantiateViewController(withIdentifier: "MatchBannerViewController") as! MatchBannerViewController
        MatchBannerVC.allDatatArray = allDatatArray
        self.navigationController?.pushViewController(MatchBannerVC, animated: true)
    }
}


