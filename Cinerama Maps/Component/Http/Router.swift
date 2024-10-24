//
//  Router.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 02/09/24.
//

import Foundation

enum Router: String {
    
    static let BASE_SERVICE_URL = "https://techimmense.in/CineramaMaps/webservice/"
    static let BASE_IMAGE_URL = "https://techimmense.in/CineramaMaps/uploads/images/"
    
    case send_otp
    case signup
    
    case get_profile
    case get_country_map
    case get_country_map_city
    case get_guidelines_tips
    case get_services
    case get_company_offer
    case get_country_map_city_places
    case get_user_trip_schedule
    case get_user_trip_schedule_details
    case get_purcahse_city_map_list
    case my_fav_citymap
    
    case fav_unfav_citymap
    
    public func url() -> String {
        switch self {
        case .send_otp:
            return Router.oAuthPath(path: "send_otp")
        case .signup:
            return Router.oAuthPath(path: "signup")
            
        case .get_profile:
            return Router.oAuthPath(path: "get_profile")
        case .get_services:
            return Router.oAuthPath(path: "get_services")
        case .get_country_map:
            return Router.oAuthPath(path: "get_country_map")
        case .get_country_map_city:
            return Router.oAuthPath(path: "get_country_map_city")
        case .get_guidelines_tips:
            return Router.oAuthPath(path: "get_guidelines_tips")
        case .get_company_offer:
            return Router.oAuthPath(path: "get_company_offer")
        case .get_country_map_city_places:
            return Router.oAuthPath(path: "get_country_map_city_places")
        case .get_user_trip_schedule:
            return Router.oAuthPath(path: "get_user_trip_schedule")
        case .get_user_trip_schedule_details:
            return Router.oAuthPath(path: "get_user_trip_schedule_details")
        case .get_purcahse_city_map_list:
            return Router.oAuthPath(path: "get_purcahse_city_map_list")
            
        case .fav_unfav_citymap:
            return Router.oAuthPath(path: "fav_unfav_citymap")
        case .my_fav_citymap:
            return Router.oAuthPath(path: "my_fav_citymap")
        }
    }
    
    private static func oAuthPath(path: String) -> String {
        return Router.BASE_SERVICE_URL + path
    }
}
