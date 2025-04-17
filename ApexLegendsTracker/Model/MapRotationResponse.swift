//
//  Model.swift
//  ApexLegendsTracker
//
//  Created by Hyojeong on 4/17/25.
//

import Foundation

struct MapRotationResponse: Codable {
    let current: Rotation
    let next: Rotation
    
    struct Rotation: Codable {
        let start: Int
        let end: Int
        let readableDateStart: String
        let readableDateEnd: String
        let map: String
        let DurationInSecs: Int
        let DurationInMinutes: Int
        let asset: String
        
        enum CodingKeys: String, CodingKey {
            case start, end, map, DurationInSecs, DurationInMinutes, asset
            case readableDateStart = "readableDate_start"
            case readableDateEnd = "readableDate_end"
        }
    }
}
