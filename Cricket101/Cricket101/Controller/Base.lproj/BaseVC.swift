//
//  BaseVC.swift
//  Cricket101
//
//  Created by Shivam Vishwakarma on 01/07/23.
//

import UIKit
import AVKit
import AVFoundation

class BaseVC: UIViewController, UINavigationControllerDelegate, UIGestureRecognizerDelegate{//,
    var blurEffectView = UIView()
    var screenTitle = ""
    
    var navigationBackHandler: (() -> Void)?
    
    // MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    @objc func backAction() {
        if let dismissHandler = self.navigationBackHandler {
            dismissHandler()
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func hideBackgroundControl() {
        self.blurEffectView.isHidden = true
    }
    
    func showBackgroundControl() {
        self.blurEffectView.isHidden = false
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
        }, completion: { _ in
        })
    }
    
    // MARK: UINavigationController Delegate Methods
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
    }
    
    
}

extension BaseVC {
    func setCustomNavigationBar(vcTitle: String, navBarColor: UIColor?, backBtnColor: UIColor?) {
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "back.png")?.withRenderingMode(.alwaysTemplate), for: .normal)
        backBtn.tintColor = UIColor.white
        backBtn.addTarget(self, action: #selector(self.backAction), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        self.navigationItem.title = vcTitle
        if navBarColor != nil {
            self.navigationItem.titleView?.tintColor = .white
            self.navigationController?.navigationBar.backgroundColor = navBarColor
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
        } else {
            self.navigationItem.titleView?.tintColor = .white
            self.navigationController?.navigationBar.backgroundColor = .clear
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
        }
        
        if backBtnColor != nil {
            backBtn.tintColor = backBtnColor
        }
        
        
    }
}

