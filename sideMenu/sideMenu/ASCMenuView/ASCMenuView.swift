//
//  ASCMenuView.swift
//  sideMenu
//
//  Created by Abel Sánchez Custodio on 1/6/16.
//  Copyright © 2016 acsanchezcu. All rights reserved.
//

import UIKit

class ASCMenuView: UIView {
    
    var view: UIView!
    
    var menuWidth: CGFloat?
    var menuSide: MenuSide?
    var menuMode: MenuMode?
    var menuView: UIView?
    
    //MARK: - Init
    
    convenience init () {
        self.init(frame:CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(menuConfiguration: MenuConfiguration) {
        self.init(frame:CGRect.zero)
        
        self.menuView = menuConfiguration.menuView
        self.menuSide = menuConfiguration.menuSide
        self.menuMode = menuConfiguration.menuMode
        self.menuWidth = menuConfiguration.menuWidth
        
        initialize()
    }
    
    //MARK: - Private Methods
    
    func initialize() {
        let containerView = UIView.init()
        
        addSubview(containerView)
        
        UIView.embedView(containerView, size: CGSize.init(width: menuWidth!, height: CGFloat.min), top: true, left: true, right: false, bottom: true)
        
        containerView.addSubview(menuView!)
        
        UIView.embedView(menuView!)
    }
}
