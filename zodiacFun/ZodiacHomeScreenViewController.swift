//
//  ZodiacHomeScreenViewController.swift
//  zodiacFun
//
//  Created by C4Q on 12/11/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class ZodiacHomeScreenViewController: UIViewController  {
let defaults = UserDefaults.standard
let nameKey = "nameKey"
let dateKey = "dateKey"
var zodiacSign = ""
var zodiacDate = ""
var zodiacInfo: Horoscope?
    
    @IBOutlet weak var yesterdayButton: UIButton!
    
    @IBOutlet weak var todayButton: UIButton!
    
    @IBOutlet weak var tomorrowButton: UIButton!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var greetingLabel: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.defaults.value(forKey: nameKey) as? String == "" || self.defaults.value(forKey: nameKey) as? String == nil || self.defaults.value(forKey: dateKey) as? String == "" || self.defaults.value(forKey: dateKey) as? String == nil{
        greetingLabel.text = "Welcome User! Please Enter Info"
        textView.text = ""
            yesterdayButton.isHidden = true
            todayButton.isHidden = true
            tomorrowButton.isHidden = true
        }else{
            greetingLabel.text = "Welcome \(self.defaults.value(forKey: nameKey) as! String)! here is todays horoscope"
            yesterdayButton.isHidden = false
            todayButton.isHidden = false
            tomorrowButton.isHidden = false
            loadData()
        }
}
    
    override func viewWillAppear(_ animated: Bool) {
        if self.defaults.value(forKey: nameKey) as? String == "" || self.defaults.value(forKey: nameKey) as? String == nil || self.defaults.value(forKey: dateKey) as? String == "" || self.defaults.value(forKey: dateKey) as? String == nil{
            greetingLabel.text = "Welcome User! Please Enter Info"
            textView.text = ""
            yesterdayButton.isHidden = true
            todayButton.isHidden = true
            tomorrowButton.isHidden = true
        }else{
            greetingLabel.text = "Welcome \(self.defaults.value(forKey: nameKey) as! String)! here is todays horoscope"
            yesterdayButton.isHidden = false
            todayButton.isHidden = false
            tomorrowButton.isHidden = false
            loadData()
        }
    }
    
    
    func loadData(){
        self.findZodiacSign()
        let urlStr = "https://aztro.herokuapp.com?sign=\(zodiacSign)&day=\(zodiacDate)"
        let completion = {(onlineHoroscope: Horoscope) in
            self.zodiacInfo = onlineHoroscope
            self.todaysHoroscope()
        }
        let printErrors = {(error: Error) in
            print(error)
        }
        ZodiacAPIClient.manager.post(urlStr: urlStr, completionHandler: completion, errorHandler: printErrors)
    }
    
    func todaysHoroscope(){
    textView.text = zodiacInfo?.description
        
    }
    
    func findZodiacSign(){
        let date = defaults.value(forKey: dateKey) as? String
        let dateArr = date?.components(separatedBy: " ")
        let month = dateArr![0]
        let day = dateArr![1]
    
        switch month.lowercased(){
        case "january":
            switch Int(day)!{
            case 1...19:
                zodiacSign = "capricorn"
            default:
                zodiacSign = "aquarius"
            }
        
        case "february":
            switch Int(day)!{
            case 1...18:
                zodiacSign = "aquarius"
            default:
               zodiacSign = "pisces"
            }
            return
        case "march":
            switch Int(day)!{
            case 1...20:
                zodiacSign = "pisces"
            default:
                zodiacSign = "aries"
            }
            return
        case "april":
            switch Int(day)!{
            case 1...19:
                zodiacSign = "aries"
            default:
                zodiacSign = "taurus"
            }
            return
        case "may":
            switch Int(day)!{
            case 1...20:
                zodiacSign = "taurus"
            default:
                zodiacSign = "gemini"
            }
            return
        case "june":
            switch Int(day)!{
            case 1...20:
                zodiacSign = "gemini"
            default:
                zodiacSign = "cancer"
            }
            return
        case "july":
            switch Int(day)!{
            case 1...22:
                zodiacSign = "cancer"
            default:
                zodiacSign = "leo"
            }
            return
        case "august":
            switch Int(day)!{
            case 1...22:
                zodiacSign = "leo"
            default:
                zodiacSign = "virgo"
            }
            return
        case "september":
            switch Int(day)!{
            case 1...22:
                zodiacSign = "virgo"
            default:
                zodiacSign = "libra"
            }
            return
        case "october":
            switch Int(day)!{
            case 1...22:
                zodiacSign = "libra"
            default:
                zodiacSign = "scorpio"
            }
            return
        case "november":
            switch Int(day)!{
            case 1...23:
                zodiacSign = "scorpio"
            default:
                zodiacSign = "sagittarius"
            }
            return
        case "december":
            switch Int(day)!{
            case 1...21:
                zodiacSign = "sagittarius"
            default:
                zodiacSign = "capricorn"
            }
            
            
        default:
            print("month error")
        }
        
        
        
    }
   
    
    @IBAction func dateButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            zodiacDate = "yesterday"
            loadData()
        case 1:
            zodiacDate = "today"
            loadData()
        case 2:
            zodiacDate = "tomorrow"
            loadData()
        default:
            print("button error")
        }
    }
    
    
    
}
