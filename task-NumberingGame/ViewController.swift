//
//  ViewController.swift
//  task-NumberingGame
//
//  Created by Domagoj Bunoza on 03.08.2021..
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    let goal : Int = 50
    var textField1 : UITextField = UITextField()
    var textField2 : UITextField = UITextField()
    var textField3 : UITextField = UITextField()
            
    func getLabel(text : String) -> UILabel {
        let labelTemp = UILabel()
        labelTemp.translatesAutoresizingMaskIntoConstraints = false
        labelTemp.textColor = .orange
        labelTemp.text = text
        return labelTemp
    }
    
    func getTextField() -> UITextField {
        let textFieldTemp = UITextField()
        textFieldTemp.translatesAutoresizingMaskIntoConstraints = false
        textFieldTemp.placeholder = "Enter a number"
        textFieldTemp.backgroundColor = .systemGray6
        textFieldTemp.setLeftPaddingPoints(10)
        textFieldTemp.setRightPaddingPoints(10)
        return textFieldTemp
    }
    
    var button : UIButton = {
        let buttonTemp = UIButton()
        buttonTemp.translatesAutoresizingMaskIntoConstraints = false
        buttonTemp.backgroundColor = .orange
        buttonTemp.setTitle("Check", for: .normal)
        buttonTemp.setTitleColor(.white, for: .normal)
        buttonTemp.addTarget(self, action: #selector(click(_sender:)), for: .touchUpInside)
        return buttonTemp
    }()
    
    func getStackView() -> UIStackView {
        let stackViewTemp = UIStackView()
        stackViewTemp.translatesAutoresizingMaskIntoConstraints = false
        stackViewTemp.axis = .vertical
        stackViewTemp.alignment = .fill
        stackViewTemp.distribution = .fillEqually
        return stackViewTemp
    }
    

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
        setupViews()
    }

    func setupViews() -> Void {
        //setup
        let label1 = getLabel(text: "   Number of players:")
        let label2 = getLabel(text: "   Change direction*:")
        let label3 = getLabel(text: "   Skip player*:")
        
        let stack1 = getStackView()
        let stack2 = getStackView()
        let stack3 = getStackView()
        
        stack1.addArrangedSubview(label1)
        stack2.addArrangedSubview(label2)
        stack3.addArrangedSubview(label3)
        
        textField1 = getTextField()
        textField2 = getTextField()
        textField3 = getTextField()
        
        textField1.delegate = self
        textField2.delegate = self
        textField3.delegate = self
        
        stack1.addArrangedSubview(textField1)
        stack2.addArrangedSubview(textField2)
        stack3.addArrangedSubview(textField3)
        
        let views = [stack1, stack2, stack3]
        view.addSubview(button)
        addSubviews(views)
        setUpConstraints(views)
    }

    func setTitle() -> Void {
        self.navigationItem.title = "PLAY NUMBERING GAME";
    }
    
    func addSubviews(_ views: [UIView]) {
        for oneView in views {
            view.addSubview(oneView)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            return string == "" || Int(string) != nil
        }

    func setUpConstraints(_ views: [UIView]){
        NSLayoutConstraint.activate([
            views[0].topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            views[0].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            views[0].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            views[0].heightAnchor.constraint(equalToConstant: 80),
            views[1].topAnchor.constraint(equalTo: views[0].bottomAnchor, constant: 30),
            views[1].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            views[1].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            views[1].heightAnchor.constraint(equalToConstant: 80),
            views[2].topAnchor.constraint(equalTo: views[1].bottomAnchor, constant: 30),
            views[2].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            views[2].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            views[2].heightAnchor.constraint(equalToConstant: 80),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    func showOverlay() -> Void {
        let slideOverlay = OverlayView()
        setTextForOverlay(overlay: slideOverlay)
        slideOverlay.modalPresentationStyle = .custom
        slideOverlay.transitioningDelegate = self
        self.present(slideOverlay, animated: true, completion: nil)
        
    }
    
    @objc func click(_sender: UIButton!) -> Void {
        showOverlay()
    }
    
    func setTextForOverlay(overlay : OverlayView) -> Void {
        var playerNum : Int = 0
        var changeDirectionNum : Int = 0
        var skipPlayerNum : Int = 0
        if textField1.hasText && textField2.hasText && textField3.hasText {
            playerNum = Int(textField1.text!)!
            changeDirectionNum = Int(textField2.text!)!
            skipPlayerNum = Int(textField3.text!)!
        }
        
        let changeDirectionNumOverlay = floor(Double(50 / changeDirectionNum))
        let skipPlayerNumOverlay = floor(Double(50 / skipPlayerNum))
        var playerNumoverlay = floor(Double(50 / playerNum)) + skipPlayerNumOverlay
        while playerNumoverlay > Double(playerNum) {
            playerNumoverlay = floor(Double(playerNumoverlay / Double(playerNum)))
        }
        overlay.text1 = String(Int(playerNumoverlay))
        overlay.text2 = String(Int(changeDirectionNumOverlay))
        overlay.text3 = String(Int(skipPlayerNumOverlay))
        //logika igre
    }
    
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
