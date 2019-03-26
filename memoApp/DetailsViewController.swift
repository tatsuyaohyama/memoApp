//
//  DetailsViewController.swift
//  memoApp
//
//  Created by tatsuya ohyama on 2019/03/26.
//  Copyright © 2019 tatsuya.ohyama. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet var memoTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        memoTextField.delegate = self
        setRightBarButtonItem()
    }

    func setRightBarButtonItem() {
        let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        self.navigationItem.rightBarButtonItem = rightButton
    }

    @objc func add() {
        print("hoge")
    }
}

extension DetailsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        memoTextField.resignFirstResponder()
        return true
    }
}
