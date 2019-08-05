//
//  ViewController.swift
//  EasyStartGuide
//
//  Created by BardRedStar on 07/29/2019.
//  Copyright (c) 2019 BardRedStar. All rights reserved.
//

import UIKit
import EasyStartGuide

class ViewController: UIViewController {

    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var orangeView: UIView!
    @IBOutlet weak var centerLabel: UILabel!
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Do any additional setup after loading the view, typically from a nib.
        
        let startGuideInstance = EasyStartGuide.instance
        
        startGuideInstance.startTutorial(in: self,
                                         withLessons: [GuideLesson(view: blueView, text: "There is a blue view on the top-left of the view!"),
                                                       GuideLesson(view: greenView, text: "Small text"),
                                                       GuideLesson(view: redView, text: "Bottom tip :)"),
                                                       GuideLesson(view: orangeView, text: "Very-very-very-very-very-very-very-very-very-very-very-very-very-very huge text for the orange view"),
                                                       GuideLesson(view: centerLabel, text: "Top-left point of the center label", location: .topLeft),
                                                       GuideLesson(view: centerLabel, text: "Top-right point of the center label", location: .topRight),
                                                       GuideLesson(view: centerLabel, text: "Bottom-left point of the center label", location: .bottomLeft),
                                                       GuideLesson(view: centerLabel, text: "Bottom-right point of the center label", location: .bottomRight),
                                                       GuideLesson(view: centerLabel, text: "Top-center point of the center label", location: .topCenter),
                                                       GuideLesson(view: centerLabel, text: "Bottom-center point of the center label", location: .bottomCenter),
                                                       GuideLesson(view: centerLabel, text: "Left-center point of the center label", location: .leftCenter),
                                                       GuideLesson(view: centerLabel, text: "Right-center point of the center label", location: .rightCenter),
                                                       GuideLesson(view: centerLabel, text: "Custom point (10, 5) from the top-left point of the center label", location: .custom(x: 10.0, y: 5.0))])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

