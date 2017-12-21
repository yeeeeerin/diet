//
//  RecipeViewController.swift
//  diet
//
//  Created by 이예린 on 2017. 11. 27..
//  Copyright © 2017년 Yerin. All rights reserved.
//

import UIKit
import CoreData

class RecipeViewController: UIViewController {
    //모든 메뉴
    
    
    typealias cellform = (title:String, kcal:Int)
    //RecipyListTableViewController에서 받은 값
    var detailRecipe:cellform = ("init",0)
    var kindOf:String = ""
    
    @IBOutlet var mainImg: UIImageView!
    @IBOutlet var favoritBtn: UIButton!
    
    
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //만약 즐겨찾기에서 넘어왔을 경우 즐겨찾기 추가하기 변수는 안보인다.
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
         let image = UIImage(named: "y1.png") //선택한 레시피와 맞는 이미지 셋팅
        mainImg.image = image
        if(kindOf == "반찬"){
            sidedishSearch()
        }else if(kindOf == "샐러드"){
            saladeSearch()
            
        }else if(kindOf == "국"){
            soupSearch()
            
        }else if(kindOf == "디저트"){
            dessertSearch()
        }
       
    }
    
    func sidedishSearch(){
        
    }
    func saladeSearch(){
        
    }
    func dessertSearch(){
        
    }
    func soupSearch(){
        
    }
    
    //즐겨찾기 추가를 눌렀을 때 해당되는 페이지 저장
    @IBAction func addFavorite() {
        
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Favorite", in: context)
        
        // Favorite record를 새로 생성함
        let object = NSManagedObject(entity: entity!, insertInto: context)
        object.setValue(kindOf, forKey: "kind")
        object.setValue(detailRecipe.title, forKey: "title")
        object.setValue(detailRecipe.kcal, forKey: "kcal")
        print(detailRecipe.title + "  " + kindOf + "   " + (String)(detailRecipe.kcal))
        
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    



}
