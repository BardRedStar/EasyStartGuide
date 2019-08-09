//
//  ViewController.swift
//  EasyStartGuide
//
//  Created by BardRedStar on 07/29/2019.
//  Copyright (c) 2019 BardRedStar. All rights reserved.
//

import UIKit
import EasyStartGuide

/// A class for example view controller
class ViewController: UIViewController {
    
    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var orangeView: UIView!
    @IBOutlet weak var centerLabel: UILabel!
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Start tutorials
        startBasicGuide()
    }
    
    
    /// Starts the tutorial with default options. Shows basic usage of library and some individual options for each tutorial lesson.
    func startBasicGuide() {
        let basicGuideInstance = EasyStartGuide.instance
        basicGuideInstance.startTutorial(in: self,
                                         withLessons: [
                                            // Common example
                                            EasyStartGuide.GuideLesson(view: blueView, text: "There is a blue view on the top-left of the view!"),
                                            EasyStartGuide.GuideLesson(view: greenView, text: "Small text"),
                                            EasyStartGuide.GuideLesson(view: redView, text: "Bottom tip :)"),
                                            EasyStartGuide.GuideLesson(view: orangeView, text: "Very-very-very-very-very-very-very-very-very-very-very-very-very-very huge text for the orange view"),
                                            
                                            // Arrow location example
                                            EasyStartGuide.GuideLesson(view: centerLabel, text: "Top-left point of the center label", location: .topLeft),
                                            EasyStartGuide.GuideLesson(view: centerLabel, text: "Top-right point of the center label", location: .topRight),
                                            EasyStartGuide.GuideLesson(view: centerLabel, text: "Bottom-left point of the center label", location: .bottomLeft),
                                            EasyStartGuide.GuideLesson(view: centerLabel, text: "Bottom-right point of the center label", location: .bottomRight),
                                            EasyStartGuide.GuideLesson(view: centerLabel, text: "Top-center point of the center label", location: .topCenter),
                                            EasyStartGuide.GuideLesson(view: centerLabel, text: "Bottom-center point of the center label", location: .bottomCenter),
                                            EasyStartGuide.GuideLesson(view: centerLabel, text: "Left-center point of the center label", location: .leftCenter),
                                            EasyStartGuide.GuideLesson(view: centerLabel, text: "Right-center point of the center label", location: .rightCenter),
                                            EasyStartGuide.GuideLesson(view: centerLabel, text: "Custom point (10, 5) from the top-left point of the center label", location: .custom(x: 10.0, y: 5.0)),
                                            
                                            // Arrow direction example
                                            EasyStartGuide.GuideLesson(view: centerLabel, text: "Up arrow", arrowDirection: .up),
                                            EasyStartGuide.GuideLesson(view: centerLabel, text: "Down arrow", arrowDirection: .down),
                                            EasyStartGuide.GuideLesson(view: centerLabel, text: "Left arrow", arrowDirection: .left),
                                            EasyStartGuide.GuideLesson(view: centerLabel, text: "Right arrow", arrowDirection: .right)],
                                         completionHandler: {
                                            self.startAdvancedGuide()
        })
    }
    
    
    /// Starts the advanced guide with some global configurations of tutorial instance
    private func startAdvancedGuide() {
        let advancedGuideInstance = EasyStartGuide.instance
        advancedGuideInstance.options = [.backgroundColor(UIColor.darkGray), .textColor(UIColor.green), .cornerRadius(4.0), .dismissMode(.byClickAnywhere)]
        advancedGuideInstance.startTutorial(in: self,
                                            withLessons: [EasyStartGuide.GuideLesson(view: centerLabel, text: "Custom colors and corners", arrowDirection: .up)],
                                            completionHandler: {
                                                self.startCustomViewGuide()
        })
    }
    
    
    /// Starts the guide with custom view
    private func startCustomViewGuide() {
        
        // Get test view and label to bind them to tutorial
        let (testView, testLabel) = makeCustomView()
        
        let customViewGuideInstance = EasyStartGuide.instance
        // Bind container view and label to present text on it
        customViewGuideInstance.options = [.customView(containerView: testView, label: testLabel), .cornerRadius(8.0)]
        customViewGuideInstance.startTutorial(in: self, withLessons: [EasyStartGuide.GuideLesson(view: centerLabel, text: "Custom view example")])
    }
    
    
    /// Creates a custom view with label and button
    ///
    /// - Returns: Couple of views: container view and label view
    private func makeCustomView() -> (UIView, UILabel) {
        // Configure view
        let testView = UIView()
        testView.backgroundColor = UIColor.black
        testView.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure label
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = UIColor.white
        label.lineBreakMode = .byClipping
        label.numberOfLines = 0
        label.text = "Test text"
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure button
        let button = UIButton()
        button.setTitle("Test", for: .normal)
        button.setTitleColor(UIColor(red: 0.85, green: 0.35, blue: 0.35, alpha: 1.0), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        testView.addSubview(label)
        testView.addSubview(button)
        
        // Constraints
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: testView.leadingAnchor, constant: 10),
            label.topAnchor.constraint(equalTo: testView.topAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: testView.trailingAnchor, constant: -10),
            
            testView.widthAnchor.constraint(equalToConstant: 200.0),
            testView.heightAnchor.constraint(equalToConstant: 100.0),
            
            button.bottomAnchor.constraint(equalTo: testView.bottomAnchor, constant: -10),
            button.trailingAnchor.constraint(equalTo: testView.trailingAnchor, constant: -10)
            ])
        
        // Draw it immediately to define sizes
        testView.layoutIfNeeded()
        
        return (testView, label)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

