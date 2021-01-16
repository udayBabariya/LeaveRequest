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
    
    
    
    
    func post(urlString: String , params: [String: Any], completion: @escaping ((AnyObject) -> Void)){
        

        guard let url = URL(string: urlString) else{
            return
        }
 
        URLSession.shared.dataTask(with: url) { (data, res, err) in

            guard let data = data else {
                  return
            }

//            do {
//                let json = try JSONDecoder().decode(Leave.self, from: data)
//                self.info = json
//                completion(info)
//            } catch {
//                print("didnt work")
//            }

        }.resume()
    }
    
}
