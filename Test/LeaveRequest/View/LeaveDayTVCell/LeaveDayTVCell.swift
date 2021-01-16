//
//  LeaveDayTVCell.swift
//  Test
//
//  Created by Rahul Sharma on 15/01/21.
//

import UIKit

class LeaveDayTVCell: UITableViewCell {

    ///progress views
    @IBOutlet weak var topProgressView: UIView!
    @IBOutlet weak var cirleProgressView: UIView!
    @IBOutlet weak var bottomProgressView: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var fullButton: UIButton!
    @IBOutlet weak var firstHalfButton: UIButton!
    @IBOutlet weak var secondHalfButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(leaveDay: LeaveDay){
        dateLabel.text = leaveDay.data.toString(dateFormat: AppConstants.dateFormat)
    }
    
}
