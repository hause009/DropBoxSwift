//
//  File.swift
//  DropBoxSwift
//
//  Created by Alex on 20.02.17.
//  Copyright © 2017 AnsA. All rights reserved.
//

import Foundation
import SwiftyDropbox

class File {
     //var resultArray = Array<Files.Metadata>()
    
    
    func requstApi (stringPathLower:String)-> Array<Files.Metadata> {
        
        var resultArray = Array<Files.Metadata>()
        //let dict = resultArray[0]
        
        let client = DropboxClientsManager.authorizedClient!
        //dict.pathLower!
        client.files.listFolder(path: stringPathLower).response(queue: DispatchQueue(label: "MyCustomSerialQueue")) { response, error in
            if let result = response {
                print(result)
                
                //let
                resultArray = result.entries
                
            }
        }
        return resultArray
    }

    }
