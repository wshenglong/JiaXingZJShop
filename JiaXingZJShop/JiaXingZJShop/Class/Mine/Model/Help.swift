//
//  Help.swift
//  Created by jsonshenglong on 2019/1/15.
//  Copyright © 2019年 jsonshenglong. All rights reserved.

import UIKit

class Question: NSObject {
    @objc var title: String?
    @objc var texts: [String]? {
        didSet {
            let maxSize = CGSize(width: ScreenWidth - 40, height: 100000)
            for i in 0..<texts!.count {
                let str = texts![i] as NSString
                let rowHeight: CGFloat = str.boundingRect(with: maxSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)], context: nil).size.height + 14
                cellHeight += rowHeight
                everyRowHeight.append(rowHeight)
            }
        }
    }
    
    var everyRowHeight: [CGFloat] = []
    var cellHeight: CGFloat = 0
    
    class func question(_ dict: NSDictionary) -> Question {
        let question = Question()
        question.title = dict.object(forKey: "title") as? String
        question.texts = dict.object(forKey: "texts") as? [String]
        
        return question
    }
    
    class func loadQuestions(_ complete: (([Question]) -> ())) {
        let path = Bundle.main.path(forResource: "HelpPlist", ofType: "plist")
        let array = NSArray(contentsOfFile: path!)
        
        var questions: [Question] = []
        if array != nil {
            for dic in array! {
                let dicModel = Question.mj_object(withKeyValues: dic) as Question
                questions.append(dicModel)
//                questions.append(Question.question(dic as! NSDictionary))
            }
        }
        complete(questions)
    }
}


