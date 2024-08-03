import SwiftUI

struct ContentView: View {
	var body: some View {
		GeometryReader { fullView in
			ScrollView(.vertical) {
				ForEach(0..<50) { index in
					GeometryReader { proxy in
						let minY = proxy.frame(in: .global).minY
						let opacity = calculateOpacity(for: minY)
						let scale = calculateScale(for: minY, fullHeight: fullView.size.height)
						let color = calculateColor(for: minY, fullHeight: fullView.size.height)
						
						Text("Row #\(index)")
							.font(.title)
							.frame(maxWidth: .infinity)
							.background(color)
							.rotation3DEffect(
								.degrees(minY - fullView.size.height / 2) / 5,
								axis: (x: 0, y: 1, z: 0))
							.opacity(opacity)
							.scaleEffect(scale)
					}
					.frame(height: 40)
				}
			}
		}
	}
	
	func calculateOpacity(for minY: CGFloat) -> Double {
		let fadeStart: CGFloat = 200
		let fadeEnd: CGFloat = 0
		
		if minY > fadeStart {
			return 1
		} else if minY < fadeEnd {
			return 0
		} else {
			return Double((minY - fadeEnd) / (fadeStart - fadeEnd))
		}
	}
	
	func calculateScale(for minY: CGFloat, fullHeight: CGFloat) -> CGFloat {
		let minScale: CGFloat = 0.5
		let maxScale: CGFloat = 1.0
		let scaleStart: CGFloat = 200
		let scaleEnd: CGFloat = fullHeight
		
		if minY < scaleStart {
			return minScale
		} else if minY > scaleEnd {
			return maxScale
		} else {
			let calculatedScale = minScale + (maxScale - minScale) * (minY - scaleStart) / (scaleEnd - scaleStart)
			return max(minScale, calculatedScale)
		}
	}
	
	func calculateColor(for minY: CGFloat, fullHeight: CGFloat) -> Color {
		let hue = minY / fullHeight
		return Color(hue: hue, saturation: 1.0, brightness: 1.0)
	}
}

#Preview {
	ContentView()
}
