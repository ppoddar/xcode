import UIKit
import Foundation
/*
 * A scrollable text view
 */
class PoemView: UITextView,UITextViewDelegate {
    init() {
        super.init(frame: .zero, textContainer: nil)

        delegate = self
        translatesAutoresizingMaskIntoConstraints = false
        autoresizingMask = [
            UIView.AutoresizingMask.flexibleWidth,
            UIView.AutoresizingMask.flexibleHeight]
        backgroundColor = .white
        textAlignment   = .left
        contentInsetAdjustmentBehavior = .always
        //UITextView will not resize if scrolling is enabled.
        isScrollEnabled = true
        isPagingEnabled = true
        isUserInteractionEnabled = true
        isEditable = false
        bounces = false
        alwaysBounceVertical = false
        showsVerticalScrollIndicator = true
        //scrollRangeToVisible(NSRange(location: 0, length: 0))
        contentOffset = CGPoint(x:0,y:0)
        layoutManager.allowsNonContiguousLayout = false

        //isOpaque = false
        //clipsToBounds = true
        //bounds = CGRect(x:0,y:0,width: 10, height: 100)

        indicatorStyle = UIScrollView.IndicatorStyle.black
        showsHorizontalScrollIndicator = true
        showsVerticalScrollIndicator = true
        //backgroundColor = .yellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        //let rect:CGRect = UIScreen.main.bounds
        //let rect:CGRect = superview!.bounds
        let rect:CGRect = .zero
        return CGSize(
            width:  rect.width,
            height: rect.height)
    }
    
}
