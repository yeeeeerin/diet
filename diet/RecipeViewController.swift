//
//  RecipeViewController.swift
//  diet
//
//  Created by 이예린 on 2017. 11. 27..
//  Copyright © 2017년 Yerin. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {
    
    typealias cellform = (title:String, kcal:Int)
    //RecipyListTableViewController에서 받은 값
    var detailRecipe:cellform = ("init",0);
    
    @IBOutlet var mainImg: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
         let image = UIImage(named: "y1.png") //선택한 레시피와 맞는 이미지 셋팅
        mainImg.image = image

        // Do any additional setup after loading the view.
    }



}
