//
//  LoadingView.swift
//  WeatherApp
//
//  Created by Yaren on 18.12.2024.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint:.white))
            .frame(maxWidth : .infinity , maxHeight : .infinity)
        
    }
}

#Preview {
    LoadingView()
}
