//
//  AddTodoController.swift
//  OblakoTODO
//
//  Created by superroot on 28.12.18.
//  Copyright © 2018 superroot. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


class AddTodoController: UITableViewController{
    
    var data: [NSDictionary]!
    @IBOutlet var table: UITableView!
    
    var task_name_cell: CreationCell!
    //@IBOutlet weak var task_name: UITextField!
    
    var selected_id = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.tableFooterView = UIView()
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.barTintColor = UIColor(red: CGFloat(0x3A)/255.0, green: CGFloat(0xAF)/255.0, blue: CGFloat(0xDA)/255.0, alpha: CGFloat(1))
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1: data.count;
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var header = tableView.dequeueReusableCellWithIdentifier("header")!;
        
        header.textLabel!.text = section == 0 ? "Задача": "Категория"
        
        return header
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if indexPath.section == 0{
            cell = tableView.dequeueReusableCellWithIdentifier("create")!
            task_name_cell = cell as! CreationCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
        }else{
            cell = tableView.dequeueReusableCellWithIdentifier("project")!
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            var project_cell = cell as! ProjectCell
            project_cell.label.text = data[indexPath.row]["title"] as! String
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.section != 0){
            selected_id = data[indexPath.row]["id"] as! Int
            
            for row in 0..<tableView.numberOfRowsInSection(1){
                let path  = NSIndexPath(forRow: row, inSection: 1)
                var cell = tableView.cellForRowAtIndexPath(path) as! ProjectCell
                
                cell.checkmark.hidden = true
            }
            
            (tableView.cellForRowAtIndexPath(indexPath) as! ProjectCell).checkmark.hidden = false;
            print("selected: \(data[indexPath.row]["title"])")
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2;
    }
    @IBAction func submit(sender: AnyObject) {
        if (selected_id != -1){
            Alamofire.request(.POST, "https://thawing-sands-41266.herokuapp.com/todos", parameters: ["project_id": "\(selected_id)", "text": task_name_cell.task_name.text!])
            print("Task!!! name: \(task_name_cell.task_name.text!), project_id: \(selected_id)")
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}