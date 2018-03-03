const pixelAmount = 2000;

const colors = [
    "#000",
    "#111",
    "#333",
    "#555",
    "#777",
    "#888",
    "#aaa"
]

// Create a pixel with all of it's attributes set.
function createPixel() {
    let pixel = document.createElement("span");
    pixel.className = "pixel";

    // Use random colors for testing.
    let color = colors[Math.floor(Math.random() * colors.length)];
    pixel.style.backgroundColor = color;
    
    pixel.addEventListener("click", displayPixelInfo);

    return pixel;
}

// Add pixels to the main canvas.
function addPixels() {
    let canvas = document.getElementById("main-canvas");

    for (let i = 0; i < pixelAmount; i++) {
        let pixel = createPixel(canvas);

        canvas.appendChild(pixel);
    }
}

// Display info about a certain pixel.
function displayPixelInfo(event) {
    console.log(`Clicking on element ${event.target}` );
}

addPixels();
