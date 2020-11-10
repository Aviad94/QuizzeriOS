//
//  ThanksViewController.swift
//  TheQuizzler - iOS
//
//  Created by Aviad Sabag on 10/11/2020.
//

import Foundation
import UIKit


class ThanksViewController: UIViewController {
       
    let titleLabel = UILabel()
    let bodyLabel = UILabel()
    
    
    fileprivate func setupLabels() {
        titleLabel.text = "Thanks for participating!"
        titleLabel.lineBreakMode = .byClipping // avoiding the 3 dots.
        titleLabel.font = UIFont(name: "Futura", size: 20)
        titleLabel.textColor = UIColor.black

        
        bodyLabel.text = "We hope you had fun using our app!, if you do we appricate if you vote 5 stars on AppStore!."
        
        bodyLabel.numberOfLines = 0
        bodyLabel.textColor = UIColor.black

    }
    
    
    fileprivate func setupStackView() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, bodyLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        view.addSubview(stackView)
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100).isActive = true
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLabels()
        
        
        setupStackView()

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapAnimations)))
        
        
    }
    
    
    
    @objc fileprivate func handleTapAnimations() {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut) {
            
            
            self.titleLabel.transform = CGAffineTransform(translationX: -30, y: 0)
            
        } completion: { (_) in
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.titleLabel.alpha = 0
                self.titleLabel.transform = self.titleLabel.transform.translatedBy(x: 0, y: -100)
                
            })
        }
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut) {
            
            
            self.bodyLabel.transform = CGAffineTransform(translationX: -30, y: 0)
            
        } completion: { (_) in
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.bodyLabel.alpha = 0
                self.bodyLabel.transform = self.bodyLabel.transform.translatedBy(x: 0, y: -100)

                
            })
        }
        

    
}
}
