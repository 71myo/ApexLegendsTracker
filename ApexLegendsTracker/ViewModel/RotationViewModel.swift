//
//  RotationViewModel.swift
//  ApexLegendsTracker
//
//  Created by Hyojeong on 4/17/25.
//

import SwiftUI
import Observation

@Observable
final class RotationViewModel {
    var pubsRotation: ModeRotation?
    var rankedRotation: ModeRotation?
    var ltmRotation: ModeRotation?
    
    private let urlString: String = "https://api.mozambiquehe.re/maprotation?auth=2cce93eb972df7d78c8e42345037c9d3&version=2"
    
    func fetchRotation() {
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                self.pubsRotation = nil
                self.rankedRotation = nil
                self.ltmRotation = nil
            }
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("request error: ", error)
                DispatchQueue.main.async {
                    self.pubsRotation = nil
                    self.rankedRotation = nil
                    self.ltmRotation = nil
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.pubsRotation = nil
                    self.rankedRotation = nil
                    self.ltmRotation = nil
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MapRotationResponse.self, from: data)
                
                DispatchQueue.main.sync {
                    self.pubsRotation = response.pubs
                    self.rankedRotation = response.ranked
                    self.ltmRotation = response.ltm
                }
            } catch {
                print("decode error: ", error)
                DispatchQueue.main.async {
                    self.pubsRotation = nil
                    self.rankedRotation = nil
                    self.ltmRotation = nil
                }
            }
        }
        .resume()
    }
}
