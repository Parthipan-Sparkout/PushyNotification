//
//  ViewController.swift
//  PushyNotification
//
//  Created by Mac on 12/07/22.
//

import UIKit
import Alamofire
import Pushy

class ViewController: UIViewController {
    @IBOutlet weak var notificationBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        notificationBtn.layer.cornerRadius = 10
        notificationBtn.layer.masksToBounds = false
        print(AppDelegate.deviceToken)
       // configurePushy()
        notificationBtn.addTarget(self, action: #selector(sendNofifycation), for: .touchUpInside)
    }
    
    
    @objc func sendNofifycation() {
        self.showSpinner(onView: self.view)
        if AppDelegate.deviceToken != "" {
            sendNotificationApi()
        }else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.sendNotificationApi()
            }
        }
    }
  
    func sendNotificationApi() {
        let parameters = ["device_token": AppDelegate.deviceToken]
        AF.request("https://api.yahalatalabat.com/api/pushy_test", method: .post, parameters: parameters, encoder: .json).response { data in
            self.removeSpinner()
            switch data.result {
            case .success(let value):
                print("Notification sent successfully",value)
            case .failure(_):
                print("Notification sent not successfully")
            }
        }
    }
}

