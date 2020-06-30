import UIKit

/*
 * Content View Controller cycles through a set of
 * addresses and lets you create new addresses.
 * Address is rendered by AddressView
 */
class AddressSelectionViewController: UIViewController {
    var addressView:AddressSelectionView
    var layoutCalled = false
    /*
     * create this view with array of given addresses
     */
    init(addresses:Dictionary<String,Address>) {
        self.addressView = AddressSelectionView(addresses: addresses)
        self.layoutCalled = false
        super.init(nibName: nil, bundle: nil)
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.autoresizingMask = []
    }
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    override func loadView() {
        super.loadView()
        self.view.addSubview(addressView)
   }
    
    /*
      * Called before this controller will layout
      * its subviews.
      * The frame and bounds of root view of this
      * controller has been computed before this
      * method is called by the framework.
      * This is appropriate method to add constraints
      * on the subviews.
      */
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if (layoutCalled) {return}
        //print("viewWillLayoutSubviews. Computing frame")
        let safeArea = self.view.safeAreaLayoutGuide
        let margins  = self.view.layoutMarginsGuide
        //print("within safeArea \(safeArea.layoutFrame)")
        //print("with   margin \(margins.layoutFrame)")
       
        addressView.topAnchor.constraint(equalTo:  safeArea.topAnchor).isActive = true
        addressView.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        //addressView.widthAnchor.constraint(equalTo: safeArea.widthAnchor).isActive = true
        //addressView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, constant: -50).isActive = true
    }
}

