//
//  LeaveRequest+DatePicker.swift
//  Test
//
//  Created by Rahul Sharma on 16/01/21.
//

import UIKit

extension LeaveRequestViewController{
    
    
    func setDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: StringConstants.done, style: .plain, target: self, action: #selector(donedatePicker));
        doneButton.tintColor = .darkGray
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: StringConstants.cancel, style: .plain, target: self, action: #selector(cancelDatePicker));
        cancelButton.tintColor = .darkGray
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        startDateTextField.inputAccessoryView = toolbar
        startDateTextField.inputView = datePicker
        
        endDateTextField.inputAccessoryView = toolbar
        endDateTextField.inputView = datePicker
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = AppConstants.dateFormat
        activeTextField?.text = formatter.string(from: datePicker.date)
        
        if activeTextField == startDateTextField{
            viewModel.leave.startDate = datePicker.date
        }else if activeTextField == endDateTextField{
            viewModel.leave.endDate = datePicker.date
        }
        activeTextField?.resignFirstResponder()
        activeTextField = nil
        setDatesView()
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
}
