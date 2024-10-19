//
//  SettingVC.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 23/08/24.
//

import UIKit

class SettingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_EditProfile(_ sender: UIButton) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func btn_TermsCondition(_ sender: UIButton) {
        
    }
    
    @IBAction func btn_PrivacyPolicy(_ sender: UIButton) {

    }
    
    @IBAction func btn_Subscription(_ sender: UIButton) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "SubscriptionVC") as! SubscriptionVC
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func btn_ChangeLanguage(_ sender: UIButton) {

    }
    
    @IBAction func btn_Application(_ sender: UIButton) {

    }
    
    @IBAction func btn_ContactUs(_ sender: UIButton) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "ContactUsVC") as! ContactUsVC
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func btn_DeleteAccnt(_ sender: UIButton) {
       
    }
    
    @IBAction func btn_Logout(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: k.session.status)
        UserDefaults.standard.synchronize()
        Switcher.updateRootVC()
    }
}
