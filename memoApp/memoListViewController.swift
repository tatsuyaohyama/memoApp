//
//  memoListViewController.swift
//  memoApp
//
//  Created by tatsuya ohyama on 2019/03/24.
//  Copyright © 2019 tatsuya.ohyama. All rights reserved.
//

import UIKit

class memoListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "memoListCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "memoListCell")
    }
}

extension memoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: "memoListCell", for: indexPath) as? memoListCell else {
            fatalError("The dequeued cell is not instance of memoListCell.")
        }
        cell.memoTitleLabel.text = "test\(indexPath.row)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension memoListViewController: UITableViewDelegate {

}
