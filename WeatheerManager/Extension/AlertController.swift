//
//  AlertController.swift
//  WeatheerManager
//
//  Created by David Khachidze on 22.09.2022.
//

import UIKit

extension ViewController {
    
    func presentAlertController(withTitle title: String?, message: String?, style: UIAlertController.Style, complition: @escaping(String) -> Void) {
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        ac.addTextField()
        
        let search = UIAlertAction(title: "Search", style: .default) { action in
            let textField = ac.textFields?.first
            guard let cityName = textField?.text else { return }
            if cityName != "" {
                let city = cityName.split(separator: " ").joined(separator: "%20")
                complition(city)
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(search)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
    }
    

    
}
