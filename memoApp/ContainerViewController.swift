//
//  ContainerViewController.swift
//  memoApp
//
//  Created by tatsuya ohyama on 2019/03/25.
//  Copyright © 2019 tatsuya.ohyama. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func addMemo(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Details", bundle: nil)
        let detailsVC = storyboard.instantiateViewController(withIdentifier: "details")
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
