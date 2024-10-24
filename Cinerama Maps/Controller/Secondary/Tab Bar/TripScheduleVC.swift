//
//  TripScheduleVC.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 23/08/24.
//

import UIKit

class TripScheduleVC: UIViewController {

    @IBOutlet weak var trip_TableVw: UITableView!
    private var viewModel: ScheduleTripViewModel
    
    init(viewModel: ScheduleTripViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        // Provide a default ViewModel to avoid crash
        self.viewModel = ScheduleTripViewModel()  // Replace with proper default if needed
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.trip_TableVw.register(UINib(nibName: "TripScheduleCell", bundle: nil), forCellReuseIdentifier: "TripScheduleCell")
        setupBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func btn_CreateSchedule(_ sender: Any) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "SetupScheduleVC") as! SetupScheduleVC
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupBinding()
    {
        viewModel.fetchScheduleTrip(vC: self)
        viewModel.fethcedSuccessfully = { [] in
            self.trip_TableVw.reloadData()
        }
    }
}

extension TripScheduleVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrayOfScheduleTrip.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TripScheduleCell", for: indexPath) as! TripScheduleCell
        let obj = viewModel.arrayOfScheduleTrip[indexPath.row]
        
        cell.lbl_Address.text = obj.address ?? ""
        cell.lbl_ScheduleTrip.text = obj.trip_name ?? ""
        
        if obj.trip_by_cineramap == "Yes" {
            cell.lbl_CreatedBy.text = "Created by Cineramamap"
        }
        
        cell.lbl_Date.text = "Last Update: \(obj.date_time ?? "")"
        
        cell.cloEdit = {
            self.viewModel.navigateToSetupScheduleViewController(from: self.navigationController, isHandled: "Edit", tripId: obj.id ?? "")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
