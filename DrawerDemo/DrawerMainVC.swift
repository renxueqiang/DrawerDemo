//
//  DrawerMainVC.swift
//  DrawerDemo
//
//  Created by renxueqiang on 2022/7/6.
//

import UIKit

class DrawerMainVC: UIViewController {
    var rootVc:UIViewController
    var leftVc:UIViewController
    var originalPoint:CGPoint = CGPoint(x: 0, y: 0)

    var menuWidth:CGFloat {
        return 0.8 * view.bounds.size.width
    }
    var emptyWidth:CGFloat {
        return view.bounds.size.width
    }
    lazy var coverView:UIView = {
       let coverV = UIView(frame: view.bounds)
        coverV.backgroundColor = .black
        coverV.alpha = 0
        coverV.isHidden = true
        let tap  = UITapGestureRecognizer.init(target: self, action: #selector(tapCoverView))
        coverV.addGestureRecognizer(tap)
        rootVc.view.addSubview(coverV)
        return coverV
    }()

    init(rootVc rootViewController: UIViewController, leftVc leftViewController:UIViewController) {
        rootVc = rootViewController
        leftVc = leftViewController
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        addChild(rootVc)
        view.addSubview(rootVc.view)
        rootVc.didMove(toParent: self)
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(panGestureRecognizer(pan:)))
        pan.delegate = self
        view.addGestureRecognizer(pan)

        addChild(leftVc)
        view.insertSubview(leftVc.view, at: 0)
        updateLeftVcFrame()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)

    }
}
extension DrawerMainVC {
    @objc func panGestureRecognizer(pan: UIPanGestureRecognizer) {
        switch pan.state {
        case UIGestureRecognizer.State.began:
            originalPoint = rootVc.view.center
        case UIGestureRecognizer.State.changed:
            panChange(pan: pan)

        case UIGestureRecognizer.State.ended:
            panEnd(pan: pan)

        default: break

        }
    }

    func panChange(pan:UIPanGestureRecognizer) -> Void {
        let translation = pan.translation(in: view)
        rootVc.view.center = CGPoint(x: originalPoint.x + translation.x, y: originalPoint.y)

        if rootVc.view.frame.minX > menuWidth {
            rootVc.view.center = CGPoint(x: rootVc.view.bounds.size.width * 0.5 + menuWidth, y: rootVc.view.center.y)
        }
        if rootVc.view.frame.minX < 0 {
            rootVc.view.center = CGPoint(x: rootVc.view.bounds.size.width * 0.5, y: rootVc.view.center.y)
        }

        if rootVc.view.frame.minX > 0 {
            updateLeftVcFrame()
            coverView.isHidden = false
            rootVc.view.bringSubviewToFront(coverView)
            coverView.alpha = rootVc.view.frame.minX/menuWidth * 0.3

        }

    }
    func panEnd(pan:UIPanGestureRecognizer) -> Void {
        let speed = pan.velocity(in: pan.view).x
        if abs(speed) > 500 {
            dealWithFastPan(speed: speed)
        }else{
            if rootVc.view.frame.minX > menuWidth/2 {
                showLeftVCAnimated(animated: true)
            }else{
                showRootVCAnimated(animated: true)
            }
        }
    }

    func updateLeftVcFrame() {
        leftVc.view.center = CGPoint(x: rootVc.view.frame.minX * 0.5, y: leftVc.view.center.y)
    }

    @objc func tapCoverView() {
        showRootVCAnimated(animated: true)
    }

    func showRootVCAnimated(animated:Bool) -> Void {
        UIView.animate(withDuration: animated == true ? 0.25 : 0) {
            self.rootVc.view.frame = self.rootVc.view.bounds
            self.updateLeftVcFrame()
            self.coverView.alpha = 0
        } completion: { finish in
            self.coverView.isHidden = true
        }
    }

    @objc func showLeftVCAnimated(animated:Bool) -> Void {
        coverView.isHidden = false
        rootVc.view.bringSubviewToFront(coverView)
        UIView.animate(withDuration: animated == true ? 0.25 : 0) {
            self.rootVc.view.center = CGPoint(x: self.rootVc.view.bounds.size.width/2 + self.menuWidth, y: self.rootVc.view.center.y)
            self.leftVc.view.frame = CGRect(x: 0, y: 0, width: self.menuWidth, height: self.view.bounds.size.height)
            self.coverView.alpha = 0.3
        }
    }

    func dealWithFastPan(speed:CGFloat) -> Void {
        let swipR = speed > 0 ? true : false
        let swipL = speed < 0 ? true : false
        let rootX = rootVc.view.frame.minX
        if swipR {
            if rootX > 0 {
                showLeftVCAnimated(animated: true)
            }else{
                showRootVCAnimated(animated: true)
            }
        }

        if swipL {
            if rootX > 0 {
                showRootVCAnimated(animated: true)
            }
        }
    }
}
extension DrawerMainVC: UIGestureRecognizerDelegate {

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {

        if gestureRecognizer is UIPanGestureRecognizer {
            let point = touch.location(in: gestureRecognizer.view)
            if point.x <= emptyWidth || (point.x > view.bounds.width - emptyWidth && rootVc.view.frame.origin.x > emptyWidth) {
                return true
            }else{
                return false
            }
        }else{
            return true
        }
    }
}
