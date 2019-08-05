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
    private var tipTextLabel: UILabel!
    
    private var completionHandler: (() -> Void)?
    /// - Parameters:
    ///   - hintText: Text which will be displayed in the hint.
    ///   - sourceView: sourceView for binding popover.
    ///   - sourceRect: bounds of the source view. Use X and Y params to create arrow offset.
    required init(hintText: String, sourceView: UIView, sourceRect: CGRect, completion: (() -> Void)?) {
        super.init(nibName: nil, bundle: nil)
        completionHandler = completion
        
        modalPresentationStyle = .popover
        configureView(text: hintText)
        popoverPresentationController?.delegate = self
        popoverPresentationController!.sourceView = sourceView
        popoverPresentationController!.sourceRect = sourceRect
        popoverPresentationController!.permittedArrowDirections = .any
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewDidClick(_:)))
        view.addGestureRecognizer(tap)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        popoverPresentationController?.backgroundColor = UIColor(red: 0.29, green: 0.72, blue: 0.76, alpha: 1.0)
        view.superview?.layer.cornerRadius = 0
        view.backgroundColor = UIColor(red: 0.29, green: 0.72, blue: 0.76, alpha: 1.0)
    }
    
    /// Configures a tip view with contraints
    ///
    /// - Parameter text: Text which will be displayed in the hint
    private func configureView(text: String) {
        view.contentMode = .scaleToFill
        tipTextLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 150))
        tipTextLabel.text = text
        tipTextLabel.font = UIFont.systemFont(ofSize: 14.0)
        tipTextLabel.textColor = UIColor.white
        tipTextLabel.lineBreakMode = .byClipping
        tipTextLabel.numberOfLines = 0
        tipTextLabel.sizeToFit()
        view.addSubview(tipTextLabel)
        view.layoutSubviews()
        
        addConstraints()
    }
    
    private func addConstraints() {
        tipTextLabel.translatesAutoresizingMaskIntoConstraints = false
        let top = NSLayoutConstraint(item: tipTextLabel!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 10)
        let left = NSLayoutConstraint(item: tipTextLabel!, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 16)
        let right = NSLayoutConstraint(item: tipTextLabel!, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -16)
        right.priority = UILayoutPriority(999)
        
        view.addConstraints([top, left, right])
    }
    
    public override var preferredContentSize: CGSize {
        get {
            if tipTextLabel != nil, presentingViewController != nil {
                var size = tipTextLabel!.sizeThatFits(CGSize(width: 200.0, height: 150))
                // Add size for constraints
                size.height += 24
                size.width += 32
                return size
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
