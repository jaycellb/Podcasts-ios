//
//  UIApplication.swift
//  Podcast
//
//  Created by Jaycell on 4/1/20.
//  Copyright © 2020 Jaycell. All rights reserved.
//

import UIKit

extension UIApplication {
    static func mainTabBarController() -> MainTabBarController? {
//        UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController
        return shared.keyWindow?.rootViewController as? MainTabBarController
    }
}
