//
//  MainViewController.swift
//  diet
//
//  Created by 이예린 on 2017. 11. 27..
//  Copyright © 2017년 Yerin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toListView" {
            let destVC = segue.destination as! RecipyListTableViewController
            
            let button = sender as! UIButton
            destVC.title = button.titleLabel?.text
            
            destVC.seg_kind_of = (button.titleLabel?.text)!;

            
            
        }
    }

}
