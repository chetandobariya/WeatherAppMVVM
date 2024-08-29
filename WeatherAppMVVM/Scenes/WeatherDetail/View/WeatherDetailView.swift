//
//  WeatherDetail.swift
//  WeatherAppMVVM
//
//  Created by Chetankumar Dobariya on 29.08.24.
//

import SwiftUI

struct WeatherDetailView: View {
    @Binding var isPresented: Bool
    @State var offset: CGFloat = 0
    var forecast: Forecast? = nil
    var cityName = ""
    var topEdge: CGFloat
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct WeatherDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader{proxy in
            let topEdge = proxy.safeAreaInsets.top
            WeatherDetailView(isPresented: .constant(false), 
                              topEdge: topEdge)
        }
    }
}



