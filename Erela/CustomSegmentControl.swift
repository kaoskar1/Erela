//
//  CustomSegmentControl.swift
//  Erela
//
//  Created by oskarGuest on 2017-07-14.
//  Copyright © 2017 oskar ljungdahl. All rights reserved.
//

import UIKit

@IBDesignable

class CustomSegmentControl: UIControl {
    var buttons =  [UIButton]()
    var selector: UIView!
    var selectedSegmentIndex = 0
    

    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet{
         layer.borderWidth = borderWidth
        }
    }
   
    @IBInspectable
    var borderColor: UIColor = UIColor.clear {
        didSet{
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable
    var commaSeparatedButtonTiles: String = "" {
        didSet{
            updateView()
        }
    
    
    }
    
    
    @IBInspectable
    var textColor: UIColor = .lightGray{
        didSet{
            updateView()
        }
    }
    
    @IBInspectable
    var selectorColor: UIColor = .darkGray {
        didSet{
            updateView()
        }
    }
    
    
    @IBInspectable
    var selctorTextColor: UIColor = .white {
        didSet{
            updateView()
        }
    }
    
    func updateView(){
       
        buttons.removeAll()
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        
        let buttonTitles = commaSeparatedButtonTiles.components(separatedBy: ",")
        
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.setTitleColor(textColor, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
            buttons.append(button)
        
        }
        
        buttons[0].setTitleColor(selctorTextColor, for: .normal)
        
       let  selectorWidth = frame.width / CGFloat(buttonTitles.count)
        selector = UIView(frame: CGRect(x: 0, y: 0, width: selectorWidth, height: frame.height))
        selector.layer.cornerRadius = frame.height / 2
        selector.backgroundColor = selectorColor
        addSubview(selector)
        
        
        let sv = UIStackView(arrangedSubviews: buttons)
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillProportionally
        addSubview(sv)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        sv.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        sv.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        sv.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.height/2
    }
    
    
    func buttonTapped(button: UIButton){
        
        for (buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            
            if btn == button {
                selectedSegmentIndex = buttonIndex
               let selectorStartPostions = frame.width/CGFloat(buttons.count) * CGFloat(buttonIndex)
                btn.setTitleColor(selctorTextColor, for: .normal)
                    UIView.animate(withDuration: 0.3, animations: { 
                        self.selector.frame.origin.x = selectorStartPostions
                    })
                btn.setTitleColor(selctorTextColor, for: .normal)
            }
        }
   
        
        
        
        sendActions(for: .valueChanged)
        }
    

}
