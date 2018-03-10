import React from 'react'

export const Pixel = props => (
    <span
        className="pixel"
        onClick={e => props.onClick(e)}
        style={{ backgroundColor: props.color }}
    />
)
