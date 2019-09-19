//
//  RoomViewCell.swift
//  TheActivityV1
//
//  Created by Georgius Yoga Dewantama on 18/09/19.
//  Copyright © 2019 Georgius Yoga Dewantama. All rights reserved.
//

import UIKit
protocol RoomViewCellDelegate {
    func didTapGetButton (room : Room)
}

class RoomViewCell: UITableViewCell {

    @IBOutlet weak var roomImageView: UIImageView!
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var currentPersonLabel: UILabel!
    @IBOutlet weak var usedByLabel: UILabel!
    @IBOutlet weak var rangeBeaconLabel: UILabel!
    @IBOutlet weak var directInfoLabel: UILabel!
    @IBOutlet weak var getRoomButton: UIButton!
    
    var delegate : RoomViewCellDelegate?
    var roomItem : Room!
    
    
    func setRoom(room : Room) {
        
        roomItem = room
        roomImageView.image = room.image
        roomNameLabel.text = room.roomName
        currentPersonLabel.text = "Current Person : \(String(room.currentPerson))"
        usedByLabel.text = "Used by : \(room.usedBy)"
        rangeBeaconLabel.text = "\(room.rangeBeacon) from you"
        directInfoLabel.text = room.directInfo
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        getRoomButton.setBackgroundImage(UIImage(named: "ButtonGetActive"), for: .normal)
    }
    
    
    @IBAction func getButtonTapped(_ sender: UIButton) {
        delegate?.didTapGetButton(room: roomItem)
//        if getRoomButton.currentBackgroundImage == UIImage(named: "ButtonGetActive"){
//            getRoomButton.setBackgroundImage(UIImage(named: "ButtonUsedInactive"), for: .normal)
//        }
//        else {
//            getRoomButton.setBackgroundImage(UIImage(named: "ButtonGetActive"), for: .normal)
//        }
        doHaptic()
    }

}

extension RoomViewCell {
    func doHaptic () {
    let feedback = UIImpactFeedbackGenerator(style: .medium)
    feedback.impactOccurred()
    }
}


