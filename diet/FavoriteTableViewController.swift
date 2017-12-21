//
//  FavoriteTableViewController.swift
//  diet
//
//  Created by 이예린 on 2017. 11. 27..
//  Copyright © 2017년 Yerin. All rights reserved.
//

import UIKit
import CoreData

class FavoriteTableViewController: UITableViewController {
    
    //var Menu:[String] = ["리코타치즈","야채샐러드","소고기샐러드"]
    var menu: [NSManagedObject] = []
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let context = self.getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
        
        do {
            menu = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return menu.count
    }

    
    //테이블에 이미지와 타이틀, 칼로리를 표시해준다.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Favorite Cell", for: indexPath) as! MenuCell
        
        let recipy = menu[indexPath.row]

        if let titleLabel = recipy.value(forKey: "title") as? String{
            print("title : " + titleLabel)
            cell.menu_title.text = titleLabel
        }
        if let kcalLabel = recipy.value(forKey: "kcal") as? Int{
            cell.menu_kcal.text = String(kcalLabel) + "kcal"
        }
        if let imgLabel = recipy.value(forKey: "img") as? String{
            let image = UIImage(named: imgLabel)
            cell.menu_img.image = image
        }
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    //셀을 삭제하며 데이터베이스의 튜플도 삭제한다.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            //데이터 삭제
            let context = getContext()
            context.delete(menu[indexPath.row])
            do{
                try context.save()
                print("deleted!")
            }catch let error as NSError{
                print("Could not delete \(error)")
            }
            
            menu.remove(at: indexPath.row)
            
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailRecipy2" {
            if let destination = segue.destination as? RecipeViewController {
                if let selectedIndex = self.tableView.indexPathsForSelectedRows?.first?.row {
                    
                    //title과 칼로리 종류 정보를 RecipeViewController에 보낸다
                    typealias cellform = (title:String, kcal:Int,img:String)
                    var detailRecipe:cellform = ("0",0,"")
                    
                    let recipy = menu[selectedIndex]
                    
                    if let titleLabel = recipy.value(forKey: "title") as? String{
                        detailRecipe.title = titleLabel
                        destination.title = titleLabel
                    }
                    if let kcalLabel = recipy.value(forKey: "kcal") as? Int{
                        detailRecipe.kcal = kcalLabel
                    }
                    if let imgLabel = recipy.value(forKey: "img") as? String{
                        detailRecipe.img = imgLabel
                    }
                    if let kindLabel = recipy.value(forKey: "kind") as? String{
                        destination.kindOf = kindLabel
                    }
                    
                    destination.detailRecipe = detailRecipe
                }
            }
        }
    }
    

}
