//
//  AddTodoController.swift
//  OblakoTODO
//
//  Created by superroot on 28.12.18.
//  Copyright © 2018 superroot. All rights reserved.
//

import Foundation
import UIKit

class AddTodoController: UITableViewController{
    
    var data: [[String]]!
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.barTintColor = UIColor(red: CGFloat(0x3A)/255.0, green: CGFloat(0xAF)/255.0, blue: CGFloat(0xDA)/255.0, alpha: CGFloat(1))
        print(data);
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1: data[section].count-1;
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var header = tableView.dequeueReusableCellWithIdentifier("header")!;
        
        header.textLabel!.text = section == 0 ? "Задача":"Категория"
        //header.textLabel!.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        return header
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if indexPath.section == 0{
            cell = tableView.dequeueReusableCellWithIdentifier("create")!
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            //cell.userInteractionEnabled = false
        }else{
            cell = tableView.dequeueReusableCellWithIdentifier("project")!
            cell.textLabel!.text = data[indexPath.row][0]
        }
        
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2;
    }
    @IBAction func submit(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}