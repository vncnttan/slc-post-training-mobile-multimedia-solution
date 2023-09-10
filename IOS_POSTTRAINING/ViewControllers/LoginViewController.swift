//
//  LoginViewController.swift
//  IOS_POSTTRAINING
//
//  Created by prk on 18/08/23.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    var context: NSManagedObjectContext!
    @IBOutlet var usernameTxt: UITextField!
    @IBOutlet var passwordTxt: UITextField!
    
    
    @IBAction func loginBtn(_ sender: Any) {
        let username = usernameTxt.text!
        let password = passwordTxt.text!
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.predicate = NSPredicate(format: "username == %@ AND password == %@", username, password)
        
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            if (result.count == 0) {
                print("Invalid User")
                return
            }
            
            if let nextView = storyboard?.instantiateViewController(identifier: "HomeViewController"){
                navigationController?.setViewControllers([nextView], animated: true)
            }

            print("Login success")
        }
        catch {
            print("Request Failed")
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
