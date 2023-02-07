//
//  Extensions.swift
//  Tracking
//
//  Created by Đại Trần on 06/02/2023.
//

import UIKit
import AVFoundation

extension UIWindow {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let point = touches.first?.location(in: self)
        if point == DeviceTracker.shared.touchedPoint {
            return
        }
        DeviceTracker.shared.touchedPoint = point
    }
}

extension UIButton {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let point = touches.first?.location(in: self)
        if point == DeviceTracker.shared.touchedPoint {
            return
        }
        DeviceTracker.shared.touchedPoint = point
    }
}

extension UIView {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let window = window else {
            return
        }
        let point = touches.first?.location(in: window)
        if point == DeviceTracker.shared.touchedPoint {
            return
        }
        DeviceTracker.shared.touchedPoint = point
    }
}
