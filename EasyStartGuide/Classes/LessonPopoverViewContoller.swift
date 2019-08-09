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
    
    enum Constants {
        static let popoverBoundsSize = CGSize(width: 200.0, height: CGFloat.greatestFiniteMagnitude)
        static let viewConstraints = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
    
    private var completionHandler: (() -> Void)?

    private var dismissMode: EasyStartGuide.GuideOption.DismissMode = .byClickOnGuide
    private var textColor: UIColor = UIColor.white
    private var backgroundColor: UIColor = UIColor.lightGray
    private var cornerRadius: CGFloat = 13.0
    
    private weak var customView: UIView?
    private weak var customLabel: UILabel?
    
    private var lessonTextLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 150))
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = UIColor.white
        label.lineBreakMode = .byClipping
        label.numberOfLines = 0
        return label
    }()
    
    public override var preferredContentSize: CGSize {
        get {
            if presentingViewController != nil {
                var size: CGSize
                if customView != nil {
                    size = customView!.frame.size
                } else {
                    size = lessonTextLabel.sizeThatFits(Constants.popoverBoundsSize)
                    size = addInsetsToSize(insets: Constants.viewConstraints, to: size)
                }
                return size
            } else {
                return super.preferredContentSize
            }
        }
        set {
            super.preferredContentSize = newValue
        }
    }
    
    
    required init(hintText: String, sourceView: UIView, sourceRect: CGRect, arrowDirection: UIPopoverArrowDirection,
                  options: [EasyStartGuide.GuideOption], completion: (() -> Void)?) {
        super.init(nibName: nil, bundle: nil)
        
        modalPresentationStyle = .popover
        applyOptions(options: options)
        configureView(text: hintText)
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
        view.superview!.layer.cornerRadius = cornerRadius
    }
    
    private func applyOptions(options: [EasyStartGuide.GuideOption]) {
        options.forEach { (option) in
            switch option {
            case .backgroundColor(let color):
                backgroundColor = color
            case .textColor(let color):
                textColor = color
            case .cornerRadius(let radius):
                cornerRadius = radius
            case .dismissMode(let mode):
                dismissMode = mode
            case .customView(let view, let label):
                customView = view
                customLabel = label
            }
        }
    }
    
    private func configureView(text: String) {
        if customView != nil, customLabel != nil {
            view.addSubview(customView!)
            customLabel!.text = text
            customLabel!.sizeToFit()
            backgroundColor = customView!.backgroundColor!
        } else {
            lessonTextLabel.text = text
            lessonTextLabel.textColor = textColor
            
            let size = lessonTextLabel.sizeThatFits(Constants.popoverBoundsSize)
            lessonTextLabel.frame = CGRect(origin: CGPoint(x: Constants.viewConstraints.left, y: Constants.viewConstraints.top), size: size)
            let containerView = UIView(frame: CGRect(origin: .zero, size: addInsetsToSize(insets: Constants.viewConstraints, to: size)))
            containerView.backgroundColor = backgroundColor
            containerView.layer.cornerRadius = cornerRadius
            
            containerView.addSubview(lessonTextLabel)
            view.addSubview(containerView)
        }
        
        popoverPresentationController?.backgroundColor = backgroundColor
        
        view.contentMode = .scaleToFill
        view.frame.size = preferredContentSize
        view.layoutSubviews()
    }
    
    private func addInsetsToSize(insets: UIEdgeInsets, to size: CGSize) -> CGSize {
        var newSize = size
        newSize.width += insets.left + insets.right
        newSize.height += insets.top + insets.bottom
        return newSize
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
        if case .byClickAnywhere = dismissMode {
            dismiss(animated: false, completion: completionHandler)
            return true
        }
        return false
    }
}
