//
//  RegisterViewController.swift
//  IOS_POSTTRAINING
//
//  Created by prk on 18/08/23.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        // Do any additional setup after loading the view.
    }
    
    var context: NSManagedObjectContext!
    @IBOutlet var usernameTxt: UITextField!
    @IBOutlet var passwordTxt: UITextField!
    @IBOutlet var confirmPasswordTxt: UITextField!
    
    @IBAction func registerBtnOnClick(_ sender: Any) {
        // TODO: Ambil value dari text input
        // TODO: Get entity
        // TODO: Input to the core data
        
        let username = usernameTxt.text!
        let password = passwordTxt.text!
        let confirmPassword = confirmPasswordTxt.text!
        
        // isEmpty, .count, ==
        if(username.isEmpty || password.isEmpty){
            print("Username and Password must be filled")
            return
        }
        
        if(password != confirmPassword){
            print("Password is not the same")
            return
        }
        
        let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        newUser.setValue(username, forKey: "username")
        newUser.setValue(password, forKey: "password")
        
        do {
            try context.save()
            print("Register Success")
        }
        catch {
            print("Register Failed")
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
