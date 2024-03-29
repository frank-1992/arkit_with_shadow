//
//  ViewController.swift
//  XYARKit
//
//  Created by user on 4/6/22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private lazy var enterButton: UIButton = {
        let button = UIButton()
        button.setTitle("START", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 6
        button.backgroundColor = UIColor.systemRed
        button.addTarget(self, action: #selector(showARController), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        view.addSubview(enterButton)
        
        enterButton.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.size.equalTo(CGSize(width: 150, height: 60))
        }
    }
    
    @objc
    private func showARController() {
        let arSceneVC = ARSceneController()
        arSceneVC.modalPresentationStyle = .overFullScreen
        present(arSceneVC, animated: true)
    }

}

