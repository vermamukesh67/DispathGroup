//
//  ViewController.swift
//  DispathGroup
//
//  Created by verma mukesh on 7/12/21.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        self.callApi(url: "https://reqres.in/api/products/2", completionHandler: {
            DispatchQueue.main.async {
                dispatchGroup.leave()   // <<----
            }
        })
        dispatchGroup.enter()
        self.callApi(url: "https://reqres.in/api/products/3", completionHandler: {
            DispatchQueue.main.async {
                dispatchGroup.leave()   // <<----
            }
        })
        dispatchGroup.notify(queue: .main) {
               print("both api get call and notified")
        }
    }
}
extension ViewController {
    func callApi(url: String, completionHandler: @escaping (() -> Void)) {
        let url = URL(string: url)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if data != nil {
                print("success for ", url)
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
            completionHandler()
        }
        task.resume()
    }
}

