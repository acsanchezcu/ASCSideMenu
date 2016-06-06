//
//  ViewController.swift
//  sideMenu
//
//  Created by Abel Sánchez Custodio on 31/5/16.
//  Copyright © 2016 acsanchezcu. All rights reserved.
//

import UIKit

class ASCMenuViewController: UIViewController {
    
    enum MenuSide {
        case Left
        case Right
    }
    
    enum MenuMode {
        case OverNavigationBar
        case OverNavigationView
        case BehindNavigationBar
        case BehindNavigationView
    }
    
    struct MenuConfiguration {
        let menuWidth: CGFloat
        let menuSide: MenuSide
        let menuMode: MenuMode
        let menuView: UIView
    }
    
    var menuOriginCenterX : CGFloat = 0.0
    var lastTranslationX : CGFloat = 0.0
    
    var isMenuOpen = false
    
    let panRec = UIPanGestureRecognizer()
    let tapRec = UITapGestureRecognizer()
    
    var leftConstraint: NSLayoutConstraint? {
        get {
            
            for constraint in (menuView?.constraints)! {
                return constraint
            }
            
            return NSLayoutConstraint.init()
        }
        set {
            self.leftConstraint = newValue
        }
    }
    
    var menuView: ASCMenuView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func initMenuConfiguration(menuConfiguration: MenuConfiguration) {
        menuView = ASCMenuView.init(menuConfiguration: menuConfiguration)
        
        panRec.addTarget(self, action: #selector(ASCMenuViewController.handlePan(_:)))
        tapRec.addTarget(self, action: #selector(ASCMenuViewController.handleTap(_:)))
        
        view.addGestureRecognizer(tapRec)
        
        switch menuConfiguration.menuMode {
        case .BehindNavigationView:
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.window?.addSubview(menuView!)
            
            UIView.embedView(menuView!, size: CGSize.init(width: CGFloat.min, height: view.frame.height - (navigationController?.navigationBar.frame.height)! - 20), top: false, left: true, right: true, bottom: true)
            view.addGestureRecognizer(panRec)
            
            appDelegate.window?.sendSubviewToBack(menuView!)
            break
        case .BehindNavigationBar:
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.window?.addSubview(menuView!)
            
            UIView.embedView(menuView!)
            navigationController?.view.addGestureRecognizer(panRec)
            
            appDelegate.window?.sendSubviewToBack(menuView!)
            break
        case .OverNavigationBar:
            
            self.navigationController?.view.addSubview(menuView!)
            
            UIView.embedView(menuView!, size: CGSize.init(width: menuConfiguration.menuWidth, height:CGFloat.min), top: true, left: true, right: false, bottom: true)
            
//            UIView.embedView(menuView!)
            
            menuView?.center.x = 0.0
            
            navigationController?.view.addGestureRecognizer(panRec)
            
            self.navigationController?.view.sendSubviewToBack(menuView!)
            break
        default:
            break
        }
        
        menuOriginCenterX = (navigationController?.view.center.x)!
    }
    
    func handlePan(recognizer:UIPanGestureRecognizer) {
        
//        let translationInView = (menuView?.menuMode == MenuMode.OverNavigationBar) ? navigationController?.view : self.view
        
        let translationInView = (menuView?.menuMode == MenuMode.OverNavigationBar) ? menuView! : self.view
        
        let translation = recognizer.translationInView(translationInView)
        
//        if menuView?.menuMode == .OverNavigationBar {
//         
//            leftConstraint?.constant += translation.x
//            
//            return
//        }
        
//        print(translation)
        
//        print("origin \(navigationController?.view.frame.origin.x)")
        print("center \(navigationController?.view.center.x)")
//        print("translation x \(translation.x)")
        
        
        if let view = recognizer.view {
            view.center = CGPoint(x:(view.center.x + translation.x < menuOriginCenterX) ? menuOriginCenterX : view.center.x + translation.x,
                                  y:view.center.y)
        }
    
        if recognizer.state == .Ended {
            if let view = recognizer.view {
                isMenuOpen = ((view.center.x - menuOriginCenterX) > (menuView?.menuWidth)! / 4 && lastTranslationX > -15) || lastTranslationX > 15.0
                
                lastTranslationX = 0.0
                
                UIView.animateWithDuration(0.2, animations: {
                    view.center.x = (self.isMenuOpen) ? self.menuOriginCenterX + (self.menuView?.menuWidth)! : self.menuOriginCenterX;
                })
                
                
                
//                openMenu(isMenuOpen)
            }
            
//            UIView.animateWithDuration(0.3) {
//                recognizer.setTranslation(CGPointZero, inView: navigationController?.view)
//            }
        }
        else {
            
            lastTranslationX = translation.x
            
            recognizer.setTranslation(CGPointZero, inView: translationInView)
        }
        
        
    }
    
    func handleTap(recognizer:UIPanGestureRecognizer) {
        
        if isMenuOpen {
            isMenuOpen = false
            
            openMenu(isMenuOpen)
        }
    }
    
    @IBAction func userDidTapMenuButton(sender: AnyObject) {
        
        isMenuOpen = !isMenuOpen
        
        openMenu(isMenuOpen)
    }
    
    func openMenu(open: Bool) {
        
        if menuView?.menuMode == MenuMode.OverNavigationBar {
            navigationController?.view.bringSubviewToFront(menuView!)
        }
        
        let translation : CGFloat = (open) ? menuOriginCenterX + (menuView?.menuWidth)! : menuOriginCenterX
        
        UIView.animateWithDuration(0.3, animations: { 
            let menuMode = self.menuView?.menuMode
            
            if menuMode == .BehindNavigationBar {
                self.navigationController?.view.center.x = translation
            } else if menuMode == .BehindNavigationView{
                self.view.center.x = translation
            } else if menuMode == .OverNavigationBar {
                self.menuView?.center.x = (open) ? 400.0 : -self.menuOriginCenterX
            }
            
            }) { (completion) in
                if self.menuView?.menuMode == MenuMode.OverNavigationBar && !open {
                    self.navigationController?.view.sendSubviewToBack(self.menuView!)
                }
        }
    }
}

