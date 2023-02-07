//
//  ViewController.swift
//  Upwork
//
//  Created by Đại Trần on 05/02/2023.
//

import UIKit
import CoreMotion
import Tracking

class ViewController: UIViewController {
    @IBOutlet weak var gyroscopeLabel: UILabel!
    @IBOutlet weak var accelerationLabel: UILabel!
    @IBOutlet weak var touchLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DeviceTracker.shared.delegate = self
    }
}

extension ViewController: DeviceTrackerDelegate {
    func trackDeviceGyroscope(data: CMGyroData) {
        gyroscopeLabel.text = String(format: "Gyroscope: x = %f, y = %f, z = %f", data.rotationRate.x, data.rotationRate.y, data.rotationRate.z)
    }
    
    func trackDeviceAcceleration(data: CMAcceleration) {
        accelerationLabel.text = String(format: "Acceleration: x = %f, y = %f, z = %f", data.x, data.y, data.z)
    }
    
    func trackTouch(data: CGPoint) {
        touchLabel.text = String(format: "Touch: x = %f, y = %f", data.x, data.y)
    }
}
