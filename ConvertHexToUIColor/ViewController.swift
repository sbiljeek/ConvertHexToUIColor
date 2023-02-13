//
//  ViewController.swift
//  ConvertHexToUIColor
//
//  Created by Salman Biljeek on 2/12/23.
//

import UIKit

class ViewController: UIViewController {
    
    let hexString: String = "#dc4189"
    
    lazy var hexLabel: UILabel = {
        let label = UILabel()
        label.text = self.hexString
        label.font = .boldSystemFont(ofSize: 40)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 80).isActive = true
        return label
    }()
    
    let uiColorView: UIView = {
        let view = UILabel()
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 80).isActive = true
        view.heightAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        let uiColor = self.hexToUIColor(hex: self.hexString)
        uiColorView.backgroundColor = uiColor
        
        let convertLabel: UILabel = {
            let label = UILabel()
            label.text = "Convert"
            label.textColor = .label.withAlphaComponent(0.8)
            label.font = .systemFont(ofSize: 40, weight: .heavy)
            return label
        }()
        
        let toLabel: UILabel = {
            let label = UILabel()
            label.text = "to"
            label.textColor = .secondaryLabel
            label.font = .systemFont(ofSize: 24, weight: .heavy)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.heightAnchor.constraint(equalToConstant: 80).isActive = true
            return label
        }()
        
        let hexTitleLabel: UILabel = {
            let label = UILabel()
            label.text = "Hex"
            label.textColor = .secondaryLabel
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 24, weight: .regular)
            return label
        }()
        
        let uiColorTitleLabel: UILabel = {
            let label = UILabel()
            label.text = "UIColor"
            label.textColor = .secondaryLabel
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 24, weight: .regular)
            return label
        }()
        
        let headingStack = UIStackView(arrangedSubviews: [
            hexTitleLabel,
            uiColorTitleLabel
        ])
        headingStack.axis = .horizontal
        headingStack.spacing = 80
        headingStack.alignment = .center
        
        let hexStack = UIStackView(arrangedSubviews: [
            hexTitleLabel,
            hexLabel
        ])
        hexStack.axis = .vertical
        hexStack.spacing = 6
        hexStack.alignment = .center
        
        let uiColorStack = UIStackView(arrangedSubviews: [
            uiColorTitleLabel,
            uiColorView
        ])
        uiColorStack.axis = .vertical
        uiColorStack.spacing = 6
        uiColorStack.alignment = .center
        
        let bottomStack = UIStackView(arrangedSubviews: [
            hexStack,
            toLabel,
            uiColorStack
        ])
        bottomStack.axis = .horizontal
        bottomStack.spacing = 30
        bottomStack.alignment = .bottom
        
        let mainStack = UIStackView(arrangedSubviews: [
            convertLabel,
            bottomStack
        ])
        mainStack.axis = .vertical
        mainStack.spacing = 15
        mainStack.alignment = .center
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(mainStack)
        mainStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        mainStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        mainStack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -60).isActive = true
    }
    
    func hexToUIColor(hex: String) -> UIColor {
        var hexString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (hexString.hasPrefix("#")) {
            hexString.remove(at: hexString.startIndex)
        }
        
        if ((hexString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

