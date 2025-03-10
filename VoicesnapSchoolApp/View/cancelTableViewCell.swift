//
//  cancelTableViewCell.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 03/07/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import UIKit

protocol sloSlectionDataDelegate {
    func getSelectedSlot(selectedIndexPath:[AvailableSlot]?)
}
class cancelTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var cv: UICollectionView!
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var frontView: UIView!
    @IBOutlet weak var holeview: UIViewX!
    @IBOutlet weak var lineview: UIViewX!
    var identifier = "TimeCollectionViewCell"
    var getTeacherData : [GetTeacherwiseSlotAvailabilityData] = []
    var events : [Event] = []
    let dateFormatter = DateFormatter()

    var expandType = "1"
    var CustomOrange = "CustomOrange"
    var sloSlectionDataDelegate: sloSlectionDataDelegate?
    var selectedIndex:Int?
    var availableSlots:[AvailableSlot] = []
    var availableSlot:[SlotTime] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cv.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
        dateFormatter.dateFormat = "hh:mm a"
        cv.delegate = self
        cv.dataSource = self
    }

    func configure1(with slots: [AvailableSlot], selectedIndex: Int) {
        self.availableSlots = slots
        self.availableSlot = slots[selectedIndex].slots
        self.selectedIndex = selectedIndex
        cv.reloadData()
    }

    // MARK: - CollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return availableSlot.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! TimeCollectionViewCell

        let slotTime = availableSlot[indexPath.item]
        cell.timelbl.text = slotTime.time

        // Background color logic based on `select` value
        switch slotTime.select {
        case 0:
            cell.timeHoleView.backgroundColor = .white    // Not selected
            cell.isUserInteractionEnabled = true
        case 1:
            cell.timeHoleView.backgroundColor = .systemOrange  // Selected slot
            cell.isUserInteractionEnabled = true
        case 2:
            cell.timeHoleView.backgroundColor = .systemGray5 // Overlapping slot
            cell.isUserInteractionEnabled = false           // Disable interaction for overlapping slots
        default:
            cell.timeHoleView.backgroundColor = .white      // Default to white in case of unexpected values
            cell.isUserInteractionEnabled = true
        }
        if indexPath.item == availableSlot.count - 1 {  // Update height after last cell loads
            DispatchQueue.main.async {
                self.collectionViewHeight.constant = collectionView.collectionViewLayout.collectionViewContentSize.height
                self.layoutIfNeeded() // Refresh layout
            }
        }
            
        return cell
    }

    // MARK: - CollectionView Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 50)
    }

    // MARK: - CollectionView Selection Logic
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        // Step 1: Reset previous selection within the SAME collection view
        for i in 0..<availableSlot.count {
            if availableSlot[i].select == 1 {
                availableSlot[i].select = 0 // Clear previous selection
            }
        }

        // Step 2: Mark the newly selected slot as 1
        availableSlot[indexPath.row].select = 1

        // Step 3: Get selected time range
        let selectedSlot = availableSlot[indexPath.row]
        let selectedTimeRange = selectedSlot.time.components(separatedBy: " - ")

        guard let selectedFrom = convertToDate(selectedTimeRange.first ?? ""),
              let selectedTo = convertToDate(selectedTimeRange.last ?? "") else {
            return
        }

        // Step 4: Detect and mark overlapping slots in ENTIRE availableSlots array
        for (sectionIndex, slots) in availableSlots.enumerated() {
            for (rowIndex, slot) in slots.slots.enumerated() {
                let slotTimeRange = slot.time.components(separatedBy: " - ")

                guard let slotFrom = convertToDate(slotTimeRange.first ?? ""),
                      let slotTo = convertToDate(slotTimeRange.last ?? "") else {
                    continue
                }

                // Skip marking the selected slot itself
                if slot.time == selectedSlot.time {
                    continue
                }

                // Overlapping condition
                if (slotFrom < selectedTo) && (slotTo > selectedFrom) {
                    if availableSlots[sectionIndex].isBooked != true{
                        availableSlots[sectionIndex].isBooked = false
                        availableSlots[sectionIndex].slots[rowIndex].select = 2
                    }else{
                        availableSlots[sectionIndex].isBooked = true
                    }
                } else if availableSlots[sectionIndex].slots[rowIndex].select == 2 {
                    availableSlots[sectionIndex].slots[rowIndex].select = 0
                }
            }
        }

        // Step 5: Update the specific index in `availableSlots`
        if let index = selectedIndex {
            if index < availableSlots.count {
                availableSlots[index] = AvailableSlot(id: index, isBooked: availableSlots[index].isBooked, slots: availableSlot)
            }
        }

        // Step 6: Inform delegate and update UI
        sloSlectionDataDelegate?.getSelectedSlot(selectedIndexPath: availableSlots)
    }
    
    // Convert Time String to Date
    func convertToDate(_ timeString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.date(from: timeString)
    }
    

    
}

class timeclick : UITapGestureRecognizer{
    
    var sloId : Int!
    var fromtime : String!
    var toTime : String!
    var idGet : Int!
    var dateGet : String!
    var fromToTime : String!
}
