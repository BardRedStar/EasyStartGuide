//
//  EasyStartGuideModels.swift
//  EasyStartGuide
//
//  Created by User on 05/08/2019.
//

import Foundation
import UIKit

public struct GuideLesson {
    
    public enum Location {
        case topCenter
        case bottomCenter
        case leftCenter
        case rightCenter
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
        case center
        case custom(x: CGFloat, y: CGFloat)
    }
    
    
    weak var view: UIView!
    var text: String
    var location: Location
    
    var point: CGPoint {
        switch location {
        case .topLeft:
            return CGPoint.zero
        case .bottomRight:
            return CGPoint(x: view.frame.size.width, y: view.frame.size.height)
        case .topRight:
            return CGPoint(x: view.frame.size.width, y: 0.0)
        case .bottomLeft:
            return CGPoint(x: 0.0, y: view.frame.size.height)
        case .topCenter:
            return CGPoint(x: view.frame.size.width/2, y: 0.0)
        case .bottomCenter:
            return CGPoint(x: view.frame.size.width/2, y: view.frame.size.height)
        case .leftCenter:
            return CGPoint(x: 0.0, y: view.frame.size.height/2)
        case .rightCenter:
            return CGPoint(x: view.frame.size.width, y: 0.0)
        case .center:
            return CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/2)
        case .custom(let x, let y):
            return CGPoint(x: x, y: y)
        }
    }
    
    public init(view: UIView, text: String, location: Location = .topLeft) {
        self.view = view
        self.text = text
        self.location = location
    }
}
