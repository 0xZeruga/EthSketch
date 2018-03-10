import React, { Component } from 'react'
import {
    Grid,
    Row,
    Button,
    Form,
    FormGroup,
    FormControl
} from 'react-bootstrap'

import { Pixel } from './Pixel'

class Main extends Component {
    state = {
        pixels: []
    }
    pixelAmount = 10000
    colors = ['#000', '#111', '#333', '#555', '#777', '#888', '#aaa']

    componentDidMount() {
        this.generatePixels()
    }

    generatePixels = () => {
        const pixels = []
        const colorLength = this.colors.length

        for (let i = 0; i < this.pixelAmount; i++) {
            pixels.push({
                color: this.colors[Math.floor(Math.random() * colorLength)]
            })
        }

        this.setState({ pixels })
    }

    displayPixelInfo(event) {
        console.log(`Clicking on element ${event.target}`)
    }

    render() {
        return (
            <Grid>
                <Row className="show-grid">
                    <h1>Bootstrap starter template</h1>
                    <p className="lead">A bareboned bootstrap example</p>
                </Row>

                <Row id="main-canvas" className="show-grid">
                    {this.state.pixels.map((pixel, index) => (
                        <Pixel
                            key={index}
                            onClick={this.displayPixelInfo}
                            color={pixel.color}
                        />
                    ))}
                </Row>

                <Row className="show-grid">
                    <Form horizontal>
                        <FormGroup
                            bsClass="colorPicker"
                            controlId="pixelColor"
                        >
                            <FormControl type="color" value="#ff0000" />
                        </FormGroup>

                        <FormGroup controlId="confirmButton">
                            <Button disabled>Confirm</Button>
                        </FormGroup>
                    </Form>
                </Row>
            </Grid>
        )
    }
}

export default Main
