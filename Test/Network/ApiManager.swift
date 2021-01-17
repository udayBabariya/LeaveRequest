//
//  ApiManager.swift
//  Test
//
//  Created by Rahul Sharma on 15/01/21.
//

import Foundation

class ApiManager{
    //https://api.bnscolorama.co.uk/employee_leave_CL_SL_PL_LWP_Request_1.php
    static let baseUrl = "https://api.bnscolorama.co.uk/"
    
    //Endpoints
    static let leaveRequest = "employee_leave_CL_SL_PL_LWP_Request_1.php"
    
    
    
    
    /// POST Network request
    /// - Parameters:
    ///   - urlString: api url
    ///   - params: parameters
    ///   - completion: result
    func post(urlString: String , params: [String: Any], completion: @escaping (([String:Any]) -> Void)){
        

        guard let url = URL(string: urlString) else{
            return
        }
 
        URLSession.shared.dataTask(with: url) { (data, res, err) in

            guard let data = data else {
                print("empty data")
                  return
            }
            do{
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]{
                    completion(json)
                }
            }catch let error as NSError{
                print(error.localizedDescription)
            }
        }.resume()
    }
    
}
