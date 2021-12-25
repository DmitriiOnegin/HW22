//
//  ViewController.swift
//  HW22
//
//  Created by Dmitrii Onegin on 12.12.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var redCountLabel: UILabel!
    @IBOutlet weak var greenCountLabel: UILabel!
    @IBOutlet weak var blueCountLabel: UILabel!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    var uiColor: UIColor!
    var delegate: SettingsViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLoadSlider()
        setLoadTextLabel()
        setLoadTextField()
        setColorView()
    }
    
    @IBAction func DoneButtonPressed() {
        uiColor = colorView.backgroundColor
        delegate.setNewColor(uiColor: uiColor)
        dismiss(animated: true)
    }
    
    @IBAction func redSliderAction() {
        setColorView()
        redCountLabel.text = string(from: redSlider)
        redTextField.text = string(from: redSlider)
    }
    
    @IBAction func greenSliderAction() {
        setColorView()
        greenCountLabel.text = string(from: greenSlider)
        greenTextField.text = string(from: greenSlider)
    }
    
    @IBAction func blueSliderAction() {
        setColorView()
        blueCountLabel.text = string(from: blueSlider)
        blueTextField.text = string(from: blueSlider)
    }
    
    
}

// MARK: - Private Methods
extension SettingsViewController {
    
    private func setLoadSlider() {
        guard let redValues = uiColor.cgColor.components?[0] else {return}
        guard let greenValue = uiColor.cgColor.components?[1] else {return}
        guard let blueValue = uiColor.cgColor.components?[2] else {return}
        
        redSlider.setValue(Float(redValues), animated: true)
        greenSlider.setValue(Float(greenValue), animated: true)
        blueSlider.setValue(Float(blueValue), animated: true)
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
    }
    
    private func setLoadTextLabel() {
        redCountLabel.text = string(from: redSlider)
        greenCountLabel.text = string(from: greenSlider)
        blueCountLabel.text = string(from: blueSlider)
    }
    
    private func setLoadTextField() {
        redTextField.text = string(from: redSlider)
        greenTextField.text = string(from: greenSlider)
        blueTextField.text = string(from: blueSlider)
    }
        
    private func setColorView() {
        let redSliderValue = CGFloat(redSlider.value)
        let greenSliderValue = CGFloat(greenSlider.value)
        let blueSliderValue = CGFloat(blueSlider.value)
        
        colorView.backgroundColor = UIColor(red: redSliderValue, green: greenSliderValue, blue: blueSliderValue, alpha: 1)
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}

// MARK: - TextField
extension SettingsViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        guard let numberValue = Float(newValue) else {
            
            switch textField {
            case redTextField:
                textField.text = redCountLabel.text
            case greenTextField:
                textField.text = greenCountLabel.text
            default:
                textField.text = blueCountLabel.text
            }
            
            showAlert(title: "Не корректное значение", message: "Диаппазон значений от 0 до 1", textField: textField)
            
            return
           
        }
        
        switch numberValue {
        case ...0:
            showAlert(title: "Не корректное значение", message: "Минимальное значение 0", textField: textField)
            textField.text = "0"
        case 0 ... 1:
            break
        default:
            showAlert(title: "Не корректное значение", message: "Максимальное значение 1", textField: textField)
            textField.text = "1"
        }
        
        switch textField {
        case redTextField:
            redSlider.setValue(numberValue, animated: true)
            redCountLabel.text = string(from: redSlider)
        case greenTextField:
            greenSlider.setValue(numberValue, animated: true)
            greenCountLabel.text = string(from: greenSlider)
        default:
            blueSlider.setValue(numberValue, animated: true)
            blueCountLabel.text = string(from: blueSlider)
        }
        setColorView()
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

// MARK: - Alert Controller
extension SettingsViewController {
    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
           
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

