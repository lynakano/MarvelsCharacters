import Foundation

final class CharactersRepository {
    let service = MarvelService()
    
    func getCharacterList(completion: @escaping ([Character]) -> Void) {
        service.fetchCharacters { characterResponse in
            completion(characterResponse.data.results)
        }
    }
    
    func getCharactersListStartingWith(_ string: String, completion: @escaping ([Character]) -> Void) {
        service.fetchCharactersStartingWith(string) { characterResponse in
            completion(characterResponse.data.results)
        }
    }
    
    func getCharacterImage(path: String, extension: String, variant: ThumbnailVariant, completion: @escaping (Data?) -> Void) {
        service.fetchCharacterImage(path: path, extension: `extension`, variant: variant) { data in
            completion(data)
        }
    }
}
