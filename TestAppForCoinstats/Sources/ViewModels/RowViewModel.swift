
import Foundation

protocol RowViewModel {}

protocol ViewModelPressible {
    var cellPressed: (()->Void)? { get set }
}
