//
//  Leave.swift
//  Test
//
//  Created by Rahul Sharma on 15/01/21.
//

import UIKit

/// Types of leave
enum LeaveType: CaseIterable {
   
    case SL
    case CL
    case PL
    case LWP
    
    var title: String  {
        switch self{
        case .PL:   return "PL"
        case .SL:   return "SL"
        case .CL:   return "CL"
        case .LWP:  return "LWP"
        }
    }
    
    var description: String  {
        switch self{
        case .PL:   return "Provisional Leave"
        case .SL:   return "Sick Leave"
        case .CL:   return "Casual Leave"
        case .LWP:  return "Leave Without Pay"
        }
    }
    
    var color: UIColor {
        switch self {
        case .PL:   return #colorLiteral(red: 0.8992241025, green: 0.4200568795, blue: 0.4824495316, alpha: 1)
        case .SL:   return #colorLiteral(red: 0.3175065815, green: 0.7187268734, blue: 0.006592974532, alpha: 1)
        case .CL:   return #colorLiteral(red: 0.9048511386, green: 0.8155738711, blue: 0.02685512975, alpha: 1)
        case .LWP:  return #colorLiteral(red: 0.8779388666, green: 0.01959828846, blue: 0.03717521578, alpha: 1)
        }
    }
    
    var value: Double {
        switch self{
        case .PL:   return 6.5
        case .SL:   return 7.0
        case .CL:   return 7.0
        case .LWP:  return 0.0
        }
    }
}

/// types of half day leave
enum  halfDayLeaveType {
    case full
    case firstHalf
    case secondHalf
}

/// types of day leave
enum dayLeaveType {
    case full
    case half
}

/// leave model
class Leave {
    var type = LeaveType.SL
    var totalDays = 1.0
    var startDate = Date()
    var endDate = Date()
    var leaveDays = [LeaveDay]()
    var reason = ""
    
    func reset(){
        type = LeaveType.SL
        totalDays = 1.0
        startDate = Date()
        endDate = Date()
        leaveDays.removeAll()
        reason = ""
    }
    
    
    ///To set leave days from start and end date
    func setLeaveDays(){
        let days = Date.dates(from: startDate, to: endDate)
        for day in days{
            let tempLeaveDay = leaveDays.filter {$0.date == day}
            if tempLeaveDay.count == 0 {
                leaveDays.append(LeaveDay(date: day, dayType: .full, halfDayType: .full))
            }
        }
        
        for (index,day) in leaveDays.enumerated().reversed(){
            if !days.contains(day.date){
                leaveDays.remove(at: index)
            }
        }
    }
    
    ///update leave type for perticular date
    func updateLeaveType(for date: Date, type: halfDayLeaveType){
        for day in leaveDays{
            if day.date == date{
                day.halfDayType = type
            }
        }
    }
    
    //Total days of leave calculation
    func calculateTotalLeaveDays(){
        var totalDays = 0.0
        for day in leaveDays{
            switch day.halfDayType {
            case .full:
                totalDays += 1
            case .firstHalf, .secondHalf:
                totalDays += 0.5
            }
        }
        self.totalDays = totalDays
    }
} 

/// used for leave model
class LeaveDay {
    var date = Date()
    var dayType = dayLeaveType.full
    var halfDayType = halfDayLeaveType.full
    
    init(date: Date, dayType: dayLeaveType, halfDayType: halfDayLeaveType) {
        self.date = date
        self.dayType = dayType
        self.halfDayType = halfDayType
    }
}
