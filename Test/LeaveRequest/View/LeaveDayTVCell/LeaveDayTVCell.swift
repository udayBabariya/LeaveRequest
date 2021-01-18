//
//  LeaveDayTVCell.swift
//  Test
//
//  Created by Rahul Sharma on 15/01/21.
//

import UIKit

protocol leaveDayTVCellDelegate{
    func updateLeaveType(type:halfDayLeaveType, forDay: Date)
}

class LeaveDayTVCell: UITableViewCell {

    ///progress views
    @IBOutlet weak var topProgressView: UIView!
    @IBOutlet weak var cirleProgressView: UIView!
    @IBOutlet weak var bottomProgressView: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var fullButton: UIButton!
    @IBOutlet weak var firstHalfButton: UIButton!
    @IBOutlet weak var secondHalfButton: UIButton!
    
    @IBOutlet weak var holidayView: UIView!
    @IBOutlet weak var weekDayLabel: UILabel!
    
    var delegate: leaveDayTVCellDelegate?
    private var date = Date()
    
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
            self.fullButton.layer.cornerRadius = self.fullButton.frame.height/2
            self.firstHalfButton.layer.cornerRadius = self.firstHalfButton.frame.height/2
            self.secondHalfButton.layer.cornerRadius = self.secondHalfButton.frame.height/2
        }
        
        topProgressView.backgroundColor = Theme.appColor
        bottomProgressView.backgroundColor = Theme.appColor
        holidayView.isHidden = true
        weekDayLabel.text = ""
        resetAllButtonsUI()
    }
    
    ///Restet all buttons UI
    func resetAllButtonsUI(){
        fullButton.backgroundColor = .white
        firstHalfButton.backgroundColor = .white
        secondHalfButton.backgroundColor = .white
        
        fullButton.setTitleColor(.darkGray, for: .normal)
        firstHalfButton.setTitleColor(.darkGray, for: .normal)
        secondHalfButton.setTitleColor(.darkGray, for: .normal)
        
        fullButton.layer.borderColor = UIColor.darkGray.cgColor
        firstHalfButton.layer.borderColor = UIColor.darkGray.cgColor
        secondHalfButton.layer.borderColor = UIColor.darkGray.cgColor
        
        fullButton.layer.borderWidth = 0.8
        firstHalfButton.layer.borderWidth = 0.8
        secondHalfButton.layer.borderWidth = 0.8
    }
    
    ///cell configuration
    func configureCell(leaveDay: LeaveDay){
        date = leaveDay.date
        dateLabel.text = date.toString()
        setSingleDayUI()
        resetAllButtonsUI()
        switch leaveDay.halfDayType{
        case .full:
            fullButton.backgroundColor = Theme.appColor
            fullButton.setTitleColor(.white, for: .normal)
            fullButton.layer.borderColor = UIColor.clear.cgColor
        case .firstHalf:
            firstHalfButton.backgroundColor = Theme.appColor
            firstHalfButton.setTitleColor(.white, for: .normal)
            firstHalfButton.layer.borderColor = UIColor.clear.cgColor
        case .secondHalf:
            secondHalfButton.backgroundColor = Theme.appColor
            secondHalfButton.setTitleColor(.white, for: .normal)
            secondHalfButton.layer.borderColor = UIColor.clear.cgColor
        }
        
        if leaveDay.date.dayofTheWeek == .sat || leaveDay.date.dayofTheWeek == .sun{
            holidayView.isHidden = false
            weekDayLabel.text = leaveDay.date.dayofTheWeek.title
        }else{
            holidayView.isHidden = true
            weekDayLabel.text = ""
        }
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
    
    /// to set ui for mid day of leave
    func setMiddleDayUI(){
        topProgressView.isHidden = false
        bottomProgressView.isHidden = false
        cirleProgressView.isHidden = false
    }
    
    
    @IBAction func fullButtonAction(_ sender: UIButton){
        delegate?.updateLeaveType(type: .full, forDay: date)
    }
    
    @IBAction func firsthalfButtonAction(_ sender: UIButton){
        delegate?.updateLeaveType(type: .firstHalf, forDay: date)
    }
    
    @IBAction func secondHalfButtonAction(_ sender: UIButton){
        delegate?.updateLeaveType(type: .secondHalf, forDay: date)
    }
    
    
     
}
