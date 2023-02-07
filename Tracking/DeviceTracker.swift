//
//  DeviceTracker.swift
//  Tracking
//
//  Created by Đại Trần on 06/02/2023.
//

import UIKit
import CoreMotion

public protocol DeviceTrackerDelegate: AnyObject {
    func trackDeviceAcceleration(data: CMAcceleration)
    func trackDeviceGyroscope(data: CMGyroData)
    func trackTouch(data: CGPoint)
}

public final class DeviceTracker {
    private let motionManager = CMMotionManager()
    var touchedPoint: CGPoint? {
        didSet {
            guard let point = touchedPoint else {
                return
            }
            delegate?.trackTouch(data: point)
        }
    }
    
    public static let shared = DeviceTracker()
    public weak var delegate: DeviceTrackerDelegate? {
        didSet {
            guard let _ = delegate else {
                return
            }
            startMonitorDevice()
        }
    }
    
    private func startMonitorDevice() {
        guard motionManager.isDeviceMotionAvailable, motionManager.isGyroAvailable else {
            return
        }
        
        motionManager.gyroUpdateInterval = 1.0
        motionManager.startGyroUpdates()
        
        motionManager.deviceMotionUpdateInterval = 1.0
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] (deviceMotion, error) in
            guard let deviceMotion = deviceMotion else {
                return
            }
            
            let acceleration = deviceMotion.userAcceleration
            self?.delegate?.trackDeviceAcceleration(data: acceleration)
            
            guard let gyroData = self?.motionManager.gyroData else {
                return
            }
            self?.delegate?.trackDeviceGyroscope(data: gyroData)
        }
    }
    
    private func stopMonitorDevice() {
        motionManager.stopDeviceMotionUpdates()
        motionManager.stopGyroUpdates()
    }
}
