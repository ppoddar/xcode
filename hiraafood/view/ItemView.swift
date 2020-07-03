import UIKit
public class ItemView: UIView {
    var item:Item
    init(item:Item) {
        self.item = item
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        NSLog("\(type(of:self)).setUpView \(String(describing: item))")
        let name:UILabel = UIFactory.label(item.name)
        let description:UITextView = UITextView()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.text = item.description
        description.textContainer.lineBreakMode = .byCharWrapping
        description.isEditable = false
        
        let image      = ImageLibrary().getItemImage(name: item.image)
        let itemImage  = UIImageView(image: image)
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        let rating = Rating(item.rating)
        let price = UIFactory.label(UIFactory.amount(value: item.price))
        
        self.addSubview(name)
        self.addSubview(description)
        self.addSubview(itemImage)
        self.addSubview(price)
        self.addSubview(rating)
        
        itemImage.topAnchor.constraint    (equalTo: self.topAnchor).isActive = true
        itemImage.leftAnchor.constraint   (equalTo: self.leftAnchor).isActive = true
        itemImage.heightAnchor.constraint (equalToConstant: image.size.height).isActive = true
        
        name.topAnchor.constraint(equalTo:itemImage.topAnchor).isActive = true
        name.leftAnchor.constraint(equalTo:itemImage.rightAnchor,constant:UIConstants.HGAP ).isActive = true
        
        let numberOfLines:Int = 6
        let height = CGFloat(numberOfLines)*UIConstants.LINE_HEIGHT
        description.topAnchor.constraint(equalTo: name.bottomAnchor, constant: UIConstants.VGAP).isActive = true
        description.leftAnchor.constraint(equalTo:name.leftAnchor).isActive = true
        description.rightAnchor.constraint(equalTo:self.rightAnchor).isActive = true
        description.heightAnchor.constraint(equalToConstant:height).isActive = true
        
        price.topAnchor.constraint(equalTo: itemImage.bottomAnchor, constant:UIConstants.VGAP).isActive = true
        price.leftAnchor.constraint(equalTo: itemImage.leftAnchor).isActive = true
        
        rating.topAnchor.constraint(equalTo: price.bottomAnchor,constant:UIConstants.VGAP).isActive = true
        rating.leftAnchor.constraint(equalTo: itemImage.leftAnchor).isActive = true
    }
    
    public override var intrinsicContentSize: CGSize {
        get {
            let size = CGSize(width: UIScreen.main.bounds.width, height: 240)
            NSLog("\(type(of:self)).intrinsicContentSize \(size)")
            return size
        }
    }
    
    
    
    
}



