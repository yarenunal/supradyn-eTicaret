//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Yaren on 20.12.2024.
//

import SwiftUI

struct WeatherView: View {
    var weather: ResponseBody

    var body: some View {
        ZStack {
            VStack {
                // Üst Bilgiler
                VStack(alignment: .leading, spacing: 5) {
                    Text(weather.name)
                        .bold()
                        .font(.title)
                    Text("Today, \(Date().formatted(.dateTime.month().day().year()))")
                        .fontWeight(.light)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()

                // Orta Bilgiler
                VStack {
                    HStack {
                        VStack(spacing: 20) {
                            Image(systemName: "cloud.rain")
                                .font(.system(size: 40))
                            Text(weather.weather.first?.main ?? "N/A")
                        }
                        .frame(width: 150, alignment: .leading)

                        Spacer()

                        Text("\(weather.main.feels_like.roundDouble())°")
                            .font(.system(size: 100))
                            .fontWeight(.bold)
                            .padding()
                    }

                    Spacer().frame(height: 80)

                    // Şehir Resmi
                    AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350)
                    } placeholder: {
                        ProgressView()
                    }

                    Spacer()
                }
                .frame(maxHeight: .infinity)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .preferredColorScheme(.dark)
    }
}

#Preview {
    WeatherView(weather: previewWeather)
}

