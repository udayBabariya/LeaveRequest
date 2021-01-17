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
    @IBOutlet weak var heightConstraintTableView: NSLayoutConstraint!
    
    ///selected LeaveType
    @IBOutlet weak var selectedLeaveTypeLabel: UILabel!
    @IBOutlet weak var selectedLeaveTypeValueLabel: UILabel!
    @IBOutlet weak var slectedVeaveTypeView: UIView!
    
    ///start Date
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var startDateTextField: UITextField! //used for datePicker
    
    ///end Date
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var endDateTextField: UITextField! //used for datePicker
    
    ///total leave day
    @IBOutlet weak var totalLeaveDaysLabel: UILabel!
    
    ///reason
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
        viewModel.leave.setLeaveDays()
        setUp()
        setData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        deregisterFromKeyboardNotifications()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        UIView.animate(withDuration: 0.3) {
            self.heightConstraintTableView.constant = self.leaveDaysTableView.contentSize.height
        }
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
        reasonTextView.delegate = self
        
        ///buttons
        requestButton.backgroundColor = Theme.appColor
        requestButton.setTitleColor(.white, for: .normal)
        requestButton.layer.cornerRadius = 5
        
        resetButton.backgroundColor = Theme.appColor
        resetButton.setTitleColor(.white, for: .normal)
        resetButton.layer.cornerRadius = 5
        
        startDateTextField.delegate = self
        endDateTextField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        setDatePicker()
    }
    
    ///set Date information according to leave date selection
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
        resetLeaveDatesIfNeeded()
    }
    
    ///dismiss keyboard
    @objc func dismissKeyboard(){
        activeTextField = nil
        view.endEditing(true)
    }
    
    ///check leave dates according to leave type and update
    func resetLeaveDatesIfNeeded(){
        switch viewModel.leave.type{
        case .SL:
            //SL / CL must not selected for future date
            if viewModel.leave.endDate > Date(){
                self.viewModel.leave.reset()
                self.setData()
            }
        case .CL:
            //SL / CL must not selected for future date
            if viewModel.leave.endDate > Date(){
                self.viewModel.leave.reset()
                self.setData()
            }
        case .PL:
            //PL should be in future date
            if viewModel.leave.startDate <= Date(){
                self.viewModel.leave.reset()
                self.setData()
            }
        case .LWP:
            break
        }
    }
    
    /// to set date tableView according to selected dates
    func setDatesView(){
        viewModel.leave.setLeaveDays()
        viewModel.leave.calculateTotalLeaveDays()
        startDateLabel.text = viewModel.leave.startDate.toString()
        endDateLabel.text = viewModel.leave.endDate.toString()
        totalLeaveDaysLabel.text = String(viewModel.leave.totalDays)
        leaveDaysTableView.reloadData()
    }
    
    //MARK:- Button Action
    @IBAction func requestButtonAction(_ sender: UIButton){
        requestButton.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.requestButton.isEnabled = true
        }
        if viewModel.leave.reason.isEmpty{
            showAlert(head: StringConstants.oops, message: StringConstants.reasonEmpty)
            return
        }
        
        startLoading()
        viewModel.makeLeaveRequest {
            self.viewModel.leave.reset()
            self.setData()
            self.endLoading()
            print("Completed")
             
        }
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
