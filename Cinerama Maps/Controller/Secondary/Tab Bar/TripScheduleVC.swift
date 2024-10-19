//
//  TripScheduleVC.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 23/08/24.
//

import UIKit

class TripScheduleVC: UIViewController {

    @IBOutlet weak var trip_TableVw: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.trip_TableVw.register(UINib(nibName: "TripScheduleCell", bundle: nil), forCellReuseIdentifier: "TripScheduleCell")
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
}

extension TripScheduleVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TripScheduleCell", for: indexPath) as! TripScheduleCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
