import UIKit
class UIFactory {
    
    public static var ITEM_ROW_HEIGHT:CGFloat = CGFloat(100)
    
    static func textView(placeHolder:String="",lines:Int?=8) -> KeyboardTextView {
        let textView = KeyboardTextView(placeHolder: placeHolder, lines:lines)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.black.cgColor
        //textView.layer.borderColor = CGColor(srgbRed: 0,green: 0,blue: 255, alpha: 1)
        return textView
    }
    static func button(_ title:String?,
        backgroundColor:UIColor = .white,
        tintColor:UIColor = .black,
        fontSize:Int = 16, bold:Bool=true) -> UIButton  {
        let btn = UIButton(type: .system)
        btn.setTitle(title, for: .normal)
        btn.frame = CGRect(x:0, y:0, width:UIConstants.BUTTON_WIDTH, height:UIConstants.BUTTON_HEIGHT)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = backgroundColor
        btn.tintColor = tintColor
        if (bold) {
            btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(fontSize))
        }
        btn.contentEdgeInsets = UIEdgeInsets(top: 2, left: 10, bottom: 5, right: 10)
        btn.sizeToFit()
        
        return btn
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
        //print("setting [\(text)] as label text")
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
        view.layer.cornerRadius = 5
        view.layer.borderWidth  = 1
        view.layer.borderColor  = color?.cgColor
    }
    
    static func round(_ view:UIView, color:UIColor? = UIColor.black) {
           view.layer.cornerRadius = 5
           view.layer.borderWidth  = 1
           view.layer.borderColor  = color?.cgColor
    }
    
    
    static func clear(_ view:UIView) {
        view.subviews.forEach(({$0.removeFromSuperview()}))
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
    
    static func amount(_ a:Double) -> String {
        let INR = "\u{20B9}"
        let s = String(format: "%.2f", a)
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
    func addViewController(_ child:UIViewController) {
        self.view.addSubview(child.view)
        self.addChild(child)
        child.didMove(toParent: self)
    }
    func alert(title:String,message:String) {
    let alert = UIAlertController(title: title, message:  message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    self.present(alert, animated: true)
    }
}

extension UIImageView {
    func loadImage(imageURL:URL) -> Void {
        //print("loading image from \(imageURL)")
        DispatchQueue.global().async { [weak self] in
            guard let self = self else {
                return
            }
            //print("fetching image data from \(imageURL)")
            guard let imageData = try? Data(contentsOf: imageURL) else {
                return
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: imageData)
                //print("image size \(String(describing: image?.size))")
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
