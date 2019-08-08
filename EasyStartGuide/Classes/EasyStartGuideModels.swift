//
//  EasyStartGuideModels.swift
//  EasyStartGuide
//
//  Created by User on 05/08/2019.
//

import Foundation
import UIKit

public extension EasyStartGuide {
    
    enum GuideOption {
        
        public enum DismissMode {
            case byClickOnGuide
            case byClickAnywhere
        }
        
        case backgroundColor(UIColor)
        case textColor(UIColor)
        case cornerRadius(CGFloat)
        case customView(UIView, UILabel)
        case dismissMode(DismissMode)
    }
    
    struct GuideLesson {
        
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
        
        public enum ArrowDirection {
            case up
            case left
            case down
            case right
            case any
            
            var value: UIPopoverArrowDirection {
                switch self {
                case .up: return .up
                case .down: return .down
                case .left: return .left
                case .right: return .right
                case .any: return .any
                }
            }
        }
        
        weak var view: UIView!
        var text: String
        var location: Location
        var arrowDirection: ArrowDirection
        
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
                return CGPoint(x: view.frame.size.width, y: view.frame.size.height/2)
            case .center:
                return CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/2)
            case .custom(let x, let y):
                return CGPoint(x: x, y: y)
            }
        }
        
        public init(view: UIView, text: String, location: Location = .topLeft, arrowDirection: ArrowDirection = .any) {
            self.view = view
            self.text = text
            self.location = location
            self.arrowDirection = arrowDirection
        }
    }
    
}
