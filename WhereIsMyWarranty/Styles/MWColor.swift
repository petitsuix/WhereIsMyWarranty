//
//  MWColors.swift
//  Où est ma garantie ?
//
//  Created by Richardier on 03/12/2021.
//

import UIKit

enum MWColor {
    static var navigationFrame: UIColor = {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return MWColor.black
                } else {
                    return MWColor.paleOrange
                }
            }
    }()
    
    static var bluegreyElement: UIColor = {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return bluegreyDarkTheme
                } else {
                    return bluegrey
                }
            }
    }()
    static let bluegreyDarkTheme = #colorLiteral(red: 0.568555057, green: 0.7904096842, blue: 0.7742930055, alpha: 1)

    static let bluegrey = #colorLiteral(red: 0.254899621, green: 0.337256074, blue: 0.3607835174, alpha: 1)
    static let colorTest1 = #colorLiteral(red: 0.8981259477, green: 0.7173939888, blue: 0.333548257, alpha: 1)
    static let paleOrange = #colorLiteral(red: 0.9683179259, green: 0.7787390351, blue: 0.5379128456, alpha: 1)
    static let warrantyExpiredRed = #colorLiteral(red: 0.9505781531, green: 0.195168674, blue: 0.1363289952, alpha: 1)
    static let warrantyActiveGreen = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    static let black = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    static let systemBackground = UIColor.systemBackground
    static let red = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
}
