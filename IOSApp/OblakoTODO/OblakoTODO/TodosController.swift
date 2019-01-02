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
import Alamofire

class TodosController: UITableViewController {
    
    @IBOutlet var table: UITableView!
    
    let color = UIColor(red: CGFloat(0x3A)/255.0, green: CGFloat(0xAF)/255.0, blue: CGFloat(0xDA)/255.0, alpha: CGFloat(1))

    var data_json = [NSDictionary]()
    
    
    func get_data(){
        Alamofire.request(.GET, "https://thawing-sands-41266.herokuapp.com/get_json").responseJSON {
            (response) in switch response.result{
                
            case .Success(let JSON):
                self.data_json = (JSON as! [NSDictionary])
                print("data fetched!!!")
                self.table.reloadData()
                
            case .Failure(let err):
                print(err)
                
            }
            
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        get_data()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.barTintColor = color
        
        self.table.tableFooterView = UIView()
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (data_json[section]["todos"] as! [NSDictionary]).count
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: HeaderCell = tableView.dequeueReusableCellWithIdentifier("header") as! HeaderCell;
        
        header.textLabel!.text = data_json[section]["title"] as! String
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
        
        let todos = data_json[indexPath.section]["todos"] as! [NSDictionary]
        
        if (todos[indexPath.row]["isCompleted"] as! Bool){
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: todos[indexPath.row]["text"] as! String)
            attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
            
            
            cell.task.attributedText = attributeString;
            cell.checkbox.setCheckState(M13Checkbox.CheckState.Checked, animated: false)
        }else{
            cell.task.attributedText = NSMutableAttributedString(string: todos[indexPath.row]["text"] as! String)
            cell.checkbox.setCheckState(M13Checkbox.CheckState.Unchecked, animated: false)
        }
        
        cell.parent_table_controller = self
        cell.todo_id = todos[indexPath.row]["id"] as! Int
        
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return data_json.count;
        // return data.count;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        
        let navVC = segue.destinationViewController as? UINavigationController

        let tableVC = navVC?.viewControllers.first as! AddTodoController

        tableVC.data = data_json
        
    }
}
