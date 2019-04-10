//
//  DetailsViewController.swift
//  memoApp
//
//  Created by tatsuya ohyama on 2019/03/26.
//  Copyright © 2019 tatsuya.ohyama. All rights reserved.
//

import UIKit
import RealmSwift

class DetailsViewController: UIViewController {
    
    @IBOutlet var memoTextView: UITextView!
    @IBOutlet var memoTextCountLabel: UILabel!
    
    var editMemoData: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        memoTextView.delegate = self
        setRightBarButtonItem()
        setLeftBarButtonItem()
    }

    func setRightBarButtonItem() {
        let rightButton = UIBarButtonItem(title: "完了", style: .plain, target: self, action: #selector(add))
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    func setLeftBarButtonItem() {
        let leftButton = UIBarButtonItem(title: "戻る", style: .plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem = leftButton
    }

    @objc func add() {
        saveMemoData()
    }
        
    @objc func back() {
        displayAlert()
    }
    
    func displayAlert() {
        let alert = UIAlertController(title: nil, message: "テキストを破棄してもよろしいですか？", preferredStyle: .alert)

        let okAlertAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.navigationController?.popToRootViewController(animated: true)
        }
        let cancelAlertAction = UIAlertAction(title: "キャンセル", style: .default) { (action) in
            return
        }

        alert.addAction(okAlertAction)
        alert.addAction(cancelAlertAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveMemoData() {
        let myMemoData: MyData = MyData()
        if editMemoData == nil {
            if (self.memoTextView.text?.isEmpty)! {
                return
            } else {
                myMemoData.memoData = self.memoTextView.text!
                let realm = try! Realm()
                try! realm.write {
                    realm.add(myMemoData)
                }
                self.navigationController?.popToRootViewController(animated: true)
            }
        } else {
            if (self.memoTextView.text?.isEmpty)! {
                let realm = try! Realm()
                let results = realm.objects(MyData.self).filter("memoData == %@", self.editMemoData)
                try! realm.write {
                    realm.delete(results[0])
                }
            } else {
                let realm = try! Realm()
                let results = realm.objects(MyData.self).filter("memoData == %@", self.editMemoData)
                try! realm.write {
                    results[0].memoData = self.memoTextView.text!
                }
            }
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let textCount = self.editMemoData {
            memoTextCountLabel.text = String(textCount.count)
        }
        if let memoData = self.editMemoData {
            let realm = try! Realm()
            let results = realm.objects(MyData.self).filter("memoData == %@", memoData)
            self.memoTextView.text = results[0].memoData
        } else {
            return
        }
    }
}

extension DetailsViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let textCount = self.memoTextView.text.count
        memoTextCountLabel.text = String(textCount)
    }
}
