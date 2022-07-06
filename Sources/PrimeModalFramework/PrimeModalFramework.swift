import SwiftUI
import Combine
import ComposableArch

public enum PrimeModalAction {
    case saveFavoritePrimeTapped
    case removeFavoritePrimeTapped
}


public struct PrimeModalState {
    public var count: Int
    public var favorites: [Int]
    
    public init (
        count: Int, favorites: [Int]
    ) {
        self.count = count
        self.favorites = favorites
    }
}


public func primeModalReducer(state: inout PrimeModalState, action: PrimeModalAction) {
    switch action {
    case  .saveFavoritePrimeTapped:
        state.favorites.append(state.count)
        
    case .removeFavoritePrimeTapped:
        state.favorites.removeAll(where: { $0 == state.count })
      
    }
}


public struct PrimeModal: View {
    @ObservedObject var store: Store<PrimeModalState, PrimeModalAction>
    
    public init(store: Store<PrimeModalState, PrimeModalAction>) {
        self.store = store
    }
    public var body: some View {
        if isPrime(store.value.count) {
            Text("\(store.value.count) is prime! 🎉")
            if store.value.favorites.contains(store.value.count) {
                Button {
                    store.send(.removeFavoritePrimeTapped)
                } label: {
                    Text("Remove favorite prims")
                }
            } else {
                Button {
                    store.send(.saveFavoritePrimeTapped)
                } label: {
                    Text("Save to favorites")
                }
            }
            
        } else{
            Text("\(store.value.count) is not prime 😟")
        }
        
    }
    
    private func isPrime (_ p: Int) -> Bool {
        if p <= 1 { return false }
        if p <= 3 { return true }
        for i in 2...Int(sqrtf(Float(p))) {
            if p % i == 0 { return false }
        }
        return true
    }
}


