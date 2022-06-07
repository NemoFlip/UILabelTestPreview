//
//  UILabelViewController.swift
//  UILabelTestPreview
//
//  Created by Артем Хлопцев on 06.06.2022.
//

import UIKit

class UILabelViewController: UIViewController {
    let mainTextLabel = UILabel()
    let fontSizeSlider = UISlider()
    let colorPicker = UIPickerView()
    let fontPicker = UIPickerView()
    let numberOfLinesPicker = UIPickerView()
    let shadowPicker = UIPickerView()
    let shadowSwitch = UISwitch()
    let wordWrapSwitch = UISwitch()
    let shadowLabel = UILabel()
    let wordWrapLabel = UILabel()
    let pickerColors = [("White", UIColor.white), ("Black", UIColor.black), ("Blue", UIColor.blue), ("Pink", UIColor.systemPink), ("Teal", UIColor.systemTeal), ("Red", UIColor.red), ("Purple", UIColor.purple)]
    let pickerFonts = UIFont.familyNames
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "Background")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonAlert))
        self.navigationItem.rightBarButtonItem?.tintColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationItem.title = "UILabel"
        let tabBarItem = UITabBarItem(title: "UILabel", image: UIImage(systemName: "doc.plaintext.fill"), selectedImage: nil)
        self.tabBarController?.tabBar.tintColor = .white
        self.tabBarItem = tabBarItem
        
        createLabel()
        createFontSlider()
        createPicker(xCoord: 20, yCoord: 380, picker: colorPicker)
        createPicker(xCoord: Int(UIScreen.main.bounds.maxX) - 150, yCoord: 380, picker: fontPicker)
        createPicker(xCoord: 20, yCoord: 480, picker: numberOfLinesPicker)
        createPicker(xCoord: Int(UIScreen.main.bounds.maxX) - 150, yCoord: 480, picker: shadowPicker)
        createSwitchRow(label: shadowLabel, labelText: "Shadow", mySwitch: shadowSwitch, yOffset: 180)
        createSwitchRow(label: wordWrapLabel, labelText: "Word wrap", mySwitch: wordWrapSwitch, yOffset: 230)
        shadowSwitch.addTarget(self, action: #selector(shadowSwitchAction), for: .valueChanged)
        wordWrapSwitch.addTarget(self, action: #selector(wordWrappingSwitchAction), for: .valueChanged)
    }
    fileprivate func createLabel() {
        mainTextLabel.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 80, height: 120)
        mainTextLabel.center = CGPoint(x: self.view.center.x, y: self.view.center.y - 250)
        mainTextLabel.numberOfLines = 0
        mainTextLabel.textColor = .white
        mainTextLabel.textAlignment = .center
        mainTextLabel.shadowOffset = CGSize(width: 3, height: 3)
        mainTextLabel.font = mainTextLabel.font.withSize(CGFloat(fontSizeSlider.value))
        self.view.addSubview(mainTextLabel)
    }
    fileprivate func createPicker(xCoord: Int, yCoord: Int, picker: UIPickerView) {
        picker.frame = CGRect(x: xCoord, y: yCoord, width: 120, height: 80)
        picker.dataSource = self
        picker.delegate = self
        picker.setValue(UIColor.white, forKey: "textColor")
        self.view.addSubview(picker)
    }
    fileprivate func createFontSlider() {
        fontSizeSlider.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 100, height: 50)
        fontSizeSlider.minimumValue = 8
        fontSizeSlider.maximumValue = 120
        fontSizeSlider.addTarget(self, action: #selector(fontSliderChanged), for: .valueChanged)
        fontSizeSlider.center = CGPoint(x: self.view.center.x, y: self.view.center.y - 100)
        self.view.addSubview(fontSizeSlider)
    }
    fileprivate func createSwitchRow(label: UILabel, labelText: String, mySwitch: UISwitch, yOffset: CGFloat) {
        label.text = labelText
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        label.frame = CGRect(x: 20, y: UIScreen.main.bounds.midY + yOffset, width: UIScreen.main.bounds.width - 90, height: 50)
        self.view.addSubview(label)
        mySwitch.frame = CGRect(x: UIScreen.main.bounds.width - 80, y: UIScreen.main.bounds.midY + yOffset + 8, width: 0, height: 0)
        self.view.addSubview(mySwitch)
    }
    @objc func fontSliderChanged() {
        self.mainTextLabel.font = mainTextLabel.font.withSize(CGFloat(fontSizeSlider.value))
    }
    @objc func addButtonAlert() {
        let alertController = UIAlertController(title: "Add Text", message: "Please, type some text to format it", preferredStyle: .alert)
        let alertButton = UIAlertAction(title: "Done", style: .default) { act in
            self.mainTextLabel.text = alertController.textFields?.first?.text ?? ""
        }
        alertController.addAction(alertButton)
        alertController.addTextField(configurationHandler: nil)
        self.present(alertController, animated: true, completion: nil)
    }
    @objc func shadowSwitchAction() {
        self.mainTextLabel.shadowColor = shadowSwitch.isOn ? pickerColors[shadowPicker.selectedRow(inComponent: 0)].1 : nil
    }
    @objc func wordWrappingSwitchAction() {
        self.mainTextLabel.lineBreakMode = wordWrapSwitch.isOn ? .byWordWrapping : .byCharWrapping
    }
    
}

extension UILabelViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == fontPicker {
            return pickerFonts.count
        } else if pickerView == numberOfLinesPicker {
            return 3
        } else {
            return pickerColors.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == fontPicker {
            return pickerFonts[row]
        } else if pickerView == numberOfLinesPicker {
            return "\(row + 1)"
        } else {
            return pickerColors[row].0
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == colorPicker {
            self.mainTextLabel.textColor =  pickerColors[row].1
        } else if pickerView == fontPicker {
            self.mainTextLabel.font = UIFont(name: pickerFonts[row], size: CGFloat(fontSizeSlider.value))
        } else if pickerView == numberOfLinesPicker {
            self.mainTextLabel.numberOfLines = row + 1
        } else {
            self.mainTextLabel.shadowColor = pickerColors[row].1
            self.shadowSwitch.setOn(true, animated: true)
        }
    }
    
    
}
