//
//  LeaveRequest+TVExtention.swift
//  Test
//
//  Created by Rahul Sharma on 15/01/21.
//

import UIKit

//MARK:- TableView Delegate, DataSource
extension LeaveRequestViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.leave.leaveDays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellId.leaveDayTVCell) as? LeaveDayTVCell else {return LeaveDayTVCell()}
        let leaveDay = viewModel.leave.leaveDays[indexPath.row]
        cell.configureCell(leaveDay: leaveDay)
        cell.delegate = self
        
        ///cell progress bar dot conntion logic
        if indexPath.row == 0 && viewModel.leave.leaveDays.count > 1{
            cell.setStartDayUI()
        }else if indexPath.row == viewModel.leave.leaveDays.count - 1 && viewModel.leave.leaveDays.count > 1{
            cell.setEndDayUI()
        }else if viewModel.leave.leaveDays.count > 1{
            cell.setMiddleDayUI()
        }
        return cell
    }
    
    
}

//MARK:- leaveDayTVCellDelegate
extension LeaveRequestViewController:  leaveDayTVCellDelegate {
    func updateLeaveType(type: halfDayLeaveType, forDay : Date) {
        viewModel.leave.updateLeaveType(for: forDay, type: type)
        setDatesView()
    }
}
