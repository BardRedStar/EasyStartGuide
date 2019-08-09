//
//  EasyStartGuideModels.swift
//  EasyStartGuide
//
//  Created by User on 05/08/2019.
//

import Foundation
import UIKit

/// An extension for holding model
public extension EasyStartGuide {
    
    /// Represents guide options
    enum GuideOption {
        
        /// Represents lesson dismiss modes
        public enum DismissMode {
            /// Dismisses the lesson only by click on lesson view
            case byClickOnGuide
            
            /// Dismisses the lesson by click anywhere
            case byClickAnywhere
        }
        
        /// Leson background color (doesn't work with custom view mode)
        case backgroundColor(UIColor)
        
        /// Lesson text color (doesn't work with custom view mode)
        case textColor(UIColor)
        
        /// Lesson view corner radius (can't be more than 13.0 and less than 0.0)
        case cornerRadius(CGFloat)
        
        /// Custom view option
        ///
        /// - Parameters:
        ///   - containerView: A main view for display
        ///   - label: A label in container view to display text at
        case customView(containerView: UIView, label: UILabel)
        
        /// Lesson view dismiss mode
        case dismissMode(DismissMode)
    }
    
    
    /// A struct for holding info about lesson instance
    struct GuideLesson {
        
        /// Represents the location of the lesson arrow pointer
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
        
        /// Represents the arrow direction of the lesson view
        public enum ArrowDirection {
            case up
            case left
            case down
            case right
            case any
            
            
            /// Gets the arrow direction in the popover notation
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
        
        /// Calculates the location point according to view
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
        
        /// - Parameters:
        ///   - view: The view to display the lesson at
        ///   - text: Text of the lesson
        ///   - location: Arrow pointer location
        ///   - arrowDirection: Permitted arrow direction
        public init(view: UIView, text: String, location: Location = .topLeft, arrowDirection: ArrowDirection = .any) {
            self.view = view
            self.text = text
            self.location = location
            self.arrowDirection = arrowDirection
        }
    }
    
}
