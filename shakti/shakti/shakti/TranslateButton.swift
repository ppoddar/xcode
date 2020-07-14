import UIKit

/*
 *
 */
class TranslateButton: UIButton {
    var controller:PoemViewController?
    init() {
        super.init(frame:.zero)
        self.setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
        clipsToBounds = true
        self.addTarget(self,
            action: #selector(showTranslation),
            for: .touchUpInside)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     * shows poem in opposite language
     */
    @objc func showTranslation() {
        controller?.showReverse()
    }
}

