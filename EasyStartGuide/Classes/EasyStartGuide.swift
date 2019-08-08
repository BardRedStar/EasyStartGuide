//
//  MainChatTutorialPresenter.swift
//  MemberSet
//
//  Created by User on 23/07/2019.
//  Copyright © 2019 Saritasa. All rights reserved.
//

import Foundation
import UIKit

public class EasyStartGuide {
    
    public static let instance = EasyStartGuide()
    
    public var options: [EasyStartGuide.GuideOption] = [.backgroundColor(UIColor.lightGray),
                                                            .textColor(UIColor.white),
                                                            .cornerRadius(5.0),
                                                            .dismissMode(.byClickOnGuide)]
    private var currentLessonIndex = 0
    private var completionHandler: (() -> Void)?
    
    private init(){}
    
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
    
    private func displayGuideLesson(viewController: UIViewController, lesson: GuideLesson, completionHandler: (() -> Void)?) {
        let popoverLesson = LessonPopoverViewController(hintText: lesson.text,
                                                        sourceView: lesson.view,
                                                        sourceRect: CGRect(origin: lesson.point, size: .zero),
                                                        arrowDirection: lesson.arrowDirection.value,
                                                        options: options,
                                                        completion: completionHandler)
        viewController.present(popoverLesson, animated: false, completion: nil)
    }
    
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
