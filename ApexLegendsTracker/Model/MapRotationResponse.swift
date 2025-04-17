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
    }
}
