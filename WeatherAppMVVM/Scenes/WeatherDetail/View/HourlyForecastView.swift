//
//  HourlyForecastView.swift
//  WeatherAppMVVM
//
//  Created by Chetankumar Dobariya on 29.08.24.
//

import SwiftUI

struct HourlyForecastView: View {
    var time: String
    var farenheit: CGFloat
    var image: String
    @StateObject private var viewModel = ImageDownloader()

    var body: some View {
        VStack(spacing: 15){
            Text(time)
                .font(.callout.bold())
                .foregroundStyle(.white)

            if let image = viewModel.downloadedImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 30)
            } else {
                ProgressView()
                    .onAppear {
                    viewModel.downloadImage(from: image)
                }
            }
           
            Text("\(Int(farenheit))˚")
                .font(.callout.bold())
                .foregroundStyle(.white)
        }
        .padding(.horizontal,10)
    }
}

#Preview {
    HourlyForecastView(time: "12 PM",farenheit: 94,image: "sun.min")
}
