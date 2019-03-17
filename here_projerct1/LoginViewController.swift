//
//  LoginViewController.swift
//  here_projerct1
//
//  Created by mat4645 on 2019/03/17.
//  Copyright © 2019 MAT0622. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class LoginViewController: UITabBarController {
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func getLogin(_ sender: Any) {
        let URL = "https://hereeee.herokuapp.com/event/index"
        let headers: HTTPHeaders = [
            "Contenttype": "application/json"
        ]
        Alamofire.request(URL, method: .get)
            .responseJSON { response in
                
                
    }
    
    
}
}
