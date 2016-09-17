//
//  ViewController.swift
//  API Demo
//
//  Created by Lamar Greene on 9/17/16.
//  Copyright © 2016 Lamar Greene. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var forecastLabel: UILabel!
    
    @IBAction func submit(_ sender: UIButton) {
        
        if let cityName = cityTextField.text?.replacingOccurrences(of: " ", with: "-") {
            
            getForecast(cityName: cityName)
            
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.cityTextField.delegate = self
    }
    
    
    func getForecast(cityName: String) {
        
        
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(API_Key)")!
        
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
                            
                            DispatchQueue.main.sync(execute: {
                                
                                self.forecastLabel.text = description
                                
                            })
                            
                            
                        }
                        
                        
                    } catch {
                        
                        print(">>>>JSON processing failed")
                        
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


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        self.view.endEditing(true)
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        cityTextField.resignFirstResponder()
        
        return true
        
    }
    
    // Add to viewDidLoad -->> self.textField.delegate = self
    // Add UITextFieldDelegate to ViewController

}

