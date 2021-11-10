import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var personagem1ImageView: UIImageView!
    @IBOutlet weak var personagem1Label: UILabel!
    @IBOutlet weak var personagem2ImageView: UIImageView!
    @IBOutlet weak var personagem2Label: UILabel!
    @IBOutlet weak var personagem3ImageView: UIImageView!
    @IBOutlet weak var personagem3Label: UILabel!
    @IBOutlet weak var personagem4ImageView: UIImageView!
    @IBOutlet weak var personagem4Label: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var previousPageButton: UIButton!
    @IBOutlet weak var nextPageButton: UIButton!
    @IBOutlet weak var searchQueryTextField: UITextField!
    
    let charactersViewModel = CharactersViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        charactersViewModel.getCharactersList {
            self.updateView()
        }
    }
    
    func updateView() {
        self.pageControl.numberOfPages = self.charactersViewModel.numbersOfPagesNeeded()
        
        self.customizeCharacterCell(imageView: personagem1ImageView, label: personagem1Label, index: 0)
        self.customizeCharacterCell(imageView: personagem2ImageView, label: personagem2Label, index: 1)
        self.customizeCharacterCell(imageView: personagem3ImageView, label: personagem3Label, index: 2)
        self.customizeCharacterCell(imageView: personagem4ImageView, label: personagem4Label, index: 3)
        
        self.showHidePageControllers()
    }
    
    func customizeCharacterCell(imageView: UIImageView, label: UILabel, index: Int) {
        if pageControl.currentPage * 4 + 1 + index <= charactersViewModel.charactersList.count {
            imageView.image = UIImage(systemName: "photo")
            label.text = charactersViewModel.charactersList[pageControl.currentPage * 4 + index].name
        } else {
            imageView.image = nil
            label.text = ""
        }
    }
    
    func showHidePageControllers() {
        if charactersViewModel.charactersList.count > 0 {
            switch pageControl.currentPage {
            case 0:
                previousPageButton.alpha = 0
                nextPageButton.alpha = 1
            case pageControl.numberOfPages - 1:
                previousPageButton.alpha = 1
                nextPageButton.alpha = 0
            default:
                previousPageButton.alpha = 1
                nextPageButton.alpha = 1
            }
        } else {
            previousPageButton.alpha = 0
            nextPageButton.alpha = 0
        }
    }
    
    @IBAction func previousPageButtonPressed(_ sender: Any) {
        pageControl.currentPage -= 1
        updateView()
    }
    
    @IBAction func nextPageButtonPressed(_ sender: Any) {
        pageControl.currentPage += 1
        updateView()
    }
    
    @IBAction func editingTextField(_ sender: Any) {
        pageControl.currentPage = 0
        let searchQueryText: String = searchQueryTextField.text ?? ""
        if !searchQueryText.isEmpty {
            charactersViewModel.filteredCharacters(by: searchQueryText)
        } else {
            charactersViewModel.resetFilteredCharactersList()
        }
        if charactersViewModel.charactersList.isEmpty {
            charactersViewModel.getCharactersStartingWith(searchQueryText) {
                self.updateView()
            }
        }
        updateView()
    }
    
}

