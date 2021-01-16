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
        setup()
    }
    
    ///initial setup
    func setup(){
        cirleProgressView.layer.borderWidth = 2
        cirleProgressView.layer.borderColor = Theme.appColor.cgColor
        DispatchQueue.main.async {
            self.cirleProgressView.layer.cornerRadius = self.cirleProgressView.frame.width/2
        }
        
        
        topProgressView.backgroundColor = Theme.appColor
        bottomProgressView.backgroundColor = Theme.appColor
    }
    
    func configureCell(leaveDay: LeaveDay){
        dateLabel.text = leaveDay.data.toString(dateFormat: AppConstants.dateFormat)
    }
    
}
