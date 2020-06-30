import UIKit

/*
 * An address shows kind (home, office etc) as header
 * and deatils (line1, city, zip etc) as details
 */
class AddressView: UIStackView {
    var controller:UIViewController?
    
    init() {
        super.init(frame:.zero)
        axis = .vertical
        distribution = .fill
        alignment = .fill
        self.autoresizingMask = []
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    *
     */
    var address:Address? {
        didSet {
            guard let addr = address else {return}
            updateView(address: addr)
        }
    }
    
    func updateView(address:Address) {
        print("AddressView.updateView with address \(address)")
        for view in self.arrangedSubviews {
            //print("remove arranged subview \(view)")
            self.willRemoveSubview(view)
            self.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        for view in self.subviews {
            //print("remove subview \(view)")
            self.willRemoveSubview(view)
            view.removeFromSuperview()
        }

        
        let header  = UIStackView()
        header.addBackground(color: UIColor.green)
        let details = UIStackView()
        details.addBackground(color: UIColor.white)
        details.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 5, right: 5)
        header.autoresizingMask = []
        details.autoresizingMask = []
        header.translatesAutoresizingMaskIntoConstraints  = false
        details.translatesAutoresizingMaskIntoConstraints = false
        
        header.axis = .vertical
        header.alignment = .fill
        header.distribution = .fillEqually
        
        details.axis = .vertical
        details.alignment = .fill
        details.distribution = .fillEqually
        details.isLayoutMarginsRelativeArrangement = true
        
        let kind  = UIFactory.label(address.kind.rawValue, fontSize:24)
        kind.textAlignment = .center
        header.addArrangedSubview(kind)

        let line1 = UIFactory.label(address.line1, fontSize:18 )
        line1.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption1)
        details.addArrangedSubview(line1)
        
        if let text = address.line2 {
             let line2  = UIFactory.label(text)
             line2.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption2)
             details.addArrangedSubview(line2)
         }
         
        if let text = address.city {
             let city  = UIFactory.label(text)
             city.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption1)
             details.addArrangedSubview(city)
        }
        let zip  = UIFactory.label(address.zip)
        zip.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption1)
        //zip.backgroundColor = .magenta
        details.addArrangedSubview(zip)
        
        
        self.addArrangedSubview(header)
        self.addArrangedSubview(details)
        
        self.setNeedsDisplay()
     }
     
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200,
            height: 6*UIConstants.LINE_HEIGHT)
    }
}
