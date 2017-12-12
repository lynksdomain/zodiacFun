//
//  ZodiacAPIClient.swift
//  zodiacFun
//
//  Created by C4Q on 12/11/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation
struct ZodiacAPIClient{
    private init() {}
    static let manager = ZodiacAPIClient()
    func post(urlStr: String, completionHandler: @escaping (Horoscope) -> Void, errorHandler: @escaping (Error) -> Void){
        
        guard let url = URL(string: urlStr) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        
        let completion: (Data) -> Void = {(data: Data) in
            do{
             let horoscope = try JSONDecoder().decode(Horoscope.self, from: data)
            completionHandler(horoscope)
                
            }catch{
                print(error)
                errorHandler(error)
            }
        }
        
        NetworkHelper.manager.performDataTask(with: request, completionHandler: completion, errorHandler: errorHandler)
    }
    
   
    
}

