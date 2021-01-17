//
//  UIViewController.swift
//  Test
//
//  Created by Rahul Sharma on 17/01/21.
//

import UIKit

extension UIViewController{
    
    ///to show loader
    func startLoading(){
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    ///to hide loader
    func endLoading(){
        DispatchQueue.main.async {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    //Show Alert
     func showAlert(head:String, message:String ) {
        
        let alert = UIAlertController(title: head, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
}
