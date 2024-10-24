//
//  ScheduleTripViewModel.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 21/10/24.
//

import Foundation
import DropDown

class ScheduleTripViewModel {
    
    var fethcedSuccessfully:(() -> Void)?
    var arrayOfScheduleTrip: [Res_ScheduleTrip] = []

    func fetchScheduleTrip(vC: UIViewController)
    {
        Api.shared.requestScheduleTrip(vC) { responseData in
            if responseData.count > 0 {
                self.arrayOfScheduleTrip = responseData
            } else {
                self.arrayOfScheduleTrip = []
            }
            self.fethcedSuccessfully?()
        }
    }
    
    func navigateToSetupScheduleViewController(from navigationController: UINavigationController?, isHandled: String, tripId: String) {
        let vC = R.storyboard.main().instantiateViewController(withIdentifier: "SetupScheduleVC") as! SetupScheduleVC
        vC.viewModel.uiDependOn = isHandled
        vC.viewModel.tripID = tripId
        navigationController?.pushViewController(vC, animated: true)
    }
}
