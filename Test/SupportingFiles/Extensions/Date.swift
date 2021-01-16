//
//  Date.swift
//  Test
//
//  Created by Rahul Sharma on 15/01/21.
//

import Foundation

extension Date{
    
    /// convert date to requred string format
    /// - Parameter format: requred date format
    /// - Returns: string date
    func toString( dateFormat format  : String = AppConstants.dateFormat ) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
