//
//  TodosController.swift
//  OblakoTODO
//
//  Created by superroot on 27.12.18.
//  Copyright © 2018 superroot. All rights reserved.
//

import Foundation
import UIKit
import M13Checkbox

class TodosController: UITableViewController {
    
    @IBOutlet var table: UITableView!
    
    let color = UIColor(red: CGFloat(0x3A)/255.0, green: CGFloat(0xAF)/255.0, blue: CGFloat(0xDA)/255.0, alpha: CGFloat(1))
    
    var data = [[String]]()
    var checked = [[Bool]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.barTintColor = color
        
        
        data = [
            ["Family", "Do it", "Do that", "Do this"],
            ["Family1", "Do it1", "Do that1", "Do this1"],
            ["Family2", "Do it2", "Do that2", "Do this2"],
            ["Family3", "Do it3", "Do that3", "Do this3"],
        ]
        
        checked = [
            [false, true, false],
            [false, true, false],
            [false, true, false],
            [false, true, false]
        ]
        
        print("dksajdksadjlsajdklsadjsakldjsadkasjl!!!!!!111")
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count-1;
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var header: HeaderCell = tableView.dequeueReusableCellWithIdentifier("header") as! HeaderCell;
        
        header.textLabel!.text = data[section][0]
        header.textLabel!.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        return header
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0;
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: TodoCell = tableView.dequeueReusableCellWithIdentifier("task") as! TodoCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.checkbox.boxType = M13Checkbox.BoxType.Square
        cell.checkbox.stateChangeAnimation = M13Checkbox.Animation.Fill
        
        cell.checkbox.tintColor = color
        //cell.checkbox.secondaryTintColor = color
        //cell.checkbox.secondaryCheckmarkTintColor = color
        
        
        if (checked[indexPath.section][indexPath.row]){
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: data[indexPath.section][indexPath.row+1])
            attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
            
            
            cell.task.attributedText = attributeString;
            cell.checkbox.setCheckState(M13Checkbox.CheckState.Checked, animated: false)
        }else{
            cell.task.attributedText = NSMutableAttributedString(string: data[indexPath.section][indexPath.row+1])
        }
        
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return data.count;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        
        let navVC = segue.destinationViewController as? UINavigationController

        let tableVC = navVC?.viewControllers.first as! AddTodoController

        tableVC.data = data
        
    }
}
