//
//  LeaveRequest+CVExtension.swift
//  Test
//
//  Created by Rahul Sharma on 15/01/21.
//

import UIKit

//MARK:- CollectionView delegate,datasource, flowLayout
extension LeaveRequestViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return LeaveType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellId.leaveTypesCVCell, for: indexPath) as? LeaveTypesCVCell else {return LeaveTypesCVCell()}
        let leaveType = LeaveType.allCases[indexPath.item]
        cell.configureCell(leaveType: leaveType, isSelected: viewModel.leave.type == leaveType)
        cell.layoutIfNeeded()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width/4)-10, height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.leave.type =  LeaveType.allCases[indexPath.item]
        setDataAccordingLeaveType()
        collectionView.reloadData()
    }
    
    
}
