import UIKit
public class ItemView: UIView {
    var computedHeight:CGFloat = 0
    override init(frame: CGRect) {
        self.item = nil
        self.computedHeight = 0
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.item = nil
        self.computedHeight = 0
        super.init(coder: aDecoder)
    }
    
    // Once model Item instance is set, the view can be set
    var item:Item? {
        didSet {
            print("ItemView set item \(String(describing: item))")
            guard let i = item else {return}
            
            let name:UILabel = UIFactory.label(i.name)
            let description:UITextView = UITextView()
            description.translatesAutoresizingMaskIntoConstraints = false
            description.text = i.description
            description.textContainer.lineBreakMode = .byCharWrapping
            description.isEditable = false
            
            let image      = ImageLibrary().getItemImage(name: i.image)
            let itemImage  = UIImageView(image: image)
            itemImage.translatesAutoresizingMaskIntoConstraints = false
            let rating = Rating(i.rating)
            let price = UIFactory.label(UIFactory.amount(i.price))
            
            print("=========> adding subviews")

            self.addSubview(name)
            self.addSubview(description)
            self.addSubview(itemImage)
            self.addSubview(price)
            self.addSubview(rating)
            
            
            let safeArea = safeAreaLayoutGuide
            //let screenWidth = UIScreen.main.bounds.width
            
            itemImage.topAnchor.constraint   (equalTo: self.topAnchor,  constant:UIConstants.TOP_MARGIN).isActive = true
            itemImage.leftAnchor.constraint  (equalTo: self.leftAnchor, constant:UIConstants.LEFT_MARGIN).isActive = true
            //itemImage.rightAnchor.constraint  (equalTo: self.rightAnchor, constant:-UIConstants.RIGHT_MARGIN).isActive = true
            itemImage.heightAnchor.constraint(equalToConstant: image.size.height).isActive = true
            
            name.topAnchor.constraint(equalTo:itemImage.topAnchor).isActive = true
            name.leftAnchor.constraint(equalTo:itemImage.rightAnchor,constant:UIConstants.HGAP ).isActive = true
            
            let numberOfLines:Int = 6
            let height = CGFloat(numberOfLines)*UIConstants.LINE_HEIGHT
            description.topAnchor.constraint(equalTo: name.bottomAnchor, constant: UIConstants.VGAP).isActive = true
            description.leftAnchor.constraint(equalTo:name.leftAnchor).isActive = true
            description.rightAnchor.constraint(equalTo:safeArea.rightAnchor, constant: -UIConstants.RIGHT_MARGIN).isActive = true
            description.heightAnchor.constraint(equalToConstant:height).isActive = true
            
            price.topAnchor.constraint(equalTo: itemImage.bottomAnchor, constant:UIConstants.VGAP).isActive = true
            price.leftAnchor.constraint(equalTo: itemImage.leftAnchor).isActive = true
            
            rating.topAnchor.constraint(equalTo: price.bottomAnchor,constant:UIConstants.VGAP).isActive = true
            rating.leftAnchor.constraint(equalTo: itemImage.leftAnchor).isActive = true
            
            
            let h1 = image.size.height + 4*UIConstants.LINE_HEIGHT
            let h2 = CGFloat(numberOfLines+2)*UIConstants.LINE_HEIGHT
            self.computedHeight = max(h1,h2)
            print("ItemView computed height \(computedHeight)")
            UIFactory.border(self)
        }
        
    }
    
    public override var intrinsicContentSize: CGSize {
        get {
            print("========> getting intrinsicContentSize")
            return self.sizeThatFits(.zero)
        }
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width:frame.width
            - UIConstants.LEFT_MARGIN
            -  UIConstants.RIGHT_MARGIN,
        height: computedHeight)
    }
    
    
}



