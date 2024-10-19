//
//  HomeViewModel.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 31/08/24.
//

import Foundation
import UIKit

class HomeViewModel {
    
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
}

extension HomeViewModel {
    
    func navigateToSettingViewController(from navigationController: UINavigationController?) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
        navigationController?.pushViewController(vC, animated: true)
    }
    
    func navigateToTripViewController(from navigationController: UINavigationController?) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "TripScheduleVC") as! TripScheduleVC
        navigationController?.pushViewController(vC, animated: true)
    }
    
    func navigateToNotificationViewController(from navigationController: UINavigationController?) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "NotifyVC") as! NotifyVC
        navigationController?.pushViewController(vC, animated: true)
    }
    
    func navigateToGuidlineViewController(from navigationController: UINavigationController?, resGuidelineTip: [Res_GuidelineTips]) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "GuidelinesVC") as! GuidelinesVC
        vC.arrayGuidelineTip = resGuidelineTip
        navigationController?.pushViewController(vC, animated: true)
    }
    
    func navigateToServicesViewController(from navigationController: UINavigationController?) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "ServiceDetailVC") as! ServiceDetailVC
        navigationController?.pushViewController(vC, animated: true)
    }
    
    func navigateToCityMapsViewController(from navigationController: UINavigationController?, countryId: String) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "CityMapsVC") as! CityMapsVC
        vC.viewModel.country_ID = countryId
        navigationController?.pushViewController(vC, animated: true)
    }
}
