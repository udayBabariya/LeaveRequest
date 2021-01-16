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
    
    
    /// get date arrye between from and to
    /// - Parameters:
    ///   - fromDate: start date
    ///   - toDate: end date
    /// - Returns: arre of dates
    static func dates(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate
        
        while date <= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }
    
    /// add or subtract days from date
    /// - Parameter days: no of days
    /// - Returns: days wit add/subtract required days
    func adding(days: Int)-> Date{
        return Calendar.current.date(byAdding: .day, value: days, to: self)!
    }
    
}
