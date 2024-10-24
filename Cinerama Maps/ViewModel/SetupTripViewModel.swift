//
//  SetupTripViewModel.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 22/10/24.
//

import Foundation
import DropDown

class SetupTripViewModel {
    
    var fethcedSuccessfully:(() -> Void)?
    var arrayOfDetailTrip: Res_DetailScheduleTrip!
    var arrayOfMapTypes: [Res_CountryMap] = []
    
    var mapType:String = ""
    var tripID:String = ""
    var dropDown = DropDown()
    
    var uiDependOn:String = ""
    
    func fetchDetailScheduleTrip(vC: UIViewController)
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["trip_id"] = tripID as AnyObject
        
        print(paramDict)
        
        Api.shared.requestDetailsScheduleTrip(vC, paramDict) { responseData in
            self.arrayOfDetailTrip = responseData
            self.fethcedSuccessfully?()
        }
    }
    
    func configureDropDown(sender: UIButton)
    {
        var arrayOfMapName: [String] = []
        var arrayofMapId: [String] = []
        
        for val in arrayOfMapTypes {
            arrayOfMapName.append(val.name ?? "")
            arrayofMapId.append(val.id ?? "")
        }
        
        dropDown.anchorView = sender
        dropDown.dataSource = arrayOfMapName
        dropDown.backgroundColor = .white
        dropDown.setupCornerRadius(8)
        dropDown.separatorColor = .systemBackground
        dropDown.bottomOffset = CGPoint(x: -5, y: 45)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            sender.setTitle(item, for: .normal)
            mapType = item
        }
    }
    
    func fetchCountryMaps(vC: UIViewController)
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["type"] = "All" as AnyObject
        
        Api.shared.requestCountryMap(vC, paramDict) { responseData in
            if responseData.count > 0 {
                self.arrayOfMapTypes = responseData
            } else {
                self.arrayOfMapTypes = []
            }
            self.fethcedSuccessfully?()
        }
    }
    
}
