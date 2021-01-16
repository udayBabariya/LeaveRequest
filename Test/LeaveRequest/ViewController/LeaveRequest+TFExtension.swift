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
        }else if textField == endDateTextField{
            datePicker.date = viewModel.leave.endDate
        }
    }
}
