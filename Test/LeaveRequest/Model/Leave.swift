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
    
    var title: String {
        switch self {
        case .full: return "Full"
        case .firstHalf: return "1st Half"
        case .secondHalf: return "2nd Half"
        }
    }
}


/// leave model
class Leave {
    var type = LeaveType.SL
    var totalDays = 1.0
    var startDate = Date()
    var endDate = Date()
    var leaveDays = [LeaveDay]()
    var reason = ""
    var isSandwitch = false
    
    func reset(){
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
                leaveDays.append(LeaveDay(date: day, halfDayType: .full))
            }
        }
        
        for (index,day) in leaveDays.enumerated().reversed(){
            if !days.contains(day.date){
                leaveDays.remove(at: index)
            }
        }
        
        leaveDays = leaveDays.sorted(by: {$0.date.compare($1.date) == .orderedAscending })
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
        checkForHolidays()
    }
    
    ///exclude satDay, sunDay and public holidays
    func checkForHolidays(){
        for day in leaveDays{
            if day.date.dayofTheWeek == .sat ||  day.date.dayofTheWeek == .sun {
                totalDays -= day.halfDayType == .full ? 1 : 0.5
            }
        }
    }
    
    
    ///if leave day include Friday and next Monday - it will be considered as sandwhich leave
    ///considering 5 day working week
    func checkForSandwitchLeave(){
        var isHasSunday = false
        var isHasSatday = false
        for day in leaveDays{
            if day.date.dayofTheWeek == .sun {isHasSunday = true}
            if day.date.dayofTheWeek == .sat {isHasSatday = true}
        }
        if leaveDays.count > 2 && isHasSatday && isHasSunday {
            isSandwitch = true
        }
    }
    
    ///get array of leave days for API request
    func getLeaveDaysDataFromModel()-> [[String:String]]{
        var data = [[String:String]]()
        for day in leaveDays{
            data.append(day.getDataFromModel())
        }
        return data
    }
} 

/// used for leave model
class LeaveDay {
    var date = Date()
    var halfDayType = halfDayLeaveType.full
    
    init(date: Date, halfDayType: halfDayLeaveType) {
        self.date = date
        self.halfDayType = halfDayType
    }
    
    ///get data for model for API request
    func getDataFromModel() -> [String:String] {
        var data = [String:String]()
        data[ApiParams.date] = date.toString()
        data[ApiParams.dayType] = halfDayType == .full ? "Full" : "Half"
        data[ApiParams.halfDayType] = halfDayType.title
        return data
    }
}
