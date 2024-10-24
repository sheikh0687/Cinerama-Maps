//
//  PurchasedCityViewModel.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 24/10/24.
//

import Foundation

class PurchasedCityViewModel {
    
    var arrayOfPurchasedCityMap: [Res_PurchasedCityMap] = []
    var requestSuccessfull:(() -> Void)?
    
    func fetchPurchaseCityMap(vC: UIViewController,tableHeight: NSLayoutConstraint)
    {
        Api.shared.requestToPurchasedCityMap(vC) { responseData in
            if responseData.count > 0 {
                self.arrayOfPurchasedCityMap = responseData
                tableHeight.constant = CGFloat(self.arrayOfPurchasedCityMap.count * 180)
            } else {
                self.arrayOfPurchasedCityMap = []
            }
            self.requestSuccessfull?()
        }
    }
    
    func fetchFavAndUnFavMap(vC: UIViewController, cityId: String)
    {
        var param: [String : AnyObject] = [:]
        param["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        param["city_id"] = cityId as AnyObject
        
        print(param)
        
        Api.shared.requestToSelectFavUnFavCityMap(vC, param) { responseData in
            if responseData.status == "1" {
                self.requestSuccessfull?()
            } else {
                print(responseData.message ?? "")
            }
        }
    }
}
