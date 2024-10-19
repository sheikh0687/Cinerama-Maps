//
//  CityViewModel.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 03/09/24.
//

import Foundation

class CityViewModel {
    
    var country_ID: String = ""
    var arrayOfDetailCityMap: [Res_CityMap] = []
    
    var requestSuccessfull:(() -> Void)?
    
    public func setupSearchBar(for search_Bar: UISearchBar) {
        search_Bar.placeholder = "Search"
        search_Bar.barTintColor = UIColor.white
        search_Bar.searchTextField.backgroundColor = UIColor.white
        search_Bar.searchTextField.textColor = UIColor.black
        
        if let clearButton = search_Bar.searchTextField.value(forKey: "_clearButton") as? UIButton {
            clearButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        }
        
        search_Bar.layer.cornerRadius = 10
        search_Bar.layer.masksToBounds = true
    }
    
    func navigateToCityMapsDetailViewController(from navigationController: UINavigationController?, cityId: String) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "AllMapsDetailVC") as! AllMapsDetailVC
        vC.viewModel.cityId = cityId
        navigationController?.pushViewController(vC, animated: true)
    }
    
    func returnBackk(from navigationController: UINavigationController?) {
        navigationController?.popViewController(animated: true)
    }
    
    func requestCityMapDetails(vC: UIViewController)
    {
        var param: [String : AnyObject] = [:]
        param["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        param["country_id"] = country_ID as AnyObject
        
        print(param)
        
        Api.shared.requestCityMap(vC, param) { responseData in
            if responseData.count > 0 {
                self.arrayOfDetailCityMap = responseData
            } else {
                self.arrayOfDetailCityMap = []
            }
            self.requestSuccessfull?()
        }
    }
}
