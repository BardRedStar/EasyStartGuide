//
//  MainChatTutorialPresenter.swift
//  MemberSet
//
//  Created by User on 23/07/2019.
//  Copyright © 2019 Saritasa. All rights reserved.
//

import Foundation
import UIKit

/// A main class for initiate guide
public class EasyStartGuide {
    
    /// Global guide options
    public var options: [EasyStartGuide.GuideOption] = []
    
    private var currentLessonIndex = 0
    
    /// Called when the tutorial ends
    private var completionHandler: (() -> Void)?
    
    public required init() {
    }
    
    
    /// Starts the tutorial
    ///
    /// - Parameters:
    ///   - viewController: Controller instance in which the tutorial will be presented
    ///   - lessons: Array of lesson objects to show in order
    ///   - completionHandler: Handler which will be called when the last lesson ends
    public func startTutorial(in viewController: UIViewController, withLessons lessons: [GuideLesson], completionHandler: (() -> Void)? = nil) {
        self.completionHandler = completionHandler
        
        if lessons.count > 0 {
            currentLessonIndex = 0
            displayGuideLesson(viewController: viewController,
                               lesson: lessons[currentLessonIndex],
                               completionHandler: { [weak self] in
                                guard let self = self else { return }
                                self.showNextLesson(viewController: viewController, lessons: lessons)
            })
        }
    }
    
    
    /// Displays lesson
    ///
    /// - Parameters:
    ///   - viewController: Controller instance in which the lesson will be presented
    ///   - lesson: Lesson instance to present
    ///   - completionHandler: Handler which will be called when the last lesson ends
    private func displayGuideLesson(viewController: UIViewController, lesson: GuideLesson, completionHandler: (() -> Void)?) {
        let popoverLesson = LessonPopoverViewController(text: lesson.text,
                                                        sourceView: lesson.view,
                                                        sourceRect: CGRect(origin: lesson.point, size: .zero),
                                                        arrowDirection: lesson.arrowDirection.value,
                                                        options: options,
                                                        completion: completionHandler)
        viewController.present(popoverLesson, animated: false, completion: nil)
    }
    
    
    /// Shows the next lesson in order or calls completion handler if the last lesson was shown
    ///
    /// - Parameters:
    ///   - viewController: Controller instance in which the lesson will be presented
    ///   - lessons: Array of lesson objects to show in order
    private func showNextLesson(viewController: UIViewController, lessons: [GuideLesson]) {
        currentLessonIndex += 1
        if currentLessonIndex < lessons.count {
            displayGuideLesson(viewController: viewController,
                               lesson: lessons[currentLessonIndex],
                               completionHandler: { [weak self] in
                                guard let self = self else { return }
                                self.showNextLesson(viewController: viewController, lessons: lessons)
            })
        } else {
            completionHandler?()
        }
    }
}
