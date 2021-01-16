//
//  LeaveRequestViewController.swift
//  Test
//
//  Created by Rahul Sharma on 15/01/21.
//

import UIKit

class LeaveRequestViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var leaveTypeCollectionView: UICollectionView!
    @IBOutlet weak var leaveDaysTableView: UITableView!
    
    ///selected LeaveType
    @IBOutlet weak var selectedLeaveTypeLabel: UILabel!
    @IBOutlet weak var selectedLeaveTypeValueLabel: UILabel!
    @IBOutlet weak var slectedVeaveTypeView: UIView!
    
    @IBOutlet weak var startDateTextField: UITextField! //used for datePicker
    @IBOutlet weak var endDateTextField: UITextField!
    ///start Date
    @IBOutlet weak var startDateLabel: UILabel!
    
    ///end Date
    @IBOutlet weak var endDateLabel: UILabel!
    
    ///total leave day
    @IBOutlet weak var totalLeaveDaysLabel: UILabel!
        
    @IBOutlet weak var reasonTextView: UITextView!
    
    ///buttons
    @IBOutlet weak var requestButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    let viewModel = LeaveRequestLeaveModel()
    let datePicker = UIDatePicker()
    var activeTextField: UITextField?
    
    //MARK:- life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
    
    ///initial setup
    func setUp(){
        ///setup collectionView
        leaveTypeCollectionView.register(UINib(nibName: CellId.leaveTypesCVCell, bundle: nil), forCellWithReuseIdentifier:  CellId.leaveTypesCVCell)
        leaveTypeCollectionView.delegate = self
        leaveTypeCollectionView.dataSource = self
        
        ///setup tableView
        leaveDaysTableView.register(UINib(nibName: CellId.leaveDayTVCell, bundle: nil), forCellReuseIdentifier:  CellId.leaveDayTVCell)
        leaveDaysTableView.delegate = self
        leaveDaysTableView.dataSource = self
        
        ///reason textView
        reasonTextView.layer.cornerRadius = 5
        reasonTextView.setShadowWithColor(color: .black, opacity: 0.2, offset: CGSize(width: 1, height: 1), radius: 5, viewCornerRadius: 5)
        
        ///buttons
        requestButton.backgroundColor = Theme.appColor
        requestButton.setTitleColor(.white, for: .normal)
        requestButton.layer.cornerRadius = 5
        
        resetButton.backgroundColor = Theme.appColor
        resetButton.setTitleColor(.white, for: .normal)
        resetButton.layer.cornerRadius = 5
        
        startDateTextField.delegate = self
        endDateTextField.delegate = self
        
        setDatePicker()
    }
    
    private func setData(){
        leaveDaysTableView.reloadData()
        leaveTypeCollectionView.reloadData()
        
        selectedLeaveTypeLabel.text = viewModel.leave.type.description
        selectedLeaveTypeValueLabel.text = String(viewModel.leave.type.value)
        startDateLabel.text = viewModel.leave.startDate.toString()
        endDateLabel.text = viewModel.leave.endDate.toString()
        totalLeaveDaysLabel.text = String(viewModel.leave.totalDays)
        reasonTextView.text = viewModel.leave.reason
    }
    
    /// used for set values of selected Leave type
    func setDataAccordingLeaveType(){
        selectedLeaveTypeLabel.text = viewModel.leave.type.description
        selectedLeaveTypeValueLabel.text = String(viewModel.leave.type.value)
    }
    
    /// to set date tableView according to selected dates
    func setDatesView(){
        startDateLabel.text = viewModel.leave.startDate.toString()
        endDateLabel.text = viewModel.leave.endDate.toString()
    }
    
    //MARK:- Button Action
    @IBAction func requestButtonAction(_ sender: UIButton){
        
    }
    
    @IBAction func resetButtonAction(_ sender: UIButton){
        
        let alert = UIAlertController(title: StringConstants.areYouSure, message: "",         preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: StringConstants.no, style: .default, handler: { _ in
        }))
        alert.addAction(UIAlertAction(title: StringConstants.yes,
                                      style: .destructive,
                                      handler: {(_: UIAlertAction!) in
                                        self.viewModel.leave.reset()
                                        self.setData()
                                      }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func startDateButtonAction(_ sender: UIButton){
        activeTextField = startDateTextField
        startDateTextField.becomeFirstResponder()
    }
    
    @IBAction func endDateButtonAction(_ sender: UIButton){
        activeTextField = endDateTextField
        endDateTextField.becomeFirstResponder()
    }
}
