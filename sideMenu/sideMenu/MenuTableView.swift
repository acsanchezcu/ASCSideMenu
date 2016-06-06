//
//  MenuTableView.swift
//  sideMenu
//
//  Created by Abel Sánchez Custodio on 2/6/16.
//  Copyright © 2016 acsanchezcu. All rights reserved.
//

import UIKit

class MenuTableView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    let elements = ["Home", "Login", "About", "Tutorial", "Help"]

    //MARK: - Init
    
    convenience init () {
        self.init(frame:CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initialize()
    }

    //MARK: - Private Methods
    
    func initialize() {
        
        let tableView = UITableView.init()
        
        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "CellIdentifier")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        addSubview(tableView)
        
        UIView.embedView(tableView)
        
        tableView.tableHeaderView = UIView.init(frame: CGRectMake(0, 0, 60.0, 30))
        tableView.tableFooterView = UIView.init(frame: CGRectMake(0, 0, 0, 0))
        
        tableView.backgroundColor = UIColor.lightGrayColor()
    }
    
    // MARK: - DELEGATES
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return elements.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath:indexPath)
        
        cell.textLabel?.text = elements[indexPath.row]
        
        cell.backgroundColor = UIColor.darkGrayColor()
        
        cell.textLabel?.textColor = UIColor.whiteColor()
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }
}
