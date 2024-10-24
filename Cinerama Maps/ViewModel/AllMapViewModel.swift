//
//  AllMapViewMode.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 05/09/24.
//

import Foundation

class AllMapViewModel {
    
    var arrayOfDetailCityMaps: Res_CityPlaceDetails!
    var arrayOfReviews: [Rating_review] = []
    var fetchedSuccessfully:(() -> Void)?
    
    var cityId: String = ""
    
    func navigateToSubcribeViewController(from navigationController: UINavigationController?) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "PaymentVC") as! PaymentVC
        navigationController?.pushViewController(vC, animated: true)
    }
    
    func returnBackk(from navigationController: UINavigationController?) {
        navigationController?.popViewController(animated: true)
    }
    
    func requestCountryMapDetails(vC: UIViewController)
    {
        var param: [String : AnyObject] = [:]
        param["city_id"] = cityId as AnyObject
        
        print(param)
        
        Api.shared.requestCityPlaceDt(vC, param) { responseData in
            self.arrayOfDetailCityMaps = responseData
            self.arrayOfReviews = responseData.rating_review ?? []
            self.fetchedSuccessfully?()
        }
    }
}
