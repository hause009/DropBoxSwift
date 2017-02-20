//
//  FolderController.swift
//  DropBoxSwift
//
//  Created by Alex on 19.02.17.
//  Copyright © 2017 AnsA. All rights reserved.
//

import UIKit
import SwiftyDropbox

class FolderController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var resultArray = Array<Files.Metadata>()
    var titleFolder = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "ElementCell")
        let dict = resultArray[indexPath.row]
        
        
        cell.textLabel?.text = dict.name
        
        if let file = dict as? Files.FileMetadata {
            print("This is a file with path: \(file.pathLower)")
            
            if file.name.hasSuffix(".txt") {
                
                cell.detailTextLabel?.text = "txt"
                
            } else if file.name.hasSuffix(".zip") {
                
                cell.detailTextLabel?.text = "zip"
                
            }
            else if file.name.hasSuffix(".jpg") {
                
                cell.detailTextLabel?.text = "jpg"
                
            }
            else if file.name.hasSuffix(".psd") {
                
                cell.detailTextLabel?.text = "psd"
                
            }
            else
            {
                
                cell.detailTextLabel?.text = "Folder"
                
            }
        }
        else{
            cell.detailTextLabel?.text = "Folder"
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
        let dict = resultArray[indexPath.row]
        /*
         let objectApi = File()
         self.resultArray = objectApi.requstApi(stringPathLower: dict.pathLower!)
         self.performSegue(withIdentifier: "SegueToFolder3", sender: self)
         */
        
        titleFolder = dict.name
        
        
        let client = DropboxClientsManager.authorizedClient!
        
        client.files.listFolder(path: dict.pathLower!).response(queue: DispatchQueue(label: "MyCustomSerialQueue")) { response, error in
            if let result = response {
                print(result)
                
                self.resultArray = result.entries
                if result.entries.count != 0
                {
                self.performSegue(withIdentifier: "SegueToFolder3", sender: self)
                }
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToFolder3"
        {
            let vc = segue.destination as! TableController
            vc.title = titleFolder
            vc.resultArray = resultArray
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
