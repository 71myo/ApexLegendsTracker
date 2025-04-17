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
            Text("지금 맵 뭐야")
            Text(viewModel.currentPubsMap)
            Text(viewModel.currentRankedMap)
            Text(viewModel.currentLtmMap)
        }
        .onAppear {
            viewModel.fetchRotation()
        }
    }
}

#Preview {
    RotationView()
}
