//
//  LeaveRequestViewModel.swift
//  Test
//
//  Created by Rahul Sharma on 15/01/21.
//

import Foundation

class LeaveRequestLeaveModel{
    
    var leave = Leave()
    
    func makeLeaveRequest(success: @escaping ()-> ()){
        var params = [String: Any]()
        
        params[ApiParams.employeeId] = AppConstants.employeeId
        params[ApiParams.firstName] = AppConstants.firstName
        params[ApiParams.lastName] = AppConstants.lastName
        params[ApiParams.employeeCode] = AppConstants.employeeCode
        params[ApiParams.companyId] = AppConstants.companyId
        params[ApiParams.startDate] = leave.startDate.toString()
        params[ApiParams.endDate]   = leave.endDate.toString()
        params[ApiParams.reason]    = leave.reason
        params[ApiParams.leaveType] = leave.type.title
        params[ApiParams.leaveDays] = leave.getLeaveDaysDataFromModel()
         
        print(String(data: try! JSONSerialization.data(withJSONObject: params, options: .prettyPrinted), encoding: .utf8 )!)
        //todo - show loader
        ApiManager().post(urlString: ApiManager.baseUrl + ApiManager.leaveRequest, params: params) { response in
            //todo - hide loader
            print(response)
            //todo - json parsing
            success()
        }
    }
}
