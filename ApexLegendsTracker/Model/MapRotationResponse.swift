//
//  Model.swift
//  ApexLegendsTracker
//
//  Created by Hyojeong on 4/17/25.
//

import Foundation

struct MapRotationResponse: Codable {
    let pubs: ModeRotation
    let ranked: ModeRotation
    let ltm: ModeRotation
    
    enum CodingKeys: String, CodingKey {
        case pubs = "battle_royale"
        case ranked, ltm
    }
}

struct ModeRotation: Codable {
    let current: Rotation
    let next: Rotation
}

// 공통 Rotation 정보
struct Rotation: Codable {
    let start: TimeInterval
    let end: TimeInterval
    let readableDateStart: String
    let readableDateEnd: String
    let map: String
    let code: String
    let durationInSecs: Int
    let durationInMinutes: Int
    let asset: String
    
    // current에만 있는 필드
    let remainingSecs: Int?
    let remainingMins: Int?
    let remainingTimer: String?
    
    // LTM에만 있는 필드
    let eventName: String?
    
    enum CodingKeys: String, CodingKey {
        case start, end, map, code, asset
        case readableDateStart = "readableDate_start"
        case readableDateEnd = "readableDate_end"
        case durationInSecs = "DurationInSecs"
        case durationInMinutes = "DurationInMinutes"
        case remainingSecs, remainingMins, remainingTimer
        case eventName
    }
}
