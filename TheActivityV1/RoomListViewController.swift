//
//  RoomListViewController.swift
//  TheActivityV1
//
//  Created by Georgius Yoga Dewantama on 18/09/19.
//  Copyright © 2019 Georgius Yoga Dewantama. All rights reserved.
//

import UIKit
import CoreLocation
import LocalAuthentication

class RoomListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var context = LAContext()
    
    enum AuthenticationState {
        case loggedIn, loggedOut
    }
    
    var state = AuthenticationState.loggedOut

    var rooms : [Room] = []
    
    var locationManager : CLLocationManager!
    
    var isSafeArea = false
    
    let room1 = Room(image: UIImage(named: "Collab5.png")!, roomName: "Collab - 05", currentPerson: 0, usedBy: "No One", rangeBeacon: "Unknown", directInfo: "Move closer to the Room", uuidRoom: "CB10023F-A318-3394-4199-A8730C7C1AEC", majorRoom: 222, minorRoom: 156)
    
    let room2 = Room(image: UIImage(named: "Collab7.png")!, roomName: "Collab - 07", currentPerson: 5, usedBy: "No One", rangeBeacon: "Unknown", directInfo: "Move closer to the Room", uuidRoom: "CB10023F-A318-3394-4199-A8730C7C1AEC", majorRoom: 222, minorRoom: 157)
    
    let room3 = Room(image: UIImage(named: "MeetingRoom.jpg")!, roomName: "Meeting Room", currentPerson: 0, usedBy: "No One", rangeBeacon: "Unknown", directInfo: "Move closer to the Room", uuidRoom: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5", majorRoom: 123, minorRoom: 456)

    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupLocationManager()
        rooms = createArray()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
        
    }
    
    func createArray() -> [Room] {
        
        var tempRoom : [Room] = []
        tempRoom.append(room1)
        tempRoom.append(room2)
        tempRoom.append(room3)
        
        return tempRoom
    }
    
    func setupLocationManager () {
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
    
    func doAuthentication () {
        //part 13
        context = LAContext()
        context.localizedCancelTitle = "Cancel"
        
        //part 9
        // First check if we have the needed hardware support.`
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
          
          let reason = "Log in to your account"
          context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason ) { success, error in
            if success {
              // Move to the main thread because a state update triggers UI changes.
              DispatchQueue.main.async { [unowned self] in
                self.state = .loggedIn
              }
            }
            else {
              print(error?.localizedDescription ?? "Can't evaluate policy")
            }
          }
        }
    }
    
    func validateRangeBeacon (room : Room) {
        if room.rangeBeacon.contains("far") || room.rangeBeacon.contains("unknown") || room.rangeBeacon.contains("Unknown") {
            isSafeArea = false
        }
        else {
            isSafeArea = true
        }
    }
    
    func showAlertForbidden() {
        let alert = UIAlertController(title: "You are too Far", message: "Move closer to the room that you want use", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Got it", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    func inputActivityName(room : Room) {
        let alert = UIAlertController(title: "Insert Name for Room", message: "to show your activity to others", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addTextField { (textField) in
            textField.placeholder = "Group Name / Activity"
          }
        alert.addAction(cancel)
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (action) in
            
            if let name = alert.textFields?.first?.text {
                room.usedBy = name
                print(name)
            }
        }))
        self.present(alert, animated: true)
        tableView.reloadData()
        }
    
    }


extension RoomListViewController : RoomViewCellDelegate {
    func didTapGetButton(room: Room) {
        validateRangeBeacon(room: room)
        if isSafeArea == true {
            doAuthentication()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.inputActivityName(room: room)
            }
        }
        else {
            showAlertForbidden()
        }
        print(room.currentPerson)
    }
}

extension RoomListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let room = rooms[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomCell") as! RoomViewCell
        
        cell.setRoom(room: room)
        cell.delegate = self
        
        return cell
    }
}
