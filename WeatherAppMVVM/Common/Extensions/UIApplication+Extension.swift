//
//  UIApplication+Extension.swift
//  WeatherAppMVVM
//
//  Created by Chetankumar Dobariya on 29.08.24.
//

import Foundation
import SwiftUI

extension UIApplication {
    func hideKeyboard() {
        guard let windowScene = connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        window.endEditing(true)
    }
}
