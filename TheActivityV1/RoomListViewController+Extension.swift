//
//  RoomListViewController+Extension.swift
//  TheActivityV1
//
//  Created by Georgius Yoga Dewantama on 19/09/19.
//  Copyright © 2019 Georgius Yoga Dewantama. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

extension RoomListViewController : CLLocationManagerDelegate {
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    for room in rooms {
                        startScanning(room)
                    }
                }
            }
        }
    }
    
    func startScanning(_ room : Room) {
        
        guard let uuid = UUID(uuidString: room.uuidRoom) else { return }
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: CLBeaconMajorValue(truncating: room.majorRoom), minor: CLBeaconMinorValue(truncating: room.minorRoom), identifier: room.roomName)
        
        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(in: beaconRegion)
    }
    // masih bingung untuk menyimpan semua hasilnya
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        
        findMatchBeacon(beacons: beacons)
    }
    
    func findMatchBeacon (beacons : [CLBeacon]) {
        
//        let uuidRoom1 = UUID(uuidString: room1.uuidRoom)
//        let uuidRoom2 = UUID(uuidString: room2.uuidRoom)
//        let uuidRoom3 = UUID(uuidString: room3.uuidRoom)
        
        for beacon in beacons {
            
            let distance : String
            
            if beacon.minor == room1.minorRoom {
               distance = updateDIstance(beacon.proximity)
                print("\(room1.roomName) have \(distance) from you")
                room1.rangeBeacon = distance
            }
            else if beacon.minor == room2.minorRoom {
                distance = updateDIstance(beacon.proximity)
                print("\(room2.roomName) have \(distance) from you ")
                room2.rangeBeacon = distance
            }
            else if beacon.minor == room3.minorRoom {
              distance = updateDIstance(beacon.proximity)
                 print("\(room3.roomName) have \(distance) from you")
                room3.rangeBeacon = distance
            }
        }
        
        tableView.reloadData()
    }
    
    func updateDIstance (_ distance : CLProximity) -> String{
        
        switch distance {
        case .far:
            return "far"
        case .near:
            return "near"
        case .unknown:
            return "unknown"
        case .immediate:
            return "immediate"
        @unknown default:
            return "error"
        }
    }
    
    func calculateDistance (rssi : Int) -> Int{
        
        let measuredPower = -69
        let N = 2
        let distance = 10 ^ ((measuredPower - rssi) / 10 * N)
        let result = abs(distance)
        return result
    }
    
    func doHaptic () {
           let feedback = UIImpactFeedbackGenerator(style: .medium)
           feedback.impactOccurred()
       }
}



   
