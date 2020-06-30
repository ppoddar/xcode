/*
 * selects one among many address.
 * composes of following subview UI elements:
 *    an AddressView  where selected address is shown
 *    pair of buttons to cycle through multiple addresses
 *    a button to open a form to create new address
 *
 */
import UIKit
class AddressSelection: UIView {
    var dynamicAddressView:UIStackView = UIStackView()
    var selectedAddressIndex:Int = 0
    var addresses:[Address]
    /*
     * create this view with array of given addresses
     */
    init(addresses:[Address]) {
        self.addresses = addresses
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     * show first address
     */
    func setupView() {
        backgroundColor = .white
        dynamicAddressView.axis         = .vertical
        dynamicAddressView.alignment    = .leading
        dynamicAddressView.distribution = .fill
        
        self.showAddress(0)
    }
    
    func createNavigationControl(_ idx:Int) -> UIView {
        let next = NavigationButton(text:"+", target: idx+1, controller: self)
        let prev = NavigationButton(text:"-", target: idx-1, controller: self)
        
        let control = UIStackView()
        control.axis = .horizontal
        control.alignment = .top
        control.distribution = .fill
        control.addArrangedSubview(prev)
        control.addArrangedSubview(next)
        
        return control
    }
    
    func createNewAddressButton() -> UIView {
        let button =  UIFactory.button("New address")
        
        button.addTarget(self,
                         action: #selector(openAddressDialog),
                         for: .touchUpInside)
        return button
    }
    
    @objc func openAddressDialog() {
        
    }
    /*
     * shows single address and associated navigation buttons
     */
    func showAddress(_ idx: Int) {
        UIFactory.clear(self.dynamicAddressView)
        self.selectedAddressIndex = idx
        
        dynamicAddressView.addArrangedSubview(AddressView())
        dynamicAddressView.addArrangedSubview(self.createNavigationControl(idx))
        dynamicAddressView.addArrangedSubview(self.createNewAddressButton())
    }
    
    var selectedAddress:Address {
        get {
            return self.addresses[self.selectedAddressIndex]
        }
    }
}

/*
 *
 */
class NavigationButton :UIButton {
    let label:String
    let target:Int
    let controller:AddressSelection
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    /*
     * create a navigation button
     * @param text button label
     * @param target index of the button to show when this
     *        button is clicked. If target is out of
     *        range of available addresses, the button is disabled
     * @param controller whose function is invoked to show
     *        selected address
     */
    init(text:String, target:Int, controller:AddressSelection) {
        self.label      = text
        self.target     = target
        self.controller = controller
        
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(text, for: [])
        self.setTitleColor(.black, for: .normal)
        self.setTitleColor(.black, for: .disabled)
        self.isEnabled = (target >= 0) && (target < controller.addresses.count)
        self.addTarget(self,
            action: #selector(showAddress),
            for: .touchUpInside)
    }
    
    @objc
    func showAddress() {
        self.controller.showAddress(self.target)
    }
}
