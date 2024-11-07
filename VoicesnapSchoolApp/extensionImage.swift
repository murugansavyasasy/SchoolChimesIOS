//
//  extensionImage.swift
//  VoicesnapSchoolApp
//
//  Created by Shenll-Mac-04 on 12/07/17.
//  Copyright © 2017 Shenll-Mac-04. All rights reserved.
//

import Foundation
import UIKit
extension UIImageView
    
{
    
    func getURLString( urlString : String)
        
    {
        
        
        let url = NSURL(string: urlString)
        
        let session1 = URLSession.shared
        
        let dataTask = session1.dataTask(with: url as! URL, completionHandler:  {
            (data,response,error) -> Void  in
            
            
            
            
            DispatchQueue.main.async {
                
               // self.image =   UIImage(data: data!)
                
            }
            
            
            
            
            
        })
        
        dataTask.resume()
        
        
        
    }
    
    
}

