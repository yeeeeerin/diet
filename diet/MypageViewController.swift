//
//  MypageViewController.swift
//  diet
//
//  Created by 이예린 on 2017. 11. 27..
//  Copyright © 2017년 Yerin. All rights reserved.
//

import UIKit
import CoreData

class MypageViewController: UIViewController,UITextFieldDelegate {
    

    @IBOutlet var name: UITextField!    //이름을 받을 변수
    @IBOutlet var age: UITextField!     //나이를 받을 변수
    @IBOutlet var tall: UITextField!    //신장을 받을 변수
    @IBOutlet var weight: UITextField!  //몸무게를 받을 변수
    @IBOutlet var bmi: UITextField!     //비만도를 저장할 변수
    @IBOutlet var talk: UITextField!    //다짐을 저장할 변수
    

    
    var myInfo: [NSManagedObject] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //core 데이터 가져오기
        let context = self.getContext()
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MyInfo")
        do {
            //가져온 데이터의 수가 0일 때 새로 생성한다.
            if(try context.count(for: fetchRequest) == 0){
                //entity 새로 생성
                let entity = NSEntityDescription.entity(forEntityName: "MyInfo", in: context)
                // 내정보 record를 새로 생성함
                let object = NSManagedObject(entity: entity!, insertInto: context)
                
                
                
                //object.setValue(sex., forKey: "sex")
                
                object.setValue(" ", forKey: "name")
                object.setValue(" ", forKey: "talk")
                object.setValue(00, forKey: "age")
                object.setValue(00, forKey: "tall")
                object.setValue(00, forKey: "weight")
                object.setValue(00, forKey: "bmi")
                
                
                // 객체 저장 하기
                do {
                    try context.save()
                    print("saved!")
                } catch let error as NSError {
                    print("Could not save \(error), \(error.userInfo)")
                } catch {
                }
                
            }
            
            //view가 실행 되기 전 값을 저장한다.
            myInfo = try context.fetch(fetchRequest)
                
            //name
            self.name.text = myInfo[0].value(forKey: "name") as? String
            
            self.talk.text = myInfo[0].value(forKey: "talk") as? String
            
            let mage:Int = myInfo[0].value(forKey: "age") as! Int
            self.age.text = String(mage)
            
            let mtall:Int = (myInfo[0].value(forKey: "tall") as? Int)!
            self.tall.text = String(mtall)
            
            let mweight:Int = (myInfo[0].value(forKey: "weight") as? Int)!
            self.weight.text = String(mweight)
                
            let mbmi:Int = (myInfo[0].value(forKey: "bmi") as? Int)!
            self.bmi.text = String(mbmi)
            
            
            
                
            
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    
    //나이와 몸무게 신장은 숫자만 입력할 수 있도록 한다.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if (textField == age) || (textField == weight) || (textField == tall){
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
    
    
    
    
    @IBAction func editText(_ sender: UITextField) {
    
        
        let mAge:String = age.text!;
        let mTall:String = tall.text!;
        let mWeight:String = weight.text!;
        var mBmi:Float = 0.0;
        
        
        
        //core 데이터 가져오기
        let context = self.getContext()
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MyInfo")
        do {
            //데이터를 수정한다..
            if(try context.count(for: fetchRequest) != 0){
                myInfo = try context.fetch(fetchRequest)
                
                if(sender == name){
                    myInfo[0].setValue(sender.text,forKey:"name")
            
                }else if(sender == age){
                    
                    myInfo[0].setValue(Int(sender.text!),forKey:"age")
                    
                }else if(sender == tall){
                    myInfo[0].setValue(Int(sender.text!),forKey:"tall")
                    
                }else if(sender == weight){
                    myInfo[0].setValue(Int(sender.text!),forKey:"weight")
                    
                }else if(sender == talk){
                    myInfo[0].setValue(sender.text,forKey:"talk")
                }
                

                //나이, 신장, 몸무게 정보가 들어가 있다면 bmi를 계산한다.
                if((mAge.isEmpty != true) && (mTall.isEmpty != true) && (mWeight.isEmpty != true)){
                    mBmi = calcBMI(tall: mTall,weight: mWeight);
                    myInfo[0].setValue(Float(mBmi),forKey:"bmi")
                    bmi.text = String(mBmi)
                }
                
                // 객체 저장 하기
                do {
                    try context.save()
                    print("saved!")
                } catch let error as NSError {
                    print("Could not save \(error), \(error.userInfo)")
                } catch {
                }
                
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        
        
        
 
    }
    

    

    func calcBMI(tall:String,weight:String) -> Float {
        let mBmi:Float = Float(weight)! / (Float(tall)!/100 * Float(tall)!/100)
        return mBmi;
    }
    

    func getContext () -> NSManagedObjectContext {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer.viewContext
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

}
