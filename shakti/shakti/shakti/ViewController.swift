//
//  ViewController.swift
//  shakti
//
//  Created by Pinaki Poddar on 7/3/20.
//  Copyright © 2020 Digital Artisan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var textView:UITextView
    var layoutComplete:Bool = false
    init() {
        self.textView = UITextView()
        super.init(nibName: nil, bundle: nil)
    
        self.view.frame = .zero
        self.view.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.sizeToFit()
    }
    /*
    override func loadView() {
        super.loadView()
        let lang = "bangla"
        let poem = readFileContent(lang: lang, idx: 1)
        textView.text = poem
        
        view.addSubview(textView)
    }
 */
    override func viewWillLayoutSubviews() {
        if (layoutComplete) {return}
        let safeArea = self.view.safeAreaLayoutGuide
        //print("safe area:\(safeArea)")
        textView.frame = self.view.frame
        textView.contentScaleFactor = 2
        textView.font = UIFont.preferredFont(forTextStyle: .caption1)
        
        NSLayoutConstraint.activate([
            //self.view.topAnchor.constraint    (equalTo: safeArea.topAnchor),
            //self.view.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            //self.view.bottomAnchor.constraint (equalTo: safeArea.bottomAnchor),
            //self.view.widthAnchor.constraint  (equalTo: safeArea.widthAnchor),
            
            textView.topAnchor.constraint    (equalTo: safeArea.topAnchor),
            textView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            textView.widthAnchor.constraint  (equalTo: safeArea.widthAnchor),
            textView.heightAnchor.constraint (equalTo: safeArea.heightAnchor)
        ])
 
        //print("self.view.frame \(self.view.frame)")
        //print("textView.frame \(textView.frame)")
        //textView.sizeToFit()
        layoutComplete = true
        super.viewWillLayoutSubviews()
    }

    

    

}

