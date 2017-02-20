//
//  ViewController.swift
//  DropBoxSwift
//
//  Created by Alex on 13.02.17.
//  Copyright © 2017 AnsA. All rights reserved.
//

import UIKit
import SwiftyDropbox


class ViewController: UIViewController {

    var resultArray = Array<Files.Metadata>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    // MARK: - Authorization
    @IBAction func clickAuthorization(_ sender: Any) {
        
        DropboxClientsManager.authorizeFromController(UIApplication.shared,
                                                      controller: self,
                                                      openURL: { (url: URL) -> Void in
                                                        UIApplication.shared.openURL(url)
        })
    }
    
    // MARK: - root Folder
       @IBAction func getRootFolder (_ sender: Any) {
    
        let client = DropboxClientsManager.authorizedClient!
        
        client.files.listFolder(path: "").response(queue: DispatchQueue(label: "MyCustomSerialQueue")) { response, error in
            if let result = response {
                print(result)

               self.resultArray = result.entries
                self.performSegue(withIdentifier: "SegueToFolder", sender: self)
            }
        }
        
    }
 
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

            let vc = segue.destination as! TableController
            vc.title = "Root"
            vc.resultArray = resultArray
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

