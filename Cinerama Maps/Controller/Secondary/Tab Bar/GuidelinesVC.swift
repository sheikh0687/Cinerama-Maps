//
//  GuidelinesVC.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 28/08/24.
//

import UIKit

class GuidelinesVC: UIViewController {
  
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var lbl_Date: UILabel!
    @IBOutlet weak var lbl_Description: UILabel!
    
    var arrayGuidelineTip: [Res_GuidelineTips] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGuideTips()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setGuideTips() {
        for val in arrayGuidelineTip {
            self.lbl_Title.text = val.title ?? ""
            self.lbl_Date.text = "The writting date is \(val.date_time ?? "")"
            let html = val.description
            if let attributedText = html?.htmlAttributedString3 {
                self.lbl_Description.attributedText = attributedText
            }
        }
    }
}
