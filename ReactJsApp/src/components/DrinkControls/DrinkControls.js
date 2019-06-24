import React, { Component } from 'react';

import DrinkControl from './DrinkControl/DrinkControl';
import classes from './DrinkControls.css';

class DrinkControls extends Component {
    render() {
        let itemsOutput = null;
        itemsOutput = this.props.items.map(item => {
            const img = item.ItemName;
            return <DrinkControl key={item.ItemID} item={item.ItemName} size={item.PackSize} 
               photo={img} price={(item.Price * item.PackSize).toFixed(2)} 
               added={() => this.props.itemAdded(item.ItemID, item.Price, item.ItemName, item.PackSize)}></DrinkControl>;
        })
        return (
            <div className={classes.DrinkControls}>
                {itemsOutput}
            </div>
        );
    }
};

export default DrinkControls;