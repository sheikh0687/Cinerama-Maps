//
//  ScheduleTrip.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 22/10/24.
//

import Foundation

struct Api_ScheduleTrip : Codable {
    let result : [Res_ScheduleTrip]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([Res_ScheduleTrip].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct Res_ScheduleTrip : Codable {
    let id : String?
    let user_id : String?
    let place_id : String?
    let trip_name : String?
    let map_type : String?
    let address : String?
    let lat : String?
    let lon : String?
    let how_much_day : String?
    let trip_by_cineramap : String?
    let date_time : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case place_id = "place_id"
        case trip_name = "trip_name"
        case map_type = "map_type"
        case address = "address"
        case lat = "lat"
        case lon = "lon"
        case how_much_day = "how_much_day"
        case trip_by_cineramap = "trip_by_cineramap"
        case date_time = "date_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        place_id = try values.decodeIfPresent(String.self, forKey: .place_id)
        trip_name = try values.decodeIfPresent(String.self, forKey: .trip_name)
        map_type = try values.decodeIfPresent(String.self, forKey: .map_type)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lon = try values.decodeIfPresent(String.self, forKey: .lon)
        how_much_day = try values.decodeIfPresent(String.self, forKey: .how_much_day)
        trip_by_cineramap = try values.decodeIfPresent(String.self, forKey: .trip_by_cineramap)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }

}
