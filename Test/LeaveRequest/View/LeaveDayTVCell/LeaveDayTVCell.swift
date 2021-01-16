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
        
        fullButton.layer.borderColor = UIColor.darkGray.cgColor
        fullButton.layer.borderWidth = 0.8
        
        firstHalfButton.layer.borderColor = UIColor.darkGray.cgColor
        firstHalfButton.layer.borderWidth = 0.8
        
        secondHalfButton.layer.borderColor = UIColor.darkGray.cgColor
        secondHalfButton.layer.borderWidth = 0.8
        
        DispatchQueue.main.async {
            self.cirleProgressView.layer.cornerRadius = self.cirleProgressView.frame.width/2
            self.fullButton.layer.cornerRadius = self.fullButton.frame.height/2
            self.firstHalfButton.layer.cornerRadius = self.firstHalfButton.frame.height/2
            self.secondHalfButton.layer.cornerRadius = self.secondHalfButton.frame.height/2
        }
        
        
        topProgressView.backgroundColor = Theme.appColor
        bottomProgressView.backgroundColor = Theme.appColor
    }
    
    func configureCell(leaveDay: LeaveDay){
        dateLabel.text = leaveDay.data.toString(dateFormat: AppConstants.dateFormat)
        setSingleDayUI()
    }
    
    
    /// to set ui for single day of leave
    func setSingleDayUI(){
        topProgressView.isHidden = true
        bottomProgressView.isHidden = true
        cirleProgressView.isHidden = false
    }
    
    /// to set ui for first day of leave
    func setStartDayUI(){
        topProgressView.isHidden = true
        bottomProgressView.isHidden = false
        cirleProgressView.isHidden = false
    }
    
    /// to set ui for last day of leave
    func setEndDayUI(){
        topProgressView.isHidden = false
        bottomProgressView.isHidden = true
        cirleProgressView.isHidden = false
    }
    
}
