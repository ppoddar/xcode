import UIKit

/*
 * Content View Controller cycles through a set of
 * addresses and lets you create new addresses.
 * Address is rendered by AddressView
 */
class AddressSelectionView: UIView {
    var addressView:AddressView
    var selectedAddressIndex:Int
    var nextAddress:NavigationButton
    var prevAddress:NavigationButton
    var newAddress:UIButton
    var keyOrder:[String]
    var addresses:Dictionary<String,Address>
    /*
     * create this view with array of given addresses
     */
    init(addresses:Dictionary<String,Address>) {
        print("-------------- AddressSelection.init() addresses \(addresses)")
        self.addresses   = addresses
        self.addressView = AddressView()
        self.selectedAddressIndex = 0
        self.keyOrder = addresses.keys.sorted()
        self.nextAddress = NavigationButton(next:true)
        self.prevAddress = NavigationButton(next:false)
        self.newAddress  = UIButton()
        super.init(frame:.zero)
        nextAddress.delegate = self
        prevAddress.delegate = self
        self.newAddress.setTitle("new address", for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.autoresizingMask = []
        
        newAddress.addTarget(self, action: #selector(openAddressDialog), for: .touchUpInside)
    
        //self.view.frame = CGRect(x:0,y:0, width:UIScreen.main.bounds.width, height:UIScreen.main.bounds.height)
   
        print("init() AddressSelection.frame \(self.frame)")
    }
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        self.addressView.translatesAutoresizingMaskIntoConstraints = false
        self.newAddress.translatesAutoresizingMaskIntoConstraints  = false
        self.prevAddress.translatesAutoresizingMaskIntoConstraints = false
        self.nextAddress.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(addressView)
        self.addSubview(nextAddress)
        self.addSubview(prevAddress)
        self.addSubview(newAddress)
        
        newAddress.backgroundColor = UIConstants.COLOR_2
   
        //print("viewWillLayoutSubviews. Computing frame")
        let safeArea = self.safeAreaLayoutGuide
        let margins  = self.layoutMarginsGuide
        //print("within safeArea \(safeArea.layoutFrame)")
        //print("with   margin \(margins.layoutFrame)")
       
        addressView.topAnchor.constraint(equalTo:  safeArea.topAnchor).isActive = true
        addressView.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        //addressView.widthAnchor.constraint(equalTo: safeArea.widthAnchor).isActive = true
        //addressView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, constant: -50).isActive = true
    
        prevAddress.topAnchor.constraint(equalTo:  addressView.bottomAnchor).isActive = true
        prevAddress.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        
        nextAddress.topAnchor.constraint(equalTo: addressView.bottomAnchor).isActive = true
        nextAddress.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true

        newAddress.topAnchor.constraint(equalTo:   nextAddress.bottomAnchor).isActive = true
        newAddress.leftAnchor.constraint(equalTo:  addressView.leftAnchor).isActive = true
        newAddress.rightAnchor.constraint(equalTo: addressView.rightAnchor).isActive = true
    
        showAddress()

    }
    
        
   
    @objc func openAddressDialog() {
        
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
    private func showAddress() {
        let key = keyOrder[self.selectedAddressIndex]
        //print("showing address [\(key)] at index \(selectedAddressIndex) of \(addresses.count)")
        addressView.address = self.addresses[key]
    }
   
    var selectedAddress:Address {
        get {
            return self.addresses[self.keyOrder[selectedAddressIndex]]!
        }
    }
    
    
//    override var intrinsicContentSize:CGSize {
//        get {
//            let width:CGFloat = addressView.intrinsicContentSize.width
//            let height:CGFloat = addressView.intrinsicContentSize.height
//                + nextAddress.intrinsicContentSize.height
//                + 2*UIConstants.VGAP
//
//            return CGSize(width: width, height: height)
//        }
//    }
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
        self.backgroundColor = .white
    }
    
    @objc
    func showAddress() {
        guard let c = delegate else {
            return
        }
        if (up) {
            //print("Navigation button \(self.titleLabel?.text) calling showNext()")
            c.showNext()
        } else {
            //print("Navigation button \(self.titleLabel?.text) calling showPrev()")
            c.showPrev()
        }
    }
}
