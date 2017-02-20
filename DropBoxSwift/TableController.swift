//
//  TableController.swift
//  DropBoxSwift
//
//  Created by Alex on 19.02.17.
//  Copyright © 2017 AnsA. All rights reserved.
//

import UIKit
import SwiftyDropbox

class TableController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var resultArray = Array<Files.Metadata>()
    var resultArraySave = Array<Files.Metadata>()
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
        
        let file = dict as? Files.FileMetadata
        var stringFormat = ""

        //if let file = dict as? Files.FileMetadata
        if  (file != nil)
        {
            print("This is a file with path: \(file?.pathLower)")
            
            if (file?.name.hasSuffix(".txt"))! {
                
                stringFormat = "txt"
                
            } else if (file?.name.hasSuffix(".zip"))! {
                
                stringFormat = "zip"
                
            }
            else if (file?.name.hasSuffix(".jpg"))! {
                
                stringFormat = "jpg"
                
            }
            else if (file?.name.hasSuffix(".psd"))! {
                
                stringFormat = "psd"
                
            }
            else
            {
                
                stringFormat = "Unknown type"
                
            }
        }
        else{
            stringFormat = "Folder"
            
        }
        
        cell.textLabel?.text = dict.name
         let stringModified  = String(describing: file?.clientModified)
        
        if (stringFormat.isEmpty != false){
            
            cell.detailTextLabel?.text = stringFormat + " modified - " + stringModified //"\(file?.clientModified)"
        }
        else
        {
            cell.detailTextLabel?.text = stringFormat
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
        let dict = resultArray[indexPath.row]
        titleFolder =  dict.name
        
        let client = DropboxClientsManager.authorizedClient!
        
        client.files.listFolder(path: dict.pathLower!).response(queue: DispatchQueue(label: "MyCustomSerialQueue")) { response, error in
            if let result = response {
                print(result)
                
                self.resultArraySave = result.entries
                if result.entries.count != 0
                {
                    
                    self.performSegue(withIdentifier: "SegueToFolder2", sender: self)
                    
                }
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToFolder2"
        {
            let vc = segue.destination as! FolderController
            vc.title = titleFolder
            vc.resultArray = resultArraySave
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
