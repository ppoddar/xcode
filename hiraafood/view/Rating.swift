import UIKit


class Rating:  UIStackView {
    static let MAX_RATING = 5
//    static var config:UIImage.SymbolConfiguration
//        = UIImage.SymbolConfiguration
    
    init(_ rating:Int) {
        super.init(frame:.zero)
        translatesAutoresizingMaskIntoConstraints = false
        axis = .horizontal
        alignment = .fill
        distribution = .fill
        for i in 1...Rating.MAX_RATING {
            let subview = i <= rating ? star_filled() : star_unfilled()
            subview.translatesAutoresizingMaskIntoConstraints = false
            addArrangedSubview(subview)
        }
        
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func star_filled () -> UIImageView {
        return named_image(name:"star.fill")
    }
    
    func star_unfilled () -> UIImageView {
        return named_image(name:"star")
    }
    
    func named_image(name:String) -> UIImageView {
        let config:UIImage.SymbolConfiguration = UIImage.SymbolConfiguration(weight: .medium)
        let image:UIImage? = UIImage(systemName: name, withConfiguration: config)
        let view = UIImageView(image:image)
        view.tintColor = UIConstants.COLOR_1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }
    public override var intrinsicContentSize: CGSize {
        let w = CGFloat(Rating.MAX_RATING) * (star_filled().image?.size.width ?? 24)
        let h = star_filled().image?.size.height ?? 24
        
        return CGSize(width: w, height: h)
    }
}


//    override var intrinsicContentSize: CGSize {
//        get {
//            let w:CGFloat = star_filled().image?.size.width ?? 24
//            let h:CGFloat = star_filled().image?.size.height ?? 24
//            return CGSize(width: w*CGFloat(Rating.MAX_RATING),height: h)
//        }
//    }
    
extension UILabel {
    open override var intrinsicContentSize: CGSize {
        return CGSize(width: 64, height: UIConstants.LINE_HEIGHT)
    }
}

extension UITextView {
    open override var intrinsicContentSize: CGSize {
        let h = CGFloat(self.textContainer.maximumNumberOfLines) *
            UIConstants.LINE_HEIGHT
        return CGSize(width: frame.width, height: h)
    }
}
