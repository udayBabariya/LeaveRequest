//
//  LeaveTypesCVCell.swift
//  Test
//
//  Created by Rahul Sharma on 15/01/21.
//

import UIKit

class LeaveTypesCVCell: UICollectionViewCell {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    
    ///initial setup for UI
    func setUI(){
        mainView.layer.borderWidth = 0.8
        mainView.layer.borderColor = UIColor.darkGray.cgColor
        
        textLabel.textColor = UIColor.lightGray
    }
    
    ///config method
    func configureCell(leaveType: LeaveType, isSelected: Bool){
        textLabel.text = leaveType.title
        
        if isSelected{
            mainView.backgroundColor = leaveType.color
            textLabel.textColor = .white
        }else{
            mainView.backgroundColor = .clear
            textLabel.textColor = .darkGray
        }
        DispatchQueue.main.async {
            self.mainView.layer.cornerRadius = self.mainView.frame.height/2
        }
       
    }

}
