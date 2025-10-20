//
//  Untitled.swift
//  plants_app
//
//  Created by NORAH on 28/04/1447 AH.
//

import SwiftUI

// MARK: - Extension for Hex Colors
extension Color {
    init(hex: String) {
        // (الكود الطويل لتحويل الـ Hex إلى Color)
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255, opacity: Double(a) / 255)
    }
}

// MARK: - Custom Shape for the Bottom Curve
struct BottomCurveShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.maxX + 50, y: rect.maxY - 80))
        let control1 = CGPoint(x: rect.maxX - 100, y: rect.maxY - 150)
        let endPoint = CGPoint(x: rect.maxX - 200, y: rect.maxY + 50)
        
        path.addQuadCurve(to: endPoint, control: control1)
        
        return path
    }
}
