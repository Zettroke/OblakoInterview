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
        print(data);
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("project")!
        cell.textLabel!.text = data[indexPath.section][0]
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return data.count;
    }
    @IBAction func submit(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}