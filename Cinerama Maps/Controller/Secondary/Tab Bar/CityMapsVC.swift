//
//  CityMapsVC.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 27/08/24.
//

import UIKit

class CityMapsVC: UIViewController {

    @IBOutlet weak var city_MapTableVw: UITableView!
    @IBOutlet weak var search_Bar: UISearchBar!
    
    let viewModel = CityViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setupSearchBar(for: search_Bar)
        self.city_MapTableVw.register(UINib(nibName: "CityMapCell", bundle: nil), forCellReuseIdentifier: "CityMapCell")
        fetchCityMapDetails()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }

    @IBAction func btn_Back(_ sender: UIButton) {
        viewModel.returnBackk(from: self.navigationController)
    }
    
    private func fetchCityMapDetails()
    {
        viewModel.requestCityMapDetails(vC: self)
        viewModel.requestSuccessfull = { [] in
            DispatchQueue.main.async {
                self.city_MapTableVw.reloadData()
            }
        }
    }
}

extension CityMapsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.arrayOfDetailCityMap.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityMapCell", for: indexPath) as! CityMapCell
        
        let obj = self.viewModel.arrayOfDetailCityMap[indexPath.row]
        cell.lbl_CountryName.text = obj.name ?? ""
        cell.lbl_Rating.text = obj.avg_rating ?? ""
        cell.lbl_Address.text = obj.address ?? ""
        cell.rating_Vw.rating = Double(obj.avg_rating ?? "") ?? 0.0
        
        if Router.BASE_IMAGE_URL != obj.image {
            Utility.setImageWithSDWebImage(obj.image ?? "", cell.img)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.navigateToCityMapsDetailViewController(from: self.navigationController, cityId: self.viewModel.arrayOfDetailCityMap[indexPath.row].id ?? "")
    }
}
