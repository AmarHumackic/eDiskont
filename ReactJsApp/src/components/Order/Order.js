import React from 'react';

import classes from './Order.css';

const order = (props) => (
    <div className={classes.Order} onClick={props.orderDetails}>
        <p>Naručio: {props.name}</p>
        <p>Ukupan iznos: <strong>{Number.parseFloat(props.totalPrice).toFixed(2)} KM</strong> <br></br> 
        <span>{props.date}</span></p>
    </div>
);

export default order;