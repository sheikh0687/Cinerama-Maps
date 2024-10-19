//
//  PaymentVC.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 28/08/24.
//

import UIKit

class PaymentVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_Pay(_ sender: UIButton) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "PresentPopUpVC") as! PresentPopUpVC
        vC.modalTransitionStyle = .crossDissolve
        vC.modalPresentationStyle = .overFullScreen
        self.present(vC, animated: true, completion: nil)
    }
}
