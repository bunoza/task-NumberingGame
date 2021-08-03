//
//  OverlayView.swift
//  task-NumberingGame
//
//  Created by Domagoj Bunoza on 03.08.2021..
//

import UIKit

class OverlayView: UIViewController {
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    
    var text1 : String = ""
    var text2 : String = ""
    var text3 : String = ""
    
    
    func getLabel(text : String) -> UILabel {
        let labelTemp = UILabel()
        labelTemp.translatesAutoresizingMaskIntoConstraints = false
        labelTemp.text = text
        return labelTemp
    }
    
    func getLabelWithBG(text : String) -> UILabel {
        let labelTemp = UILabel()
        labelTemp.translatesAutoresizingMaskIntoConstraints = false
        labelTemp.text = "" + text + " "
        labelTemp.textAlignment = .center
        labelTemp.font = UIFont.init(name: "Arial", size: 25)
        labelTemp.backgroundColor = UIColor.orange
        labelTemp.shadowColor = UIColor.orange
        labelTemp.textColor = .white
        return labelTemp
    }
    
    func getStackView() -> UIStackView {
        let stackViewTemp = UIStackView()
        stackViewTemp.translatesAutoresizingMaskIntoConstraints = false
        stackViewTemp.axis = .vertical
        stackViewTemp.alignment = .fill
        stackViewTemp.distribution = .fillEqually
        return stackViewTemp
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
        view.backgroundColor = .white
        
        setUpViews()
        
    }
    
    func setUpViews() -> Void {
        let label1 = getLabel(text: "Player who ended the game")
        let label2 = getLabel(text: "How many times did the game change direction")
        let label3 = getLabel(text: "How many times did the player get skipped")
        
        let box1 = getLabelWithBG(text: text1)
        let box2 = getLabelWithBG(text: text2)
        let box3 = getLabelWithBG(text: text3)
        
//        let stack1 = getStackView()
//        let stack2 = getStackView()
//        let stack3 = getStackView()
        
//        stack1.addArrangedSubview(label1)
//        stack1.addArrangedSubview(box1)
//        stack2.addArrangedSubview(label2)
//        stack2.addArrangedSubview(box2)
//        stack3.addArrangedSubview(label3)
//        stack3.addArrangedSubview(box3)
        
        let views = [label1, label2, label3, box1, box2, box3]
        addSubviews(views)
        setUpConstraints(views)
    }
    
    func setUpConstraints(_ views: [UIView]){
        NSLayoutConstraint.activate([
//            views[0].topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
//            views[0].heightAnchor.constraint(equalToConstant: 80),
//            views[0].centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            views[1].topAnchor.constraint(equalTo: views[0].bottomAnchor, constant: 30),
//            views[1].heightAnchor.constraint(equalToConstant: 80),
//            views[1].centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            views[2].topAnchor.constraint(equalTo: views[1].bottomAnchor, constant: 30),
//            views[2].heightAnchor.constraint(equalToConstant: 80),
//            views[2].centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
            views[0].topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            views[0].heightAnchor.constraint(equalToConstant: 80),
            views[0].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            views[3].topAnchor.constraint(equalTo: views[0].bottomAnchor),
            views[3].widthAnchor.constraint(equalToConstant: 35),
//            views[3].heightAnchor.constraint(equalToConstant: 80),
            views[3].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            views[1].topAnchor.constraint(equalTo: views[3].bottomAnchor),
            views[1].heightAnchor.constraint(equalToConstant: 80),
            views[1].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            views[4].topAnchor.constraint(equalTo: views[1].bottomAnchor),
            views[4].widthAnchor.constraint(equalToConstant: 35),
//            views[4].heightAnchor.constraint(equalToConstant: 80),
            views[4].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            views[2].topAnchor.constraint(equalTo: views[1].bottomAnchor, constant: 30),
            views[2].heightAnchor.constraint(equalToConstant: 80),
            views[2].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            views[5].topAnchor.constraint(equalTo: views[2].bottomAnchor),
            views[5].widthAnchor.constraint(equalToConstant: 35),
//            views[5].heightAnchor.constraint(equalToConstant: 80),
            views[5].centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    func addSubviews(_ views: [UIView]) {
        for oneView in views {
            view.addSubview(oneView)
        }
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
}

