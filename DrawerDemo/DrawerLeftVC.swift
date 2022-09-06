//
//  DrawerLeftVC.swift
//  DrawerDemo
//
//  Created by renxueqiang on 2022/7/8.
//

import UIKit

class DrawerLeftVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(myTableview)
    }
    lazy var myTableview: UITableView = {
          let tableview = UITableView(frame: view.bounds, style: .plain)
          tableview.backgroundColor = .orange
          tableview.showsVerticalScrollIndicator = false
          tableview.dataSource = self
          tableview.separatorStyle = .none
          return tableview
      }()
}
extension DrawerLeftVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "left")
        if  cell == nil{
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "left")
            cell?.backgroundColor = .orange
        }
        cell?.textLabel?.text = "我是第\(indexPath.row)行啊"
        return cell!
    }
    
   
}
