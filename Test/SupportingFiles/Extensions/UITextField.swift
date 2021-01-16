//
//  UITextField.swift
//  Test
//
//  Created by Rahul Sharma on 15/01/21.
//

import UIKit

extension UITextField {
    
    // for set padiing from both side
    func setPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    //for add right image
    func addRightImage(image: String, tintColor: UIColor? = nil) {
        let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        let rtImgView = UIImageView(image: UIImage(named: image))
        if let tintColor = tintColor{
            rtImgView.tintColor = tintColor
        }
        rtImgView.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
        rtImgView.contentMode = .scaleAspectFit
        mainView.addSubview(rtImgView)
        mainView.isUserInteractionEnabled = false
        self.rightView = mainView
        self.rightViewMode = .always
    }
}
