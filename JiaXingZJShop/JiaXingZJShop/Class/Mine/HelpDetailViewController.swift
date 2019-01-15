//
//  HelpDetailViewController.swift
//
//  Created by jsonshenglong on 2019/1/15.
//  Copyright © 2019年 jsonshenglong. All rights reserved.

import UIKit

class HelpDetailViewController: BaseViewController {
    
    fileprivate var questionTableView: LFBTableView?
    fileprivate var questions: [Question]?
    fileprivate var lastOpenIndex = -1
    fileprivate var isOpenCell = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "常见问题"
        view.backgroundColor = UIColor.white
        
        buildQuestionTableView()
        
        loadHelpData()
    }
    
    fileprivate func buildQuestionTableView() {
        questionTableView = LFBTableView(frame: view.bounds, style: UITableView.Style.plain)
        questionTableView?.backgroundColor = UIColor.white
        questionTableView?.register(HelpHeadView.self, forHeaderFooterViewReuseIdentifier: "headView")
        questionTableView?.sectionHeaderHeight = 50
        questionTableView!.delegate = self
        questionTableView!.dataSource = self
        questionTableView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: NavigationH, right: 0)
        view.addSubview(questionTableView!)
    }
    
    fileprivate func loadHelpData() {
        weak var tmpSelf = self
        
        Question.loadQuestions { (questions) -> () in
            tmpSelf!.questions = questions
            tmpSelf!.questionTableView?.reloadData()
        }
    }
}


extension HelpDetailViewController: UITableViewDelegate, UITableViewDataSource, HelpHeadViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AnswerCell.answerCell(tableView)
        cell.question = questions![(indexPath as NSIndexPath).section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if lastOpenIndex == section && isOpenCell {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if lastOpenIndex == (indexPath as NSIndexPath).section && isOpenCell {
            return questions![(indexPath as NSIndexPath).section].cellHeight
        }
        
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return questions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headView") as? HelpHeadView
        headView!.tag = section
        headView?.delegate = self
        let question = questions![section]
        headView?.question = question
        
        return headView!
    }
    
    func headViewDidClck(_ headView: HelpHeadView) {
        if lastOpenIndex != -1 && lastOpenIndex != headView.tag && isOpenCell {
            let headView = questionTableView?.headerView(forSection: lastOpenIndex) as? HelpHeadView
            headView?.isSelected = false
            
            let deleteIndexPaths = [IndexPath(row: 0, section: lastOpenIndex)]
            isOpenCell = false
            questionTableView?.deleteRows(at: deleteIndexPaths, with: UITableView.RowAnimation.automatic)
        }
        

        if lastOpenIndex == headView.tag && isOpenCell {
            let deleteIndexPaths = [IndexPath(row: 0, section: lastOpenIndex)]
            isOpenCell = false
            questionTableView?.deleteRows(at: deleteIndexPaths, with: UITableView.RowAnimation.automatic)
            return
        }
        
        lastOpenIndex = headView.tag
        isOpenCell = true
        let insertIndexPaths = [IndexPath(row: 0, section: headView.tag)]
        questionTableView?.insertRows(at: insertIndexPaths, with: UITableView.RowAnimation.top)
    }
    
}

