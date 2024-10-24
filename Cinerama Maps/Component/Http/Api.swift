//
//  Api.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 02/09/24.
//

import Foundation

class Api: NSObject {
    
    static let shared = Api()
    
    func paramGetUserId() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        return dict
    }
    
    func requestOtpToVerifyNum(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Api_SendOtp) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.send_otp.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_SendOtp.self, from: response)
                if root.result != nil {
                    success(root)
                } else {
                    k.userDefault.set(false, forKey: k.session.status)
                    k.userDefault.set(k.emptyString, forKey: k.session.userId)
                    k.userDefault.set(k.emptyString, forKey: k.session.userEmail)
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func signup(_ vc: UIViewController, _ params: [String: String], images: [String : UIImage?]?, videos: [String : Data?]?, _ success: @escaping(_ responseData : Res_Signup) -> Void) {
        vc.showProgressBar()
        Service.postSingleMedia(url: Router.signup.url(), params: params, imageParam: images, videoParam: videos, parentViewController: vc, successBlock: { (responseData) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Signup.self, from: responseData)
                if root.status == "1" {
                    vc.hideProgressBar()
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vc.hideProgressBar()
                    vc.alert(alertmessage: root.message ?? "Something went wrong")
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func requestUserProfile(_ vC: UIViewController,_ success: @escaping(_ responseData: Res_UserProfile) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.get_profile.url(), params: paramGetUserId(), method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_UserProfile.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    print(vC.alert(alertmessage: root.message ??  ""))
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestCountryMap(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: [Res_CountryMap]) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.get_country_map.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_CountryMap.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    print("No Data Available to show!!")
                    vC.hideProgressBar()
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestCityMap(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: [Res_CityMap]) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.get_country_map_city.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_CityMaps.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vC.hideProgressBar()
                    }
                } else {
                    print(vC.alert(alertmessage: "No data Available"))
                    vC.hideProgressBar()
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestGuidelineTips(_ vC: UIViewController,_ success: @escaping(_ responseData: [Res_GuidelineTips]) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.get_guidelines_tips.url(), params: paramGetUserId(), method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_GuidelinesTips.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vC.hideProgressBar()
                    }
                } else {
                    print("No Data Available to show!!")
                    vC.hideProgressBar()
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestAllServices(_ vC: UIViewController,_ success: @escaping(_ responseData: [Res_Services]) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.get_services.url(), params: paramGetUserId(), method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_Services.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vC.hideProgressBar()
                    }
                } else {
                    print("No Data Available to show!!")
                    vC.hideProgressBar()
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestCompanyOffers(_ vC: UIViewController,_ success: @escaping(_ responseData: [Res_Offers]) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.get_company_offer.url(), params: paramGetUserId(), method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_AllOffers.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vC.hideProgressBar()
                    }
                } else {
                    print("No Data Available to show!!")
                    vC.hideProgressBar()
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestCityPlaceDt(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Res_CityPlaceDetails) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.get_country_map_city_places.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_CityPlaceDetails.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vC.hideProgressBar()
                    }
                } else {
                    print("No Data Available to show!!")
                    vC.hideProgressBar()
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestScheduleTrip(_ vC: UIViewController,_ success: @escaping(_ responseData: [Res_ScheduleTrip]) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.get_user_trip_schedule.url(), params: paramGetUserId(), method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_ScheduleTrip.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vC.hideProgressBar()
                    }
                } else {
                    print("No Data Available to show!!")
                    vC.hideProgressBar()
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestDetailsScheduleTrip(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Res_DetailScheduleTrip) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.get_user_trip_schedule_details.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_DetailScheduleTrip.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vC.hideProgressBar()
                    }
                } else {
                    print("No Data Available to show!!")
                    vC.hideProgressBar()
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestToSelectFavUnFavCityMap(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Api_BasicModel) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.fav_unfav_citymap.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_BasicModel.self, from: response)
                if root.result != nil {
                    success(root)
                } else {
                    print("No Data Available to show!!")
                    vC.hideProgressBar()
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestToPurchasedCityMap(_ vC: UIViewController,_ success: @escaping(_ responseData: [Res_PurchasedCityMap]) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.get_purcahse_city_map_list.url(), params: paramGetUserId(), method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_PurchasedCityMaps.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    print("No Data Available to show!!")
                    vC.hideProgressBar()
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestToFavCityMap(_ vC: UIViewController,_ success: @escaping(_ responseData: [Res_FavCityMaps]) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.my_fav_citymap.url(), params: paramGetUserId(), method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_FavCityMaps.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    print("No Data Available to show!!")
                    vC.hideProgressBar()
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
}
