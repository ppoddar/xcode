//
//  TranslationViewController.swift
//  shakti
//
//  Created by Pinaki Poddar on 7/4/20.
//  Copyright © 2020 Digital Artisan. All rights reserved.
//

import UIKit

class TranslationViewController: UIViewController {

    var english:UIViewController
    //var bangla:UIViewController
    var flip:UIButton
    var lang:Language = .english
    
    init(index:Int=0) {
        self.english = PoemViewController(index: index, lang: .english)
        //self.bangla  = PoemViewController(index: index, lang: .bangla)
        self.flip = UIButton()
        super.init(nibName: nil, bundle: nil)
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.frame = .zero
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        self.view.addSubview(english.view)
        //self.view.addSubview(bangla.view)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let safeArea = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            self.english.view.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.english.view.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.english.view.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.english.view.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
            self.english.view.heightAnchor.constraint(equalTo: safeArea.heightAnchor),
        ])
    }
    

    /*
    @objc func flipView( ) {
        var current:UIViewController
        var target:UIViewController

        switch lang {
        case .english:
            lang = .bangla
            current = english
            target  = bangla
        case .bangla:
            lang = .english
            current = bangla
            target  = english
        }
        self.transition(
            from: current, to: target, duration: 1.0,
            options: .showHideTransitionViews,
            animations: nil,
            completion: nil)
    }
    */
    

    

}
