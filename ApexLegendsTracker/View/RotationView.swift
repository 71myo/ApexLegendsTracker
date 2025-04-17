//
//  RotationView.swift
//  ApexLegendsTracker
//
//  Created by Hyojeong on 4/17/25.
//

import SwiftUI

struct RotationView: View {
    @State private var viewModel = RotationViewModel()
    
    var body: some View {
        VStack {
            Text("PUBS")
            if let pubs = viewModel.pubsRotation {
                Text(pubs.current.map)

                AsyncImage(url: pubs.current.assetUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                
                Text("다음 맵: \(pubs.next.map)")
                Text("시작: \(pubs.next.readableDateStart)")
            }
            
            Text("RANKED")
            if let ranked = viewModel.rankedRotation {
                Text(ranked.current.map)
                
                AsyncImage(url: ranked.current.assetUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
            }
            
            Text("LTM")
            if let ltm = viewModel.ltmRotation {
                Text(ltm.current.map)
            }
        }
        .onAppear {
            viewModel.fetchRotation()
        }
    }
}

#Preview {
    RotationView()
}
