import SwiftUI
import UIKit

struct SongDetailView: View {
    var song: Song
    @State private var backgroundColor: Color = .gray
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.down")
                        .font(.system(size: 32))
                }
                Spacer()
            }

            Spacer()

            
            AsyncImage(url: URL(string: song.albumArt ?? "")) { phase in
                switch phase {
                case .empty:
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.gray.opacity(0.6))
                        .frame(width: 320, height: 320)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 320, height: 320)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .onAppear {
                            
                            loadImageAndExtractColor(from: song.albumArt ?? "")
                        }
                case .failure:
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.gray)
                        .frame(width: 200, height: 200)
                @unknown default:
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.gray)
                        .frame(width: 200, height: 200)
                }
            }

            Text(song.title)
                .font(.system(size: 24, weight: .bold))
                .padding(.top, 20)

            Text(song.artists.map { $0.artistName }.joined(separator: ", "))
                .foregroundColor(.secondary)
                .font(.system(size: 18))
                .padding(.top, 5)

            Spacer()

            Button(action: {
                //
            }) {
                Image(systemName: "play.circle.fill")
                    .font(.system(size: 63))
                    .foregroundColor(.indigo)
            }

        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [backgroundColor, backgroundColor.opacity(0.2)]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .navigationBarTitle("", displayMode: .inline)
    }

    
    func loadImageAndExtractColor(from url: String) {
        guard let imageUrl = URL(string: url) else { return }

        
        URLSession.shared.dataTask(with: imageUrl) { data, _, _ in
            guard let data = data, let uiImage = UIImage(data: data) else { return }

            
            if let dominantColor = getDominantColor(from: uiImage) {
                DispatchQueue.main.async {
                    self.backgroundColor = dominantColor
                }
            }
        }.resume()
    }

    
    func getDominantColor(from image: UIImage) -> Color? {
        let cgImage = image.cgImage!
        let width = cgImage.width
        let height = cgImage.height

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 4 * width, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)
        
        context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        guard let pixelBuffer = context?.data else { return nil }
        
        let pixel = pixelBuffer.bindMemory(to: UInt32.self, capacity: width * height)
        let pixelCount = width * height
        
        var colorFrequency: [UIColor: Int] = [:]
        
        
        for pixelIndex in 0..<pixelCount {
            let color = UIColor(
                red: CGFloat((pixel[pixelIndex] >> 16) & 0xFF) / 255.0,
                green: CGFloat((pixel[pixelIndex] >> 8) & 0xFF) / 255.0,
                blue: CGFloat(pixel[pixelIndex] & 0xFF) / 255.0,
                alpha: 1.0
            )
            colorFrequency[color, default: 0] += 1
        }
        
        
        guard let mostFrequentColor = colorFrequency.max(by: { $0.value < $1.value })?.key else { return nil }
        
        return Color(mostFrequentColor)
    }
}
