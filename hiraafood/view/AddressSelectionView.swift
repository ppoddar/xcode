import UIKit

/*
 * Content View Controller cycles through a set of
 * addresses and lets you create new addresses.
 * Address is rendered by AddressView
 */
class AddressSelectionView: UIStackView {
    var addressViews:Dictionary<String,AddressView>
    var selectedAddressIndex:Int
    var navigationPanel:NavigationPanel
    var newAddress:UIButton
    var keyOrder:[String]
    var addresses:Dictionary<String,Address>
    /*
     * create this view with array of given addresses
     */
    init(addresses:Dictionary<String,Address>) {
        NSLog("\(type(of:self)).init() with \(addresses)")
        self.addresses = addresses
        self.addressViews  = Dictionary<String,AddressView>()
        for (key, value) in addresses {
            let childView = AddressView(address: value)
            addressViews[key] = childView
        }
        self.selectedAddressIndex = 0
        self.keyOrder = addresses.keys.sorted()
        self.navigationPanel = NavigationPanel()
        self.newAddress  = UIButton()
        
        super.init(frame:.zero)
        
        navigationPanel.delegate = self
        self.newAddress.setTitle("new address", for: .normal)
        self.newAddress.addTarget(self, action: #selector(openAddressDialog), for: .touchUpInside)
        
        self.isUserInteractionEnabled = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.autoresizingMask = []
        self.backgroundColor = .white
        
        axis         = .vertical
        distribution = .fill
        alignment    = .fill
    
        let firstView = self.addressViews[keyOrder[0]]!
        insertArrangedSubview(firstView, at: 0)
        addArrangedSubview(navigationPanel)
        addArrangedSubview(newAddress)
            
        navigationPanel.setContentHuggingPriority(UILayoutPriority.defaultLow, for: NSLayoutConstraint.Axis.horizontal)
        newAddress.setContentHuggingPriority(UILayoutPriority.defaultLow, for: NSLayoutConstraint.Axis.horizontal)
        
        NSLog("init() AddressSelection.frame \(self.frame)")
        self.logViewHierarchy(view: self, num: 0)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        print("============== \(type(of:self)) .hitTest ============ ")
        print("point:\(point)")
        if self.point(inside: point, with: event) {
            print("point is inside. calling super")
            return super.hitTest(point, with: event)
        }
        guard isUserInteractionEnabled, !isHidden, alpha > 0 else {
            return nil
        }

        for subview in subviews.reversed() {
            let convertedPoint = subview.convert(point, from: self)
            if let hitView = subview.hitTest(convertedPoint, with: event) {
                return hitView
            }
        }
        return nil
    }
    */
    @objc func openAddressDialog() {
        NSLog("======= new address =========")
    }
    /*
     * increments selected address index
     */
    @objc func showNext() {
        selectedAddressIndex = (selectedAddressIndex+1)%addresses.count
        showAddress()
        
    }
    
    @objc func showPrev() {
        if (selectedAddressIndex <= 0) {
            selectedAddressIndex = addresses.count - 1
        } else {
            selectedAddressIndex -= 1
        }
        showAddress()
    }
    
    /*
     * shows address at currently selected index
     */
    func showAddress() {
        let key = keyOrder[self.selectedAddressIndex]
        NSLog("\(type(of:self)).showAddress [\(key)] at index \(selectedAddressIndex) of \(addresses.count)")
        let exists = addressViews[key] != nil
        let viewToRemove = arrangedSubviews[0]
        let viewToReplace = addressViews[keyOrder[selectedAddressIndex]]!
        self.removeArrangedSubview(viewToRemove)
        viewToRemove.removeFromSuperview()
        self.insertArrangedSubview(viewToReplace, at: 0)
        setNeedsDisplay()
    }
   
    var selectedAddress:Address {
        get {
            return self.addresses[self.keyOrder[selectedAddressIndex]]!
        }
    }
    
    
    override var intrinsicContentSize:CGSize {
        get {
            let dynamicAddressView = self.arrangedSubviews[0]
            let width:CGFloat  = dynamicAddressView.intrinsicContentSize.width
            let height:CGFloat = dynamicAddressView.intrinsicContentSize.height
                + navigationPanel.intrinsicContentSize.height
                + newAddress.intrinsicContentSize.height

            return CGSize(width: width, height: height)
        }
    }
    
    func logViewHierarchy(view: UIView, num: Int) {
        var index = num
        for _ in 0..<index {
            print("\t", terminator: "")
        }

        index = index + 1
        print("\(NSStringFromClass(type(of: view))) userInteractionEnabled: \(view.isUserInteractionEnabled)")
        for subview in view.subviews {
            self.logViewHierarchy(view: subview as! UIView, num: index)
        }
    }
}

/*
 *
 */
class NavigationButton :UIButton {
    let up:Bool
    var delegate:AddressSelectionView?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override var description: String {
        get {
            return "Navigation button \(up ? "+":"-")"
        }
    }
    init(next:Bool) {
        self.up = next
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        let text = next ? "\u{25B6}" : "\u{25C0}" 
        self.setTitle(text, for: [])
        self.setTitleColor(.black, for: .normal)
        self.setTitleColor(.gray,  for: .disabled)
        self.addTarget(self,
            action: #selector(showAddress),
            for: .touchUpInside)
        self.backgroundColor = .yellow
    }
    
    @objc
    func showAddress() {
        NSLog(" \(type(of:self)) showAddress")
            
        guard let c = delegate else {
            return
        }
        if (up) {
            NSLog("\(self) calling showNext()")
            c.showNext()
        } else {
            NSLog("\(self) calling showPrev()")
            c.showPrev()
        }
    }
}

class NavigationPanel :UIStackView {
    var nextButton:NavigationButton
    var prevButton:NavigationButton
    var delegate:AddressSelectionView? {
        didSet {
            nextButton.delegate = delegate
            prevButton.delegate = delegate
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        self.nextButton = NavigationButton(next: true)
        self.prevButton = NavigationButton(next:false)
        super.init(frame: .zero)
        
        axis = .horizontal
        alignment = .top
        distribution = .fill
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled = true

        addArrangedSubview(prevButton)
        addArrangedSubview(nextButton)
        
        //prevButton.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        //nextButton.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    override var description: String {
        get {
            return "Navigation panel"
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize (width: 200, height: 48)
    }
    
   
}

