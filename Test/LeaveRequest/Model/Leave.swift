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
    
} 

/// used for leave model
class LeaveDay {
    var data = Date()
    var dayType = dayLeaveType.full
    var halfDayType = halfDayLeaveType.full
}
