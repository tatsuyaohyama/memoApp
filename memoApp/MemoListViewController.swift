//
//  memoListViewController.swift
//  memoApp
//
//  Created by tatsuya ohyama on 2019/03/24.
//  Copyright © 2019 tatsuya.ohyama. All rights reserved.
//

import UIKit
import RealmSwift

class MemoListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var memoList: Results<MyData>!

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "MemoListCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MemoListCell")
        
        getMemoData()
    }
    
    func getMemoData() {
        do{
            let realm = try Realm()
            memoList = realm.objects(MyData.self)
            self.tableView.reloadData()
        }catch{
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getMemoData()
    }
}

extension MemoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: "MemoListCell", for: indexPath) as? MemoListCell else {
            fatalError("The dequeued cell is not instance of MemoListCell.")
        }
        cell.memoTitleLabel.text = memoList[indexPath.row].memoData

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectMemoData = memoList[indexPath.row].memoData
        let storyboard = UIStoryboard(name: "Details", bundle: nil)
        let detailsVC = storyboard.instantiateViewController(withIdentifier: "details") as! DetailsViewController
        detailsVC.testData = selectMemoData
        navigationController?.pushViewController(detailsVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if(editingStyle == UITableViewCell.EditingStyle.delete) {
            do{
                let realm = try Realm()
                try realm.write {
                    realm.delete(self.memoList[indexPath.row])
                }
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            }catch{
            }
        }
    }
}

extension MemoListViewController: UITableViewDelegate {

}
