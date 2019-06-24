import React, { Component } from 'react';

import classes from './OrderDetails.css';

class OrderDetails extends Component {
    render() {
        const order = this.props.location.state;

        const style = {
            textTransform: 'capitalize',
            display: 'block',
            margin: '8 8px',
            border: '1px solid #ccc',
            padding: '6px',
        };

        const items = [];
        for(let key in order.Items) {
            items.push({
                name: order.Items[key].Name,
                amount: order.Items[key].Amount,
                price: order.Items[key].Price,
            });
        }
        const itemOutput = items.map(item => {
            const amountPrice = item.amount * item.price;
            return <span style={style} key={item.name}>{item.name}: ({item.amount}) x ({item.price}) KM = {amountPrice.toFixed(2)} KM</span>;
        });

        return (
            <div className={classes.OrderDetails}>
                <h2>Podaci o narudžbi</h2>

                <div className={classes.Item}>
                    <p style={{textAlign:'left'}}><strong>Narudžba:</strong> {itemOutput} </p>
                </div>
                <div className={classes.Item}>
                    <p style={{textAlign:'left'}}><strong>Kontakt podaci:</strong> 
                        <span style={style}>Ime: {order.OrderData.FullName}</span>
                        <span style={style}>Firma: {order.OrderData.Company}</span>
                        <span style={style}>Adresa: {order.OrderData.DeliveryAddress}</span>
                        <span style={style}>Grad: {order.OrderData.City}</span>
                        <span style={style}>Isporuka: {order.OrderData.DeliveryMethod}</span>
                    </p>
                </div>

                <p>Ukupan iznos: <strong>{Number.parseFloat(order.TotalPrice).toFixed(2)} KM</strong></p>
                <p>Naručeno: {order.Date}</p>
            </div>
        );
    }
}

export default OrderDetails;