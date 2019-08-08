//
//  PopoverViewController.swift
//  TestApp
//
//  Created by User on 19/07/2019.
//  Copyright © 2019 me. All rights reserved.
//

import Foundation
import UIKit

/// A class for making a popover hint view
public class LessonPopoverViewController: UIViewController {
    private var lessonTextLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 150))
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = UIColor.white
        label.lineBreakMode = .byClipping
        label.numberOfLines = 0
        return label
    }()
    
    private var completionHandler: (() -> Void)?
    
    private var dismissMode: EasyStartGuide.GuideOption.DismissMode!
    private var cornerRadius: CGFloat!
    private weak var customView: UIView?
    private weak var customLabel: UILabel?
    
    required init(hintText: String, sourceView: UIView, sourceRect: CGRect, arrowDirection: UIPopoverArrowDirection,
                  options: [EasyStartGuide.GuideOption], completion: (() -> Void)?) {
        super.init(nibName: nil, bundle: nil)
        
        modalPresentationStyle = .popover
        
        configureView(text: hintText, options: options)
        popoverPresentationController?.delegate = self
        popoverPresentationController!.sourceView = sourceView
        popoverPresentationController!.sourceRect = sourceRect
        popoverPresentationController!.permittedArrowDirections = arrowDirection
        
        completionHandler = completion
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewDidClick(_:)))
        view.addGestureRecognizer(tap)
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.superview?.superview?.layer.cornerRadius = cornerRadius
        view.superview?.layer.cornerRadius = cornerRadius
        view.layer.cornerRadius = cornerRadius
    }
    
    private func configureView(text: String, options: [EasyStartGuide.GuideOption]) {
        
        options.forEach { (option) in
            switch option {
            case .backgroundColor(let color):
                popoverPresentationController?.backgroundColor = color
            case .textColor(let color):
                lessonTextLabel.textColor = color
            case .cornerRadius(let radius):
                print("corner radius \(radius)")
                cornerRadius = radius
            case .dismissMode(let mode):
                dismissMode = mode
            case .customView(let view, let label):
                customView = view
                customLabel = label
                popoverPresentationController?.backgroundColor = customView!.backgroundColor
            }
        }
        
        if customView != nil, customLabel != nil {
            view.addSubview(customView!)
            customLabel!.text = text
            customLabel!.sizeToFit()
        } else {
            lessonTextLabel.text = text
            lessonTextLabel.sizeToFit()
            view.addSubview(lessonTextLabel)
            addConstraintsToLabel()
        }
        
        view.contentMode = .scaleToFill
        view.frame.size = preferredContentSize
        view.layoutSubviews()
    }
    
    private func addConstraintsToLabel() {
        lessonTextLabel.translatesAutoresizingMaskIntoConstraints = false
        let trailingConstraint = lessonTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        trailingConstraint.priority = UILayoutPriority(999)
        let bottomConstraint = lessonTextLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        bottomConstraint.priority = UILayoutPriority(999)
        NSLayoutConstraint.activate([lessonTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                                     lessonTextLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
                                     trailingConstraint,
                                     bottomConstraint])
    }
    
    public override var preferredContentSize: CGSize {
        get {
            if presentingViewController != nil {
                if customView != nil && customLabel != nil {
                    let size = customView!.frame.size
                    return size
                } else {
                    var size = lessonTextLabel.sizeThatFits(CGSize(width: 200.0, height: 150))
                    // Add size for constraints
                    size.height += 24
                    size.width += 32
                    return size
                }
            } else {
                return super.preferredContentSize
            }
        }
        set {
            super.preferredContentSize = newValue
        }
    }
    
    @objc private func viewDidClick(_ sender: UITapGestureRecognizer? = nil) {
        dismiss(animated: false, completion: completionHandler)
    }
}

/// An extension for displaying popover view correctly and disabling dismiss after touch outside the hint
extension LessonPopoverViewController: UIPopoverPresentationControllerDelegate {
    public func adaptivePresentationStyle(for: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    public func adaptivePresentationStyle(for controller: UIPresentationController,
                                          traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    public func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        // TODO: Replace this hook with presentationControllerShouldDismiss(_:) when iOS version will up to 13.0+.
        // https://developer.apple.com/documentation/uikit/uiadaptivepresentationcontrollerdelegate/3229890-presentationcontrollershoulddism
        return false
    }
}
