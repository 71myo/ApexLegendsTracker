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
    var currentPubsMap: String = "loading..."
    var currentRankedMap: String = "loading..."
    var currentLtmMap: String = "loading..."
    
    private let urlString: String = "https://api.mozambiquehe.re/maprotation?auth=2cce93eb972df7d78c8e42345037c9d3&version=2"
    
    func fetchRotation() {
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                self.currentPubsMap = "URL 오류"
                self.currentRankedMap = "URL 오류"
                self.currentLtmMap = "URL 오류"
            }
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if let error = error {
                print("request error: ", error)
                DispatchQueue.main.async {
                    self.currentPubsMap = "불러오기 실패"
                    self.currentRankedMap = "불러오기 실패"
                    self.currentLtmMap = "불러오기 실패"
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.currentPubsMap = "데이터 없음"
                    self.currentRankedMap = "데이터 없음"
                    self.currentLtmMap = "데이터 없음"
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MapRotationResponse.self, from: data)
                
                DispatchQueue.main.sync {
                    self.currentPubsMap = response.pubs.current.map
                    self.currentRankedMap = response.ranked.current.map
                    self.currentLtmMap = response.ltm.current.map
                }
            } catch {
                print("decode error: ", error)
                DispatchQueue.main.async {
                    self.currentPubsMap = "불러오기 실패"
                    self.currentRankedMap = "불러오기 실패"
                    self.currentLtmMap = "불러오기 실패"
                }
            }
        }
        .resume()
    }
}
