//
//  AllMapViewMode.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 05/09/24.
//

import Foundation

class AllMapViewModel {
    
    var cityId: String = ""
    
    var cityName: String = ""
    var ratingReviewStar: Double = 0.0
    var ratingReviewCount: String = ""
    var address: String = ""
    var aboutCity:String = ""
    var countryCurrency: String = ""
    var countryOfficialLanguage: String = ""
    var clothing: String = ""
    var bestVisitTiming: String = ""
    var health: String = ""
    var electric: String = ""
    var communication: String = ""
    var wealther: String = ""
    
    var policeCarNum: String = ""
    var policePhoneNum: String = ""
    
    var fetchedSuccessfully:(() -> Void)?
    
    func navigateToSubcribeViewController(from navigationController: UINavigationController?) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "SubcribeVC") as! SubcribeVC
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
            let obj = responseData
            self.cityName = obj.name ?? ""
            self.ratingReviewStar = Double(obj.place_details?[0].avg_rating ?? "") ?? 0.0
            self.ratingReviewCount = obj.place_details?[0].avg_rating ?? ""
            self.address = obj.address ?? ""
            self.aboutCity = obj.about_city ?? ""
            self.countryCurrency = obj.currency ?? ""
            self.countryOfficialLanguage = obj.offical_language ?? ""
            self.clothing = obj.clothing ?? ""
            self.bestVisitTiming = obj.best_time_to_visit ?? ""
            self.health = obj.health ?? ""
            self.electric = obj.electrical_socket ?? ""
            self.communication = obj.communications ?? ""
            self.wealther = obj.the_waether ?? ""
            self.policeCarNum = obj.car_police_number ?? ""
            self.policePhoneNum = obj.police_number ?? ""
            self.fetchedSuccessfully?()
        }
    }
    
}
