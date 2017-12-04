//
//  MenuTableViewController.swift
//  diet
//
//  Created by 이예린 on 2017. 11. 27..
//  Copyright © 2017년 Yerin. All rights reserved.
//

import UIKit

class RecipyListTableViewController: UITableViewController {
    
    //음식 이름 : 칼로리
    typealias cellform = (title:String, kcal:Int)
    var menu:[cellform] = [];
    
    var seg_kind_of:String = "" // MainViewController에서 받은 분류값


    override func viewDidLoad() {
        super.viewDidLoad()
        addMenu()
        
    }
    
    func addMenu(){
        if seg_kind_of == "반찬"{
            menu = [("취나물 무침",56),
                    ("ㅗㅗ",600),
                    ("ggg",800),
                    ("ggg",200)]
        }
        if seg_kind_of == "샐러드"{
            menu = [("샐러드",56),
                    ("ㅇㅇ",600),
                    ("gㄹㄹg",800),
                    ("ggg",200)]
        }
        if seg_kind_of == "국"{
            menu = [("북억구",56),
                    ("ㄴㅇㄹ",600),
                    ("gㄴㅇㄹㅁ",800),
                    ("ggg",200)]
        }
        if seg_kind_of == "디저트" {
            menu = [("디졑",56),
                    ("ㄴㅇㄹㄴ",600),
                    ("ㅁㄴㅇㄹㅁ",800),
                    ("gㅇㅇ",200)]
            
        }
    }



    override func numberOfSections(in tableView: UITableView) -> Int {
 
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return menu.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Menu Cell", for: indexPath) as! MenuCell

        cell.menu_title.text = menu[indexPath.row].title
        cell.menu_kcal.text = menu[indexPath.row].kcal.description + "kcal"
        
        
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
        
        if segue.identifier == "toDetailRecipy" {
            if let destination = segue.destination as? RecipeViewController {
                if let selectedIndex = self.tableView.indexPathsForSelectedRows?.first?.row {
                    
                    destination.detailRecipe = menu[selectedIndex]
                    destination.title = menu[selectedIndex].title
                    
                    
                }
            }
        }
        
    }
    

}
