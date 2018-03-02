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

function createPixel() {
    let pixel = document.createElement("div");
    pixel.className = "pixel";

    let color = colors[Math.floor(Math.random() * colors.length)];
    pixel.style.backgroundColor = color;

    return pixel;
}

function addPixels() {
    let canvas = document.getElementById("main-canvas");

    for (let i = 0; i < pixelAmount; i++) {
        let pixel = createPixel(canvas);

        canvas.appendChild(pixel);
    }
}

addPixels();
