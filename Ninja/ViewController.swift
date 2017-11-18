//
//  ViewController.swift
//  Ninja
//
//  Created by Martin Stålberg on 2017-11-18.
//  Copyright © 2017 Arbitrage Acolytes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private var myLabel: UILabel!
    
    @IBOutlet private var myButton: UIButton!
    
    @IBOutlet var myNinjaButton: UIButton!
    
    @IBOutlet var myImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = UIColor.orange;
    }

    @IBAction func myButtonTapped(_ sender: UIButton) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .medium
        dateFormatter.locale = Locale(identifier: "sv_SE")
        
        var calendar = Calendar(identifier: .gregorian)

        guard let timeZone = TimeZone(secondsFromGMT: 3600) else {
            fatalError("timeZone was nil")
        }
        
        calendar.timeZone = timeZone
        dateFormatter.calendar = calendar

        let date: Date = Date()
        myLabel.text = dateFormatter.string(from: date)
    }
    
    @IBAction func ninjaButtonTapped(_ sender: Any) {
        let url = URL(string: "http://thecatapi.com/api/images/get?format=src")!
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data else {
                // TODO error handling
                print("error?")
                return
            }
            
            print("Has data! length: \(data.count)")
            
            DispatchQueue.main.async {
                self?.myImageView.image = UIImage(data: data)
            }
        }
        
        dataTask.resume()
    }
}
