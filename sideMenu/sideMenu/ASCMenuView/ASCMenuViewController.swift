//
//  ViewController.swift
//  sideMenu
//
//  Created by Abel Sánchez Custodio on 31/5/16.
//  Copyright © 2016 acsanchezcu. All rights reserved.
//

import UIKit

//MARK: - Properties

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

class ASCMenuViewController: UIViewController {
    
    var menuOriginCenterX : CGFloat = 0.0
    var lastTranslationX : CGFloat = 0.0
    
    var isMenuOpen = false
    
    let panRec = UIPanGestureRecognizer()
    let tapRec = UITapGestureRecognizer()
    
    var navigationBarSize : CGFloat {
        get {
            return (navigationController?.navigationBar.frame.height)! + 20.0
        }
    }
    
    var menuView: ASCMenuView?
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(animated: Bool) {
        if isMenuOpen {
            openMenu(false)
        } else {
            menuView?.removeFromSuperview()
        }
    }
    
     //MARK: - Public Methods
    
    func initMenuConfiguration(menuConfiguration: MenuConfiguration) {
        menuView = ASCMenuView.init(menuConfiguration: menuConfiguration)
        
        view.addGestureRecognizer(tapRec)
        
        switch menuConfiguration.menuMode {
        case .BehindNavigationView:
            
            panRec.addTarget(self, action: #selector(ASCMenuViewController.handleBehindPan(_:)))
            tapRec.addTarget(self, action: #selector(ASCMenuViewController.handleBehindTap(_:)))
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.window?.addSubview(menuView!)
            
            UIView.embedView(menuView!, size: CGSize.init(width: CGFloat.min, height: view.frame.height - navigationBarSize), top: false, left: true, right: true, bottom: true)
            view.addGestureRecognizer(panRec)
            
            appDelegate.window?.sendSubviewToBack(menuView!)
            
            menuOriginCenterX = (navigationController?.view.center.x)!
            break
        case .BehindNavigationBar:
            
            panRec.addTarget(self, action: #selector(ASCMenuViewController.handleBehindPan(_:)))
            tapRec.addTarget(self, action: #selector(ASCMenuViewController.handleBehindTap(_:)))
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.window?.addSubview(menuView!)
            
            UIView.embedView(menuView!)
            navigationController?.view.addGestureRecognizer(panRec)
            
            appDelegate.window?.sendSubviewToBack(menuView!)
            
            menuOriginCenterX = (navigationController?.view.center.x)!
            break
        case .OverNavigationBar, .OverNavigationView:
            panRec.addTarget(self, action: #selector(ASCMenuViewController.handleOverPan(_:)))
            tapRec.addTarget(self, action: #selector(ASCMenuViewController.handleOverTap(_:)))
            
            self.navigationController?.view.addSubview(menuView!)
            
            if menuConfiguration.menuMode == .OverNavigationBar {
                menuView?.frame = CGRectMake(0, 0, menuConfiguration.menuWidth, view.frame.height)
            } else {
                menuView?.frame = CGRectMake(0, navigationBarSize, menuConfiguration.menuWidth, view.frame.height - navigationBarSize)
            }
            
            menuOriginCenterX = (menuView?.center.x)!
            
            menuView?.center.x = (menuView?.center.x)! - menuConfiguration.menuWidth
            
            navigationController?.view.addGestureRecognizer(panRec)
            break
        }
    }
    
    func openMenu(open: Bool) {

        let translation : CGFloat = (open) ? menuOriginCenterX + (menuView?.menuWidth)! : menuOriginCenterX
        
        UIView.animateWithDuration(0.3) {
            let menuMode = self.menuView?.menuMode
            
            if menuMode == .BehindNavigationBar {
                self.navigationController?.view.center.x = translation
            } else if menuMode == .BehindNavigationView{
                self.view.center.x = translation
            } else if menuMode == .OverNavigationBar || menuMode == .OverNavigationView {
                self.menuView?.center.x = (open) ? self.menuOriginCenterX : self.menuOriginCenterX - (self.menuView?.menuWidth)!
            }
        }
    }
    
    //MARK: - Action Methods
    
    @IBAction func userDidTapMenuButton(sender: AnyObject) {
        
        isMenuOpen = !isMenuOpen
        
        openMenu(isMenuOpen)
    }
    
    //MARK: - Handle Methods
    
    func handleBehindPan(recognizer:UIPanGestureRecognizer) {
        
        let translationInView = self.view
        
        let translation = recognizer.translationInView(translationInView)
        
        print("center \(navigationController?.view.center.x)")
        
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
            }
        }
        else {
            
            lastTranslationX = translation.x
            
            recognizer.setTranslation(CGPointZero, inView: translationInView)
        }
    }
    
    func handleBehindTap(recognizer:UIPanGestureRecognizer) {
        if isMenuOpen {
            isMenuOpen = false
            
            openMenu(isMenuOpen)
        }
    }
    
    func handleOverPan(recognizer:UIPanGestureRecognizer) {
        
//        if recognizer.state == .Began {
//            if menuView?.menuMode == MenuMode.OverNavigationBar {
//                self.navigationController?.view.bringSubviewToFront(menuView!)
//            }
//        }
        
        let translationInView = (menuView?.menuMode == MenuMode.OverNavigationBar) ? menuView! : self.view
        
        let translation = recognizer.translationInView(translationInView)
        
        print("center \(menuView?.center.x)")

        menuView?.center = CGPoint(x: (menuView?.center.x)! + translation.x, y: (menuView?.center.y)!)
        
        if recognizer.state == .Ended {
                isMenuOpen = (((menuView?.center.x)! - menuOriginCenterX) > (menuView?.menuWidth)! / 4 && lastTranslationX > -15) || lastTranslationX > 15.0
                
                lastTranslationX = 0.0
                
                UIView.animateWithDuration(0.2, animations: {
                    self.menuView?.center.x = (self.isMenuOpen) ? self.menuOriginCenterX : self.menuOriginCenterX - (self.menuView?.menuWidth)!;
                })
        }
        else {
            
            lastTranslationX = translation.x
            
            recognizer.setTranslation(CGPointZero, inView: translationInView)
        }
    }
    
    func handleOverTap(recognizer:UIPanGestureRecognizer) {
        
        if isMenuOpen {
            isMenuOpen = false
            
            openMenu(isMenuOpen)
        }
    }
}

