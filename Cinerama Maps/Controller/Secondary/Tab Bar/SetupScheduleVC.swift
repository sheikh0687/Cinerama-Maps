//
//  SetupScheduleVC.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 23/08/24.
//

import UIKit

class SetupScheduleVC: UIViewController {
    
    @IBOutlet weak var txt_MapName: UITextField!
    @IBOutlet weak var btn_DropOt: UIButton!
    @IBOutlet weak var txt_HowManyDays: UITextField!
    @IBOutlet weak var txt_Address: UITextView!
    @IBOutlet weak var btn_ByCNRMOt: UIButton!
    @IBOutlet weak var btn_CreateAndUpdate: UIButton!
    
    var viewModel: SetupTripViewModel
    var byCNRM:String = ""
    
    init(viewModel: SetupTripViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        // Provide a default ViewModel to avoid crash
        self.viewModel = SetupTripViewModel()  // Replace with proper default if needed
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if viewModel.uiDependOn == "Edit" {
            setupDetailBinding()
            self.btn_CreateAndUpdate.setTitle("Update", for: .normal)
        } else {
            print("Call the Update Api")
            self.btn_CreateAndUpdate.setTitle("Create", for: .normal)
        }
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_Save(_ sender: UIButton) {
        
    }
    
    @IBAction func btn_ConfirmTripByCNRM(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            sender.setImage(R.image.rectangleUncheck(), for: .normal)
            byCNRM = "No"
        } else {
            sender.isSelected = true
            sender.setImage(R.image.rectangleChecked(), for: .normal)
            byCNRM = "Yes"
        }
    }
    
    @IBAction func btn_MapType(_ sender: UIButton) {
        viewModel.dropDown.show()
    }
    
    private func setupBinding()
    {
        viewModel.fetchCountryMaps(vC: self)
        viewModel.fethcedSuccessfully = { [] in
            print("Data Fetched Successfully!")
            self.viewModel.configureDropDown(sender: self.btn_DropOt)
        }
    }
    
    private func setupDetailBinding()
    {
        viewModel.fetchDetailScheduleTrip(vC: self)
        viewModel.fethcedSuccessfully = { [] in
            let obj = self.viewModel.arrayOfDetailTrip
            self.btn_DropOt.setTitle(obj?.map_type, for: .normal)
            self.txt_MapName.text = obj?.trip_name
            self.txt_Address.text = obj?.address
            self.txt_HowManyDays.text = obj?.how_much_day
            
            if obj?.trip_by_cineramap == "Yes" {
                self.btn_ByCNRMOt.setImage(R.image.rectangleChecked(), for: .normal)
            } else {
                self.btn_ByCNRMOt.setImage(R.image.rectangleUncheck(), for: .normal)
            }
        }
    }
}
