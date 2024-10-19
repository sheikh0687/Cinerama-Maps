//
//  CountryMapViewModel.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 03/09/24.
//

import Foundation

class CountryMapApiViewModel {
    
    var arrayCountryMaps: [Res_CountryMap] = []
    var fethcedSuccessfully:(() -> Void)?
    
    func fetchCountryMaps(vC: UIViewController)
    {
        Api.shared.requestCountryMap(vC) { responseData in
            if responseData.count > 0 {
                self.arrayCountryMaps = responseData
            } else {
                self.arrayCountryMaps = []
            }
            self.fethcedSuccessfully?()
        }
    }
}
