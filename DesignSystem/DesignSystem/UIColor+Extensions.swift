//
//  UIColor+Extensions.swift
//  DesignSystem
//
//  Copyright © 2021 YappiOS1. All rights reserved.
//

import CommonSystem
import Foundation
import UIKit

extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
}

public extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hex = hex.deletingPrefix("#")
        hex = hex.deletingPrefix("0x")
        
        if hex.count != 6 {
            DebugLog("hex count is not length 6")
        }

        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let red = (rgbValue & 0xff0000) >> 16
        let green = (rgbValue & 0xff00) >> 8
        let blue = rgbValue & 0xff

        self.init(red: CGFloat(red) / 0xff, green: CGFloat(green) / 0xff, blue: CGFloat(blue) / 0xff, alpha: alpha)
    }

    static func dynamicColor(_ light: UIColor, _ dark: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { $0.userInterfaceStyle == .dark ? dark : light }
        }
        return light
    }

    static var primaryRed: UIColor { fetchColor(#function) }
    static var primaryBlue: UIColor { fetchColor(#function) }
    static var primaryWhite: UIColor { fetchColor(#function) }
    static var primaryGray: UIColor { fetchColor(#function) }
    static var primaryTextGray: UIColor { fetchColor(#function) }
    static var primaryLightGray: UIColor { fetchColor(#function) }
    
    static var kakaoYellow: UIColor { fetchColor(#function) }
    static var kakaoBlack85: UIColor { fetchColor(#function) }

    private static func fetchColor(_ name: String) -> UIColor {
        //            let name = name.replacingOccurrences(of: "", with: "")
        let assetName = name

        guard let color = UIColor(named: assetName,
                                  in: Bundle.sharedAssets, compatibleWith: nil) else {
            //            assertionFailure()
            return .darkGray
        }
        return color
    }
}

public extension UIImage {
    convenience init(color: UIColor?, size: CGSize = CGSize(width: UIScreen.main.scale, height: UIScreen.main.scale)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color?.setFill()
        UIRectFill(rect)
        if let image = UIGraphicsGetImageFromCurrentImageContext(), let cgImage = image.cgImage {
            UIGraphicsEndImageContext()
            self.init(cgImage: cgImage, scale: UIScreen.main.scale, orientation: .up)
        } else {
            self.init()
        }
    }
}
