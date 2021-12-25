//
//  ColorViewController.swift
//  HW22
//
//  Created by Dmitrii Onegin on 25.12.2021.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setNewColor(uiColor: UIColor)
}

class ColorViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.uiColor = view.backgroundColor
        settingsVC.delegate = self
    }
}

extension ColorViewController: SettingsViewControllerDelegate {
    func setNewColor(uiColor: UIColor) {
        view.backgroundColor = uiColor
    }
}
