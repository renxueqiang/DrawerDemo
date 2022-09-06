//
//  DrawerRightVC.swift
//  DrawerDemo
//
//  Created by renxueqiang on 2022/7/15.
//

import UIKit

class DrawerRightVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        let label = UILabel(frame: CGRect(x: 0, y: 100, width: view.bounds.width, height: 200))
        label.numberOfLines = 0;
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "此控制器一般是 UITabBarController \n 请自行更改 \n\n\n\n\n 请左滑屏幕"
        view.addSubview(label)
        
    }
}
