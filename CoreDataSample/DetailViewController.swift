//
//  DetailViewController.swift
//  CoreDataSample
//
//  Created by Kimisira on 2016/03/28.
//  Copyright © 2016年 Kimisira. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController,UITextFieldDelegate {
    var detailItem:Person?
    let labels: [[String: String]] = [
            ["id": "name", "title": "名前"],
            ["id": "address.zipCode", "title":"郵便番号"],
            ["id": "address.state", "title": "都道府県"],
            ["id": "address.city", "title": "市町村"],
            ["id": "address.other", "title": "その他住所"]
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Viewが画面から消えるたびに直前に呼ばれる
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        for (i,label) in self.labels.enumerate(){
            let indexPath = NSIndexPath(forRow: i,inSection: 0)
        
            //テーブルセルのオブジェクトを取得する
            if let cell = self.tableView.cellForRowAtIndexPath(indexPath) {
                let key = label["id"]
                
                //テキストフィールドオブジェクトを取得する
                if let editView = cell.contentView.viewWithTag(2) as? UITextField{
                    
                    //テキストフィールドオブジェクトの内容をPersonオブジェクトに設定する
                    self.detailItem?.setValue(editView.text!, forKeyPath: key!)
                }
            }
        }
        do{
            //編集したデータを保存する
            let item = detailItem
            try item?.managedObjectContext!.save()
        }catch{
            
        }
}
    
    func textFieldShouldReturn(textField:UITextField) -> Bool{
            textField.resignFirstResponder()
        return true
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.labels.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //テーブルオブジェクトの取得
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell",forIndexPath: indexPath)
        
        //データの取得
        let label = labels[indexPath.row] as Dictionary
        
        //ラベルをタグで取得(titleをLabelに入れる)
        if let titleView = cell.contentView.viewWithTag(1) as? UILabel{
            titleView.text = label["title"]
        }
        //テキストフィールドをタグで取得
        if let  editView = cell.contentView.viewWithTag(2) as? UITextField{
            
                editView.delegate = self
            
            let key = label["id"]
           
            //Personオブジェクトに格納されているデータをテキストフィールドに表示する(読み込み)
            if let item = self.detailItem {
                if let obj:AnyObject = item.valueForKeyPath(key!){
                    editView.text = obj.description
                    
            }
        }
    }
    return cell
    }
    
    
    
    
    
    
    
    
}