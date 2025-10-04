//
//  Avion.swift
//  ActExtraPoint
//
//  Created by WIN603 on 03/10/25.
//

import SwiftUI
import AVFoundation //librería para reproducir multimedia

struct Avion: View {
    @State private var player: AVAudioPlayer?
    @State var ejeX: CGFloat = 0
    @State var ejeY: CGFloat = 0
    @State var rotationDegrees: Double = 0
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "airplane")
                .font(.largeTitle)
                .foregroundColor(Color(hex:"#008080"))
                .offset(x: ejeX, y: ejeY)
                .rotationEffect(.degrees(rotationDegrees))
            
            Spacer()
            
            HStack(spacing: 20) {
                Button(action: {
                    withAnimation(.spring(response: 2, dampingFraction: 3.0, blendDuration: 4.0)) {
                        ejeX = 80
                        ejeY = -100
                        rotationDegrees = -45
                        reproducirSonido(nombreArchivo: "despegue", extensionArchivo: "mp3")
                    }
                }) {
                    Text("Despegar")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    withAnimation(.easeInOut(duration: 3.0)) {
                        ejeX = 200
                        ejeY = -100
                        rotationDegrees = 0
                    }
                }) {
                    Text("Volar")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    withAnimation(.spring(response: 2.5, dampingFraction: 0.8, blendDuration: 2.0)) {
                        ejeX = 0
                        ejeY = 0
                        rotationDegrees = 45
                        reproducirSonido(nombreArchivo: "explosion", extensionArchivo: "mp3")
                    }
                }) {
                    Text("Aterrizar")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding(.bottom)
        }
    }
    
    func reproducirSonido(nombreArchivo: String, extensionArchivo: String) {
        guard let ubicacionSonido = Bundle.main.url(forResource: nombreArchivo, withExtension: extensionArchivo) else {
            print("No se encontró el archivo de sonido '\(nombreArchivo).\(extensionArchivo)'. Revisar este en el proyecto")
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: ubicacionSonido)
            self.player?.play()
        } catch {
            print("Error al cargar o reproducir el sonido: \(error)")
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct Avion_Previews: PreviewProvider {
    static var previews: some View {
        Avion()
    }
}
