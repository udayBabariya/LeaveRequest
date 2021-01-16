//
//  LeaveRequest+TVDelegate.swift
//  Test
//
//  Created by Rahul Sharma on 16/01/21.
//

import UIKit

//MARK:- UITextViewDelegate
extension LeaveRequestViewController: UITextViewDelegate{
    
    func textViewDidEndEditing(_ textView: UITextView) {
        viewModel.leave.reason = textView.text
    }
}
