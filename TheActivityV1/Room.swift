//
//  Room.swift
//  TheActivityV1
//
//  Created by Georgius Yoga Dewantama on 18/09/19.
//  Copyright © 2019 Georgius Yoga Dewantama. All rights reserved.
//

import Foundation
import UIKit

class Room {
    
    var image : UIImage
    var roomName : String
    var currentPerson : Int
    var usedBy : String
    var rangeBeacon : String
    var directInfo : String
    var uuidRoom : String
    var majorRoom : NSNumber
    var minorRoom : NSNumber
    
    
    init(image : UIImage, roomName : String, currentPerson : Int, usedBy : String, rangeBeacon : String, directInfo : String, uuidRoom : String,majorRoom : NSNumber, minorRoom : NSNumber) {
        self.image = image
        self.roomName = roomName
        self.currentPerson = currentPerson
        self.usedBy = usedBy
        self.rangeBeacon = rangeBeacon
        self.directInfo = directInfo
        self.uuidRoom = uuidRoom
        self.majorRoom = majorRoom
        self.minorRoom = minorRoom
    }
    
}
