//
//  MasterViewController.swift
//  CoreDataSample
//
//  Created by Kimisira on 2016/03/28.
//  Copyright © 2016年 Kimisira. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate,UISearchResultsUpdating,UISearchBarDelegate{

    var detailViewController: DetailViewController? = nil
    var managedObjectContext: NSManagedObjectContext? = nil
    
    var searchController:UISearchController!
    var searchPredicate:NSPredicate?
    
    //検索結果を保持
    var filteredObjects:[Person]? = nil
    

//    var searchBarController = UISearchController(searchResultsController:nil)
//    
//    var filteredMovies = [Person]()
//    
//    var movies = [Person]()
    
    //検索結果を保持
    //var searchResults = [""]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(MasterViewController.showAlert))
        self.navigationItem.rightBarButtonItem = addButton
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
       
            searchController = UISearchController(searchResultsController:nil)
            searchController.searchResultsUpdater = self
            searchController.searchBar.searchBarStyle = UISearchBarStyle.Prominent
            searchController.searchBar.delegate = self
            searchController.searchBar.placeholder = "検索"
            searchController.dimsBackgroundDuringPresentation = false
            
            self.tableView.tableHeaderView = self.searchController.searchBar
    
        }
    
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //データの追加
    func showAlert(){
        let alertController = UIAlertController(title: "新規連絡先を作成する",message: "名前を入力してください。",preferredStyle: .Alert)
        // アラートビューにテキストフィールドを追加
        alertController.addTextFieldWithConfigurationHandler(nil)
        // やめるボタン
        let cancelAction = UIAlertAction(title: "やめる", style: .Cancel, handler: nil)
        // 作成するボタン
        let otherAction = UIAlertAction(title: "作成する", style: .Default) {
            [unowned self] action in
            if let textFields = alertController.textFields {
                let textField = textFields[0]
                print(textField)
                self.insertNewObject(textField.text!)
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(otherAction)
        // アラートビューの表示
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    func aaaa(){
    
//    //テキストが変更された時
//    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
//        
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        let managedObjectContext = appDelegate.managedObjectContext
//        
//        //EntityDescriptionのインスタンス
//        let entityDiscription = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedObjectContext)
//        
//        //NSFetchRequest SQLのSelect
//        
//        
//        let fetchRequest = NSFetchRequest()
//        fetchRequest.entity = entityDiscription
//        
//        //NSPreficate SQLのWhere
//        let predicate = NSPredicate(format: "%K = %@","name",searchText)
//        fetchRequest.predicate = predicate
//        
//        do{
//            searchResults.removeAll()
//            let results = try managedObjectContext.executeFetchRequest(fetchRequest)
//            for managedObjectContext in results {
//                let model = managedObjectContext as? Person
//                print("該当あり\(model!.name)")
//                searchResults.append((model?.name)!)
//                print(searchResults)
//                self.tableView.reloadData()
//            }
//        }catch{
//            print("該当なし")
//            searchResults.removeAll()
//            abort()
//        }
//        
//        print(searchResults)
//        
////        //フェッチリクエスト
////        let fetchRequest = NSFetchRequest(entityName: "Person")
////        
////        //条件を設定
////        fetchRequest.predicate = NSPredicate(format: "%K = %K","name", searchText)
////        let keyPathExprsstionn = NSExpression(forKeyPath)
////        
////        fetchRequest.propertiesToFetch = [description]
////        fetchRequest.resultType = .DictionaryResultType
////        
////        
////        //フェッチ結果
////        do {
////        let fetchResult  = try? managedObjectContext.executeFetchRequest(fetchRequest)
////            
////             print(fetchResult)
////        } catch{
////            abort()
////        }
////
////        
////        //fetchRequest.predicate = predicate
////        
////        do {
////            let employees = try appDelegate.managedObjectContext.executeFetchRequest(fetchRequest) as! [Person]
////           print(employees)
////            
////            
////        } catch let error as NSError {
////            print(error)
////        }
////        let predicate = NSPredicate(format: "%K = %K", "name",searchText)
////        fetchRequest.predicate = predicate
//        
////        var results = try managedObjectContext!.executeFetchRequest(request) as! [NSManagedObject]
////        print(results)
////        
////        do {
////            let results:Array = try context.executeFetchRequest(request)
////            if results == predicate {
////                print("---")
////            }
////            
////        }catch{
////            
////        }
////        
////        if   let managedObjectContext: NSManagedObjectContext = appDelegate.managedObjectContext {
////            
////            let entityDiscription = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedObjectContext)
////            
////            
////            fetchRequest.entity = entityDiscription
////            
////            let predicate = NSPredicate(format: "%K = %K", "name",searchText)
////            fetchRequest.predicate = predicate
////            
////            
////            do {
////                
////                var results = try managedObjectContext.executeFetchRequest(fetchRequest)
////                    
////                
////            }catch{
////                abort()
////            }
////            
////            
////            
////        
////        }
////
////        let fetchRequest = NSFetchRequest(entityName: "Person")
////        fetchRequest.returnsObjectsAsFaults = false
////        var myResults:NSArray = managedObjectContext.executeFetchRequest(fetchRequest,error:nil)
////        
////        //let entityDiscription = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedObjectContext!)
////        //fetchRequest.entity = entityDiscription
////
////        
////        let predicate = NSPredicate(format:  "%K = %K","name",searchText)
////        
////        fetchRequest.predicate = predicate
////        
////        print(fetchRequest.predicate)
////        
////        let fetchResult:NSArray = try! managedObjectContext.executeFetchRequest(fetchRequest)
////        print(fetchResu)
////        
////
////        let descriptor = NSSortDescriptor(key:"name",ascending: false)
////        fetchRequest.sortDescriptors = [descriptor]
////        
////        //let results = managedObjectContext?.executeFetchRequest(fetchRequest)
//        //print(results)
//        
////        do {
////            print("検索結果")
////            
////            let results = try  managedObjectContext?.executeFetchRequest(fetchRequest)
////            
////            print(results)
////        } catch {
////
////            abort()
////        }
////
////        
//        
//        self.tableView.reloadData()
//    }
//
//    //Searchボタンが押された時に呼ばれる
//    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
//        
//    }
//    
//    //Cancelボタンが押された
//    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
//        searchBar.text = ""
//        self.view.endEditing(true)
//    }
//    
    
    }
    
    //追加
    func insertNewObject(name:String) {
        //挿入するのでフェイチリクエストと呼び出し
        let context = self.fetchedResultsController.managedObjectContext
        let entity = self.fetchedResultsController.fetchRequest.entity!
    
        //Personオブジェクトを生成する
        let person = NSEntityDescription.insertNewObjectForEntityForName(entity.name!, inManagedObjectContext: context) as NSManagedObject
        
        //Addressオブジェクトを生成する(エンティティの定義のを関スルクbラス)
        let address = NSEntityDescription.insertNewObjectForEntityForName("Address", inManagedObjectContext: context) as NSManagedObject
        
        //Personオブジェクトに名前とAddresオブジェクトをセットする(name = AlertControllerのtextField.text)
        person.setValue(name, forKey: "name")
        person.setValue(address, forKey: "address")
        
        do {
            try context.save()
        } catch {
            abort()
        }
    }

    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                var note:Person!
                if filteredObjects == nil {
                    note = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Person
                }else{
                     //note = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Person
                     note = filteredObjects![indexPath.row] as Person
                   
                     print("SearchPredicate returned")
                }
                //let object = self.fetchedResultsController.objectAtIndexPath(indexPath)
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = note
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
            searchController.active = false
        }
        
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return self.fetchedResultsController.sections!.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != ""{
            return filteredObjects?.count ?? 0
        }else{
            let sectionInfo = self.fetchedResultsController.sections![section]
            return sectionInfo.numberOfObjects
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
          //let cell = UITableViewCell()
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell",forIndexPath: indexPath) as UITableViewCell
            if searchController.active  && searchController.searchBar.text != ""{
                if  let note = self.filteredObjects?[indexPath.row] {
                    cell.textLabel?.text = note.name
                }
                //print("cellFor:\(filteredMovies[indexPath.row])")
            
//            print("cellForRow:\(searchResults[0].name)")
//            print("searchResults:\(searchResults[0].name)")&& searchBarController.searchBar.text != ""
//            //cell.textLabel?.text = searchResults[0].name
            
        }else {
            self.configureCell(cell, atIndexPath:indexPath)
            
        }
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    //データの削除(tableViewのeditingStyleでの削除)
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
           
            let context = self.fetchedResultsController.managedObjectContext
            context.deleteObject(self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject)
                
            do {
                try context.save()
            } catch {
                abort()
            }
        }
    }

    func configureCell(cell: UITableViewCell, atIndexPath indexPath:NSIndexPath) {
        let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
        cell.textLabel?.text = object.valueForKey("name")!.description
    
    }

    // MARK: - Fetched results controller

    //画面がロードするたびにデータを取得する
    var fetchedResultsController: NSFetchedResultsController {
        //すでにオブジェクトが存在していればオブジェクトを返却して処理終了
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        //以下は初めてアプリにアクセスした時の処理
        //フェッチリクエストオブジェクトの生成
        let fetchRequest = NSFetchRequest()
        
        //エンティティ記述を取得
        let entity = NSEntityDescription.entityForName("Person", inManagedObjectContext: self.managedObjectContext!)
        fetchRequest.entity = entity
      
        //1度に取得するデータのサイズを指定
        fetchRequest.fetchBatchSize = 20
        
        //データの並び順を設定
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "Master")
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        //データの読み込みを実行
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
             print("Unresolved error")
             abort()
        }
        
        return _fetchedResultsController!
    }    
    var _fetchedResultsController: NSFetchedResultsController? = nil

    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }

    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
            case .Insert:
                self.tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
            case .Delete:
                self.tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
            default:
                return
        }
    }

    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
            case .Insert:
                tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
            case .Delete:
                tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            case .Update:
                self.configureCell(tableView.cellForRowAtIndexPath(indexPath!)!, atIndexPath: indexPath!)
            case .Move:
                tableView.moveRowAtIndexPath(indexPath!, toIndexPath: newIndexPath!)
        }
    }

    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }

    //SearchController
    func updateSearchResultsForSearchController(searchController: UISearchController) {
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        let managedObjectContext = appDelegate.managedObjectContext
//        let entityDiscription = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedObjectContext)
//        let fetchRequest = NSFetchRequest()
//        fetchRequest.entity = entityDiscription
//        
        //要件全て削除
        //self.filteredMovies.removeAll(keepCapacity:false)
        
        //要件検索(不完全一致)
        //let predicate = NSPredicate(format: "name CONTAINS %@",searchController.searchBar.text!)
        searchPredicate = NSPredicate(format: "name CONTAINS %@",searchController.searchBar.text!)
        //fetchRequest.predicate = predicate
        filteredObjects = self.fetchedResultsController.fetchedObjects?.filter(){
            return self.searchPredicate!.evaluateWithObject($0)
        } as! [Person]?
        
        self.tableView.reloadData()
        print(searchPredicate)
        
       // let array = (self.movies as NSArray).filteredArrayUsingPredicate(predicate)
//        let array = (self.contancts as NSArray).filteredArrayUsingPredicate(predicate)
//        self.searchResults = array as! [Person]
//        //rsearchResults.removeAll()
//
//        
//        do{
//            //Hitしたデータを引っ張り
//            let results = try managedObjectContext.executeFetchRequest(fetchRequest)
//            for managedObjectContext in results {
//                print("managed:\(managedObjectContext)")
//                let model = managedObjectContext as? Person
//                print("model:\(model!.name!)")
//                
//                let array = (self.movies as NSArray).filteredArrayUsingPredicate(predicate)
//                print("array:\(array)")
//                self.filteredMovies = array as! [Person]
//                
//                
//                movies = self.predicate.
//               // let array = (self.movies as NSArray).filteredArrayUsingPredicate(predicate)
//                //self.filteredMovies = array as! [Person]
//                
//                print("該当あり\(model?.name)")
//                //searchResults.append(model?.name)
//                print(self.filteredMovies)
//
//            }
//        }catch{
//            print("該当なし")
//            abort()
//            
//        }
//        self.tableView.reloadData()
//        //let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        //        let managedObjectContext = appDelegate.managedObjectContext
//        //
//        //        //EntityDescriptionのインスタンス
//        //        let entityDiscription = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedObjectContext)
//        //
//        //        //NSFetchRequest SQLのSelect
//        //
//        //
//        //        let fetchRequest = NSFetchRequest()
//        //        fetchRequest.entity = entityDiscription
//        //
//        //        //NSPreficate SQLのWhere
//        //        let predicate = NSPredicate(format: "%K = %@","name",searchText)
//        //        fetchRequest.predicate = predicate
//        //
//        //        do{
//        //            searchResults.removeAll()
//        //            let results = try managedObjectContext.executeFetchRequest(fetchRequest)
//        //            for managedObjectContext in results {
//        //                let model = managedObjectContext as? Person
//        //                print("該当あり\(model!.name)")
//        //                searchResults.append((model?.name)!)
//        //                print(searchResults)
//        //                self.tableView.reloadData()
//        //            }
//        //        }catch{
//        //            print("該当なし")
//        //            searchResults.removeAll()
//        //            abort()
//        //        }
//        //        
//        //        print(searchResults)
//        //
//    }
    }
}

