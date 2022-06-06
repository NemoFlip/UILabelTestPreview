//
//  UITextFieldViewController.swift
//  UILabelTestPreview
//
//  Created by Артем Хлопцев on 06.06.2022.
//

import UIKit

class UITextFieldViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "TextField"
        
        let tabBarItem = UITabBarItem(title: "UITextField", image: UIImage(systemName: "textformat.abc"), selectedImage: nil)
        self.tabBarController?.tabBar.tintColor = .white
        self.tabBarItem = tabBarItem
        self.view.backgroundColor = .systemTeal
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
