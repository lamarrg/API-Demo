//
//  ViewController.swift
//  API Demo
//
//  Created by Lamar Greene on 9/17/16.
//  Copyright © 2016 Lamar Greene. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=Denver&appid=\(API_Key)")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
            
                print(error)
            
            } else {
            
                if let urlContent = data {
                    
                    do {
                    
                    let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                
                    print(jsonResult)
                        
                        // to get name element only
                        print(jsonResult["name"])
                        
                        if let description = (((jsonResult as? NSDictionary)?["weather"] as? NSArray)?[0] as? NSDictionary)?["description"] as? String {
                            
                            print(description)
                            
                        }
                        
                        
                    } catch {
                    
                        print("JSON processing failed")
                    
                    }
                    
                }
                
            }
            
        }
        
        task.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

