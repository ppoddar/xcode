import UIKit
class UIFactory {
    
    public static var ITEM_ROW_HEIGHT:CGFloat = CGFloat(100)
    
    static func textView(placeHolderText:String="",lineCount:Int=8) -> KeyboardTextView {
        let textView = KeyboardTextView(placeHolderText: placeHolderText, lineCount:lineCount)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.black.cgColor
        
        
        //textView.layer.borderColor = CGColor(srgbRed: 0,green: 0,blue: 255, alpha: 1)
        return textView
    }
    static func button(_ title:String?,
        backgroundColor:UIColor = UIConstants.COLOR_TITLE,
        tintColor:UIColor = .white,
        fontSize:Int = 16,
        bold:Bool=true,
        rounded:Bool=true) -> UIButton  {
        let btn = UIButton(type: .system)
        btn.setTitle(title, for: .normal)
        btn.frame = CGRect(x:0, y:0,
            width:UIConstants.BUTTON_WIDTH,
            height:UIConstants.BUTTON_HEIGHT)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = backgroundColor
        btn.tintColor       = tintColor
        if (bold) {
            btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(fontSize))
        }
        btn.contentEdgeInsets = UIEdgeInsets(top: 2, left: 10, bottom: 5, right: 10)
        btn.sizeToFit()
        if (rounded) {
            UIFactory.round(btn)
        }
        
        return btn
    }
    
    static func fixSize(view:UIView) {
        view.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .vertical)
        view.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .horizontal)
        view.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .vertical)
    }
    
    static func flexSize(view:UIView, axis:NSLayoutConstraint.Axis) {
        view.setContentHuggingPriority              (UILayoutPriority.defaultLow, for: axis)
        view.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: axis)
    }
    
    static func label(_ text:String,
                      backgroundColor:UIColor = .white,
                      textColor:UIColor = .black,
                      fontSize:Int = 16, bold:Bool=true,
                      border:Bool = false) -> UILabel  {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = textColor
        
        if (bold) {
            lbl.font = UIFont.boldSystemFont(ofSize: CGFloat(fontSize))
        }
        //NSLog("setting [\(text)] as label text")
        lbl.text = text
        lbl.textAlignment = .left
        lbl.frame = CGRect(x:0, y:0, width:320, height:24)
        if (border) {
            UIFactory.border(lbl)
        }
        //lbl.sizeToFit()
        //lbl.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
        //lbl.setContentCompressionResistancePriority(UILayoutPriority.fittingSizeLevel, for: .horizontal)
        return lbl
    }
    
    static func border(_ view:UIView, color:UIColor? = UIColor.black) {
        if view.isKind(of: UIStackView.self) {
            let subViews:[UIView]? = (view as? UIStackView)?.arrangedSubviews
            guard let subs = subViews else {return}
            for v in subs {
                UIFactory.border(v, color: color)
            }
        } else {
        view.layer.cornerRadius = 5
        view.layer.borderWidth  = 1
        view.layer.borderColor  = color?.cgColor
        }
    }
    
    static func pin(_ view:UIView, to:UILayoutGuide) {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: to.topAnchor),
            view.leftAnchor.constraint(equalTo: to.leftAnchor),
            view.widthAnchor.constraint(equalTo: to.widthAnchor),
            view.heightAnchor.constraint(equalTo: to.heightAnchor)
        ])
    }
    static func pin(_ view:UIView, toView:UIView) {
           NSLayoutConstraint.activate([
               view.topAnchor.constraint(equalTo: toView.topAnchor),
               view.leftAnchor.constraint(equalTo: toView.leftAnchor),
               view.widthAnchor.constraint(equalTo: toView.widthAnchor),
               view.heightAnchor.constraint(equalTo: toView.heightAnchor)
           ])
    }
    
    
    static func round(_ view:UIView, color:UIColor? = UIColor.black) {
           view.layer.cornerRadius = 5
           view.layer.borderWidth  = 1
           view.layer.borderColor  = color?.cgColor
    }
    
    
    static func clear(_ view:UIView) {
        view.subviews.forEach(({$0.removeFromSuperview()}))
    }
    
    static func clearStack(_ view:UIStackView) {
         view.arrangedSubviews.forEach(({
            view.removeArrangedSubview($0)
            $0.removeFromSuperview()
         }))
     }

    
    static func imageView() -> UIImageView  {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIView.ContentMode.center;
        //imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }
    
    static func stepper() -> UIStepper  {
        let counter = UIStepper()
        // must set frame
        counter.frame = CGRect(x:0,y:0,width:60,height: 20)
        counter.translatesAutoresizingMaskIntoConstraints = false
        counter.minimumValue = 1
        counter.maximumValue = .infinity
        counter.wraps      = false
        counter.autorepeat = true
        counter.backgroundColor = .white
        
        return counter
    }
    
    /*
     * Return string with currency symbok for given amount
     */
    static func amount(value:Double) -> String {
        let INR = "\u{20B9}"
        let s = String(format: "%.2f", value)
        return INR+s
    }
    
    static func imageLabel(image:String, caption:String) -> UILabel {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: image)
        let attachmentString = NSAttributedString(attachment: attachment)
        let myString = NSMutableAttributedString(string: caption)
        myString.append(attachmentString)
        let label = UILabel()
        label.attributedText = myString
        return label
    }
    
    
}

extension UIViewController {
    /*
     * add a child view controller
     */
    func addViewController(_ child:UIViewController) {
        self.view.addSubview(child.view)
        self.addChild(child)
        child.didMove(toParent: self)
    }
    /*
     * raises an alert
     */
    func alert(title:String,message:String) {
        if Thread.isMainThread {
            _showAlert(title: title, message: message)
        } else {
            DispatchQueue.main.async {
                self._showAlert(title: title, message: message)
            }
        }
        
    }
    private func _showAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message:  message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
            style:.cancel,
            handler:{(alert:UIAlertAction!) in
                self.presentingViewController?.backPage()
                NSLog("gone back")}))

        self.present(alert, animated: false)

    }
    
    /*
     * Sets header of the scene
     */
    func setSceneHeader(hideBackButton:Bool=false) {
        //navigationController?.navigationBar.barStyle     = .black
        navigationController?.navigationBar.tintColor    = .white
        navigationController?.navigationBar.isTranslucent = false
        // title text is set on view controller, not on navigation bar
        
        let appearence = UINavigationBarAppearance()
        //appearence.configureWithDefaultBackground()
        appearence.backgroundColor = UIConstants.COLOR_TITLE
        appearence.titleTextAttributes = [
            .foregroundColor:UIColor.white,
            .font: UIFont.preferredFont(forTextStyle: .title1)
        ]
        
        navigationItem.standardAppearance = appearence
        navigationItem.scrollEdgeAppearance = appearence
        navigationItem.compactAppearance = appearence
        
        let buttonAppearance = UIBarButtonItemAppearance()
        buttonAppearance.configureWithDefault(for: UIBarButtonItem.Style.plain)
        navigationItem.standardAppearance?.buttonAppearance = buttonAppearance
        navigationItem.scrollEdgeAppearance?.buttonAppearance = buttonAppearance
        navigationItem.compactAppearance?.buttonAppearance = buttonAppearance

        
        if (hideBackButton) {
            let backBarButtton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            navigationItem.backBarButtonItem = backBarButtton
        } else {
            let backBarButtton = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
            navigationItem.backBarButtonItem = backBarButtton
        }
        let rightBarButtton = UIBarButtonItem(
            image: UIImage(systemName: "text.justify"),
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(openSettings))
        
        navigationItem.rightBarButtonItem = rightBarButtton
        
        //let w = view.frame.width
        //let h = navbar.frame.height + statusBar.statusBarFrame.height
        /*
        let barView = UIStackView()//frame: CGRect(x:0, y:0,width:w,height: h))
        UIFactory.clear(navbar)
        navbar.addSubview(barView)
        navbar.backgroundColor   = UIConstants.COLOR_0
        
        let title = UILabel()
        //title.frame = CGRect(x:0, y:0, width:view.frame.width - 50 , height:barView.frame.height - 10)
        title.text = titleText
        title.textAlignment = .center
        title.textColor = .white
        title.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title1)

        let back = UIButton()
        back.frame = CGRect(x:0, y:10, width:100 , height:24)
        back.setTitle("<Back", for: .normal)
        back.setTitleColor(.white, for: .normal)
        
        let settings = UIButton()
          settings.frame = CGRect(x:0, y:0, width:24,height:24)
          let image = UIImage(systemName: "text.justify")
          settings.setImage(image, for: .normal)
         settings.addTarget(self,
                action: #selector(openSettings),
                for: .touchUpInside)
            
        back.addTarget(self,
            action: #selector(backPage),
            for: .touchUpInside)
         
        
        back.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        settings.translatesAutoresizingMaskIntoConstraints = false
        barView.translatesAutoresizingMaskIntoConstraints = false
        barView.addArrangedSubview(back)
        barView.addArrangedSubview(title)
        barView.addArrangedSubview(settings)
        
        UIFactory.fixSize(view: back)
        UIFactory.fixSize(view: settings)
        UIFactory.flexSize(view: title, axis:.vertical)

        barView.topAnchor.constraint(equalTo: navbar.topAnchor).isActive = true
        barView.leftAnchor.constraint(equalTo: navbar.leftAnchor).isActive = true
        barView.widthAnchor.constraint(equalTo: navbar.widthAnchor).isActive = true
        barView.heightAnchor.constraint(equalTo: navbar.heightAnchor).isActive = true
    
    */
 }
    
    
    
    
    @objc func openSettings() {
        guard let url:URL = URL(string:UIApplication.openSettingsURLString) else {return}
        NSLog("app settings url \(url)")
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @objc func backPage() {
        self.navigationController?
            .popViewController(animated: true)
    }

}

extension UIImageView {
    func loadImage(imageURL:URL) -> Void {
        //NSLog("loading image from \(imageURL)")
        DispatchQueue.global().async { [weak self] in
            guard let self = self else {
                return
            }
            //NSLog("fetching image data from \(imageURL)")
            guard let imageData = try? Data(contentsOf: imageURL) else {
                return
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: imageData)
                //NSLog("image size \(String(describing: image?.size))")
                let w:CGFloat? = image?.size.width
                let h:CGFloat? = image?.size.height
                UIFactory.ITEM_ROW_HEIGHT = h!
                let f = CGRect(x: 0, y: 0, width: w!, height: h!)
                self.image = image
                self.frame = f
            }
        }
    }
    
    func x() {
        UIButton.appearance().layer.cornerRadius = 4
        UIButton.appearance().backgroundColor = .blue
        UIButton.appearance().tintColor = .white
    }
    
}


extension String.StringInterpolation {
    mutating func appendInterpolation (
        date text:String?) {
        guard let str = text else {
            return
        }
        let inFormat = DateFormatter()
        inFormat.dateFormat = "MM/dd/yyyy"
        let date = inFormat.date(from: str)
        
        
        let outFormat = DateFormatter()
        outFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = outFormat.string(from: date!)
        
        appendLiteral("date:"+dateString)
    }}

extension String.StringInterpolation {
    mutating func appendInterpolation (amount text:String?) {
        guard let str = text else {
            return
        }
        let INR = "\u{20B9}"
        let s = String(format: "%.2f", Double(str)!)
        appendLiteral(INR+s)
    }
    
}

extension UIButton {
    open override var intrinsicContentSize: CGSize {
        return CGSize(width: UIConstants.BUTTON_WIDTH,
                      height: UIConstants.BUTTON_HEIGHT)
    }
}


extension UIStackView {
    func setBackgroundColor(_ color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
    
    func setBorder(_ color: UIColor = .black) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        UIFactory.border(subView)
        insertSubview(subView, at: 0)
    }
    
    
}
