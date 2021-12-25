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
    
    @IBOutlet weak var RedTextField: UITextField!
    @IBOutlet weak var GreenTextField: UITextField!
    @IBOutlet weak var BlueTextField: UITextField!
    
    var uiColor: UIColor!
    var delegate: SettingsViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLoadSlider()
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
    }
    
    @IBAction func greenSliderAction() {
        setColorView()
        greenCountLabel.text = string(from: greenSlider)
    }
    
    @IBAction func blueSliderAction() {
        setColorView()
        blueCountLabel.text = string(from: blueSlider)
    }
    
    
    
    private func setLoadSlider() {
        guard let redValues = uiColor.cgColor.components?[0] else {return}
        guard let greenValue = uiColor.cgColor.components?[1] else {return}
        guard let blueValue = uiColor.cgColor.components?[2] else {return}
        
        redSlider.setValue(Float(redValues), animated: true)
        greenSlider.setValue(Float(greenValue), animated: true)
        blueSlider.setValue(Float(blueValue), animated: true)
        
        setTextLabel()
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
    }
    
    private func setTextLabel() {
        redCountLabel.text = string(from: redSlider)
        greenCountLabel.text = string(from: greenSlider)
        blueCountLabel.text = string(from: blueSlider)
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

