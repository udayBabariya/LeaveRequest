//
//  LeaveRequest+TFExtension.swift
//  Test
//
//  Created by Rahul Sharma on 16/01/21.
//

import UIKit

extension LeaveRequestViewController: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == startDateTextField{
            datePicker.date = viewModel.leave.startDate
            setDatePickerAvailability(isStartDate: true)
        }else if textField == endDateTextField{
            datePicker.date = viewModel.leave.endDate
            setDatePickerAvailability(isStartDate: false)
        }
    }
    
    /// set date picker's min/max days according to leave type
    /// - Parameter isStartDate: true if used for start date
    func setDatePickerAvailability(isStartDate: Bool){
        switch viewModel.leave.type{
        case .SL,.CL:
            //SL / CL must not selected for future date
            if isStartDate{
                datePicker.minimumDate = Date().adding(days: -365)
                datePicker.maximumDate = Date()
            }else{
                datePicker.minimumDate = viewModel.leave.startDate
                datePicker.maximumDate = Date()
            }
        case .PL:
            // PL should be in future date
            if isStartDate{
                datePicker.minimumDate = Date().adding(days: 1)
                datePicker.maximumDate = Date().adding(days: 365)
            }else{
                datePicker.minimumDate = viewModel.leave.startDate
                datePicker.maximumDate = Date()
            }
        case .LWP:
            //any date
            if isStartDate{
                datePicker.minimumDate = Date().adding(days: -365)
                datePicker.maximumDate = Date().adding(days: 365)
            }else{
                datePicker.minimumDate = viewModel.leave.startDate
                datePicker.maximumDate = Date()
            }
        }
    }
}
