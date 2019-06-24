import React from 'react';

import classes from './DrinkControl.css';
import Button from '../../UI/Button/Button';

const drinkControl = (props) => (
    <div className={classes.DrinkControl}>
        <img src={"http://localhost:55781/api/Items/GetImage?imageName=" + props.photo + ".jpg"} alt="Loading..."></img>
        <p><strong style={{textTransform: 'capitalize'}}>{props.item}</strong> - {props.size}x</p>
        <p>Cijena: {props.price} KM</p>
        <Button btnType="Success" clicked={props.added}>Dodaj</Button>
    </div>
);

export default drinkControl;