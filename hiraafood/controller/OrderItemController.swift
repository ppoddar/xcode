import UIKit
class OrderItemController: UIViewController {
    var cart:Cart
    var item:Item
    var itemView:ItemView
    var units:Counter
    var comment:KeyboardTextView
    var orderButton:UIButton
    var layoutComplete:Bool
    
    init(item:Item,  cart:Cart) {
        NSLog("\(type(of:self)).init() with \(item)")
        self.item = item
        self.cart = cart
        self.itemView = ItemView(item: item)
        self.units = Counter(text:"how many?", start:cart[item.sku]?.units ?? 1 )
        self.comment = UIFactory.textView(
            placeHolderText: "any instructions for the chef?")
        comment.backgroundColor =  UIConstants.COLOR_MUTED
        self.orderButton = UIFactory.button("order")
        layoutComplete = false
        
        super.init(nibName: nil, bundle: nil)
        

        self.view.frame = .zero
        self.view.autoresizingMask = []
        self.view.backgroundColor = .white
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.title = "Order"
        self.orderButton.addTarget(self,
            action: #selector(order),
            for:.touchUpInside)
   }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
     * framework callback
     *     set frame to self.view
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        let safeArea = self.view.safeAreaLayoutGuide
        setSceneHeader()
        self.view.frame = CGRect(
            x:safeArea.layoutFrame.origin.x,
            y:safeArea.layoutFrame.origin.y,
            width:UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height)
        // keyboard events
        NotificationCenter.default.addObserver(self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
        
        
    }
    /*
     * framework callback
     * add all constraints
     */
    override func loadView() {
        super.loadView()
        self.view.addSubview(itemView)
        self.view.addSubview(units)
        self.view.addSubview(comment)
        self.view.addSubview(orderButton)
    }
    
    override func viewWillLayoutSubviews() {
        if (layoutComplete) {return}
        print(" \(type(of: self)).viewWillLayoutSubviews")
        let safeArea = self.view.safeAreaLayoutGuide
        let margins  = self.view.layoutMargins
        print("safeArea \(safeArea)")
        print("margins \(margins)")
        // constraints of anchor UI element (itemView)
        // is pinned to self.view
        // The other UI elemenst are constrained
        // relative to anchor item
        guard let superview = self.view.superview else {
            print("=========== NO SUPERVIEW On viewDidLoad ============")
            return
        }
        UIFactory.pin(self.view, toView: superview)

        itemView.frame = CGRect(
            x:margins.left,
            y:margins.top,
            width: itemView.intrinsicContentSize.width,
            height: itemView.intrinsicContentSize.height)
        print("itemView.frame \(itemView.frame)")
        NSLayoutConstraint.activate([
            itemView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: margins.left),
            itemView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: margins.left),
            itemView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            itemView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: UIConstants.VGAP),
            //itemView.heightAnchor.constraint(equalToConstant: itemView.frame.height),
            itemView.heightAnchor.constraint(equalTo:self.view.heightAnchor, multiplier: 0.5),
            
            units.topAnchor.constraint(equalTo: itemView.bottomAnchor),
            units.centerXAnchor.constraint(equalTo: itemView.centerXAnchor),
           
            comment.topAnchor.constraint(equalTo: units.bottomAnchor),
            comment.centerXAnchor.constraint(equalTo: itemView.centerXAnchor),
            
            orderButton.topAnchor.constraint(equalTo: comment.bottomAnchor),
            comment.centerXAnchor.constraint(equalTo: itemView.centerXAnchor)

        ])
        layoutComplete = true
        super.viewWillLayoutSubviews()
    }
    
    @objc func back() {
        self.navigationController?
            .popViewController(animated: true)
    }
    
    @objc func order() {
        cart.addItem(item:self.item,
            units: units.value,
            comment:comment.text)
        (presentingViewController as? MenuController)?.itemInsertedInCart()
        back()
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {
        NSLog("keyboad will show")
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            else {
                return
        }
        NSLog("keyboard size \(keyboardSize)")
        NSLog("view origin \(self.view.frame.origin.y)")
        self.view.frame.origin.y -= keyboardSize.height
        NSLog("adjusted to \(self.view.frame.origin.y)")
    }
    
    @objc func keyboardWillHide(notification:NSNotification) {
           if self.view.frame.origin.y != 0 {
               self.view.frame.origin.y = 0
           }
    }
    
    
    
}






