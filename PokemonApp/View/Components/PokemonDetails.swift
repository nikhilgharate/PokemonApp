//
//  PokemonDetails.swift
//  PokemonApp
//
//  Created by iAURO on 30/07/24.
//
import SwiftUI
import Kingfisher

// View for displaying detailed information about a Pokémon
struct PokemonDetail: View {
    // Binding to manage presentation mode (for dismissing the view)
    @Environment(
        \.presentationMode
    ) var presentationMode: Binding<PresentationMode>
    
    // ObservedObject for the view model
    @ObservedObject var viewModel = PokemonviewModel()
    
    // Pokémon data to be displayed
    var pokemon: Pokemon
    
    var body: some View {
        ZStack {
            // Set the background color based on the Pokémon type
            Color(
                viewModel.backgroundColor(
                    forType: pokemon.type
                )
            )
            
            // Scrollable view for the content
            ScrollView {
                Spacer()
                    .frame(
                        height: 40
                    )
                
                // Display Pokémon image using Kingfisher
                KFImage(
                    URL(
                        string: pokemon.imageUrl
                    )
                )
                .resizable()
                .scaledToFit()
                .frame(
                    width: 200,
                    height: 250
                )
                .padding(
                    .leading,
                    20
                )
                .padding(
                    .trailing,
                    20
                )
                .padding(
                    .top,
                    20
                )
                
                // Description view for the Pokémon
                DescriptionView(
                    pokemon: pokemon
                )
            }
        }
        .navigationBarBackButtonHidden(
            true
        )
        .navigationBarItems(
            leading: BackButton(action: {
                presentationMode.wrappedValue.dismiss()
            }),
            // Custom back button
            trailing: Image(
                "threeDot"
            ) // Placeholder for an additional navigation item
        )
        .edgesIgnoringSafeArea(
            .top
        )
    }
}

// View for displaying the Pokémon description and details
struct DescriptionView: View {
    var pokemon: Pokemon
    
    var body: some View {
        VStack(
            alignment: .leading
        ) {
            // Pokémon name title
            Text(
                pokemon.name
            )
            .font(
                .title
            )
            .fontWeight(
                .bold
            )
            
            // Description title
            Text(
                "Description"
            )
            .fontWeight(
                .medium
            )
            .padding(
                .vertical,
                8
            )
            
            // Pokémon description text
            Text(
                pokemon.description
            )
            .lineSpacing(
                8.0
            )
            .opacity(
                0.6
            )
            
            // Info section with height, weight, and type
            HStack(
                alignment: .top
            ) {
                VStack(
                    alignment: .leading
                ) {
                    Text(
                        "Size"
                    )
                    .font(
                        .system(
                            size: 16
                        )
                    )
                    .fontWeight(
                        .semibold
                    )
                    
                    Text(
                        "Height: \(pokemon.height) cm"
                    )
                    .opacity(
                        0.6
                    )
                    
                    Text(
                        "Weight: \(pokemon.weight) kg"
                    )
                    .opacity(
                        0.6
                    )
                    
                    Text(
                        "Type: \(pokemon.type)"
                    )
                    .opacity(
                        0.6
                    )
                }
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
            }
            .padding(
                .vertical
            )
        }
        .padding()
        .padding(
            .top
        )
        .background(
            Color(
                "Bg"
            )
        )
        //        .cornerRadius(30, corners: [.topLeft, .topRight])
        .offset(
            x: 0,
            y: 0.0
        )
    }
}

// Shape for rounded corners
//struct RoundedCorner: Shape {
//    var radius: CGFloat = .infinity
//    var corners: UIRectCorner = .allCorners
//
//    func path(in rect: CGRect) -> Path {
//        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//        return Path(path.cgPath)
//    }
//}

// Extension to apply rounded corners to specific corners
//extension View {
//    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
//        clipShape(RoundedCorner(radius: radius, corners: corners))
//    }
//}

// View for displaying a colored dot (used for type indicators)
//struct ColorDotView: View {
//    let color: Color
//
//    var body: some View {
//        color
//            .frame(width: 24, height: 24)
//            .clipShape(Circle())
//    }
//}

// Uncomment and update this section if you have a mock Pokémon data for previewing
// struct PokemonDetail_Previews: PreviewProvider {
//     static var previews: some View {
//         PokemonDetail(pokemon: MOCK_POKEMON[1])
//     }
// }
