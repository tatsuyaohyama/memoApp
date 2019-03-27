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

    @IBOutlet var memoTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        memoTextField.delegate = self
        setRightBarButtonItem()
    }

    func setRightBarButtonItem() {
        let rightButton = UIBarButtonItem(title: "完了", style: .plain, target: self, action: #selector(add))
        self.navigationItem.rightBarButtonItem = rightButton
    }

    @objc func add() {
        saveMemoData()
    }
    
    func saveMemoData() {
        let myMemoData: MyData = MyData()
        if let memoTextData = self.memoTextField.text {
            myMemoData.memoData = memoTextData
            let realm = try! Realm()
            try! realm.write {
                realm.add(myMemoData)
            }
        } else {
            fatalError()
        }
    }
}

extension DetailsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        memoTextField.resignFirstResponder()
        return true
    }
}
