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
    var currentMap: String = "loading..."
    private let urlString: String = "https://api.mozambiquehe.re/maprotation?auth=2cce93eb972df7d78c8e42345037c9d3&version=2"
    
    func fetchRotation() {
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                self.currentMap = "URL 오류"
            }
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if let error = error {
                print("request error: ", error)
                DispatchQueue.main.async {
                    self.currentMap = "불러오기 실패"
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.currentMap = "데이터 없음"
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MapRotationResponse.self, from: data)
                
                DispatchQueue.main.sync {
                    self.currentMap = response.current.map
                }
            } catch {
                print("decode error: ", error)
                DispatchQueue.main.async {
                    self.currentMap = "불러오기 실패"
                }
            }
        }
        .resume()
    }
}
