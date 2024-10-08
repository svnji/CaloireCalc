import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var genderSelector: UISegmentedControl!
    @IBOutlet weak var caloriesViewer: UILabel!
    @IBOutlet weak var popUpBtn: UIButton!
    
 
    var gender: Int = 0
    
    
    let activityMultipliers: [Double] = [1.2, 1.375, 1.55, 1.725, 1.9]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPopupBtn()
        gender = genderSelector.selectedSegmentIndex
    }
    
    func setPopupBtn() {
        let optionClosure = { (action: UIAction) in
            print(action.title)
        }
        
        popUpBtn.menu = UIMenu(children: [
            UIAction(title: "Sedentary (little or no exercise)", handler: optionClosure),
            UIAction(title: "Lightly active (light exercise or sports 1-3 days/week)", handler: optionClosure),
            UIAction(title: "Moderately active (moderate exercise/sports 3-5 days/week)", handler: optionClosure),
            UIAction(title: "Very active (hard exercise/sports 6-7 days a week)", handler: optionClosure),
            UIAction(title: "Super active (very hard exercise/physical job)", handler: optionClosure)
        ])
        
        popUpBtn.showsMenuAsPrimaryAction = true
        popUpBtn.changesSelectionAsPrimaryAction = true
    }
    
    @IBAction func calculateBtnTapped(_ sender: Any) {
        guard let ageText = ageTextField.text, let age = Int(ageText) else {
            showAlert(message: "Invalid age input. Please enter a valid number.")
            return
        }

        
        guard let weightText = weightTextField.text, let weight = Int(weightText) else {
            showAlert(message: "Invalid weight input. Please enter a valid number.")
            return
        }

        guard let heightText = heightTextField.text, let height = Int(heightText) else {
            showAlert(message: "Invalid height input. Please enter a valid number.")
            return
        }

        gender = genderSelector.selectedSegmentIndex
        
        var bmr: Double = 0.0

        if gender == 0 { // Male
            bmr = 10 * Double(weight) + 6.25 * Double(height) - 5 * Double(age) + 5
        } else { // Female
            bmr = 10 * Double(weight) + 6.25 * Double(height) - 5 * Double(age) - 161
        }
        
        let activityIndex = popUpBtn.menu?.children.firstIndex(where: { $0.title == "Sedentary (little or no exercise)" }) ?? 0
        
        // Calculate TDEE using the activity multiplier
        let tdee = bmr * activityMultipliers[activityIndex]

        caloriesViewer.text = "TDEE: \(tdee)"
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: "Input Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
