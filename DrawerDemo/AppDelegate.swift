//
//  AppDelegate.swift
//  DrawerDemo
//
//  Created by renxueqiang on 2022/7/6.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow.init(frame: UIScreen.main.bounds)
        let drawerMainVC = DrawerMainVC(rootVc: DrawerRightVC(), leftVc: DrawerLeftVC())
        window?.rootViewController = drawerMainVC
        window?.makeKeyAndVisible()
        return true
    }




}

