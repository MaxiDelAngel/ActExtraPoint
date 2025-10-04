//
//  ContentView.swift
//  ActExtraPoint
//
//  Created by WIN603 on 03/10/25.
//

import SwiftUI
import AVFoundation //librería para reproducir multimedia

struct ContentView: View {
    @State private var player: AVAudioPlayer?
    @State var ejeX: CGFloat = 0
    @State var ejeY: CGFloat = 0
    @State var rotationDegrees: Double = 0
    
    var body: some View {
        VStack{
            
            Image(systemName: "airplane")
                .font(.largeTitle)
                .foregroundColor(Color(hex:"#008080"))
                .offset(x: ejeX, y: ejeY)
                .rotationEffect(.degrees(rotationDegrees))
            
            Button(action: {
                withAnimation(.spring(response: 2, dampingFraction: 3.0, blendDuration: 4.0)){
                    ejeX = 80
                    ejeY = -45
                    rotationDegrees = -45
                    reproducirSonido()
                }
            }) {
                Text("Despegar avión")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
        }
        
        
    }
    
    func reproducirSonido() {
        let nombreArchivo: String = "Avion"
        let extensionArchivo: String = "mp3"
        
        
        guard let ubicacionSonido = Bundle.main.url(forResource: nombreArchivo, withExtension: extensionArchivo) else {
            
            print("No se encontró el archivo de sonido.Revisar este en el proyecto")
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: ubicacionSonido)
            self.player?.play()
        } catch {
            print("Error al cargar el sonido: \(error)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



//extension Color {
//    init(hex: String) {
//        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
//        var int: UInt64 = 0
//        Scanner(string: hex).scanHexInt64(&int)
//        let a, r, g, b: UInt64
//        switch hex.count {
//        case 3: // RGB (12-bit)
//            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
//        case 6: // RGB (24-bit)
//            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
//        case 8: // ARGB (32-bit)
//            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
//        default:
//            (a, r, g, b) = (1, 1, 1, 0)
//        }
//        
//        self.init(
//            .sRGB,
//            red: Double(r) / 255,
//            green: Double(g) / 255,
//            blue:  Double(b) / 255,
//            opacity: Double(a) / 255
//        )
//    }
//}
