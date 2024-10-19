//
//  LoginVC.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 22/08/24.
//

import UIKit
import CountryPickerView

class LoginVC: UIViewController {
    
    @IBOutlet weak var txt_CountryPicker: UITextField!
    @IBOutlet weak var txt_MobileNum: UITextField!
    
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.configureCountryPicker(for: txt_CountryPicker)
        setupBindings()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btn_Login(_ sender: UIButton) {
        viewModel.mobileNum = txt_MobileNum.text ?? ""
        viewModel.requestToCallVerifyNum(vC: self)
    }
    
    private func setupBindings() {
        viewModel.showErrorMessage = { [weak self] in
            if let errorMessage = self?.viewModel.errorMessage {
                Utility.showAlertMessage(withTitle: k.appName, message: errorMessage, delegate: nil, parentViewController: self!)
            }
        }
        
        viewModel.loginSuccess = { [] in
            self.viewModel.navigateToOtpViewController(from: self.navigationController)
        }
    }
}

