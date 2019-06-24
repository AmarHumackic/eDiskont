import React, { Component } from 'react';
import { connect } from 'react-redux';

import classes from './Cart.css';
import Button from '../UI/Button/Button';
import * as actions from '../../store/actions/index';
import imgDelete from '../../assets/images/icons8-circled-x-50.png';

class Cart extends Component {
    inputChangedHandler = (event, itemId) => {
        this.props.onInputSizeChanged(itemId, event.target.value);
    }

    removeItemHadler = (itemId) => {
        this.props.onItemRemoved(itemId);
    } 

    limitItemTitle = (title, limit = 17) => {
        const newTitle = [];
        if (title.length > limit) {
            title.split(' ').reduce((acc, cur) => {
                if (acc + cur.length <= limit) {
                    newTitle.push(cur);
                }
                return acc + cur.length;
            }, 0);
    
            return `${newTitle.join(' ')}...`;
        }
        return title;
    }
 
    render () {
        let itemsList = null;
        if(this.props.orderItems) {
            itemsList = this.props.orderItems.map(item => {
                    return (
                        <li key={item.itemId}>
                            <input
                                style={{width: '40px'}}
                                type="number"
                                name={item.itemName}
                                value={item.value}
                                onChange={(event) => this.inputChangedHandler(event, item.itemId)} />
                            <p>x - <span style={{textTransform: 'capitalize'}}>{this.limitItemTitle(item.itemName)}</span></p>
                            <img src={imgDelete} alt="Delete" onClick={() => this.removeItemHadler(item.itemId)}></img>
                        </li>
                    );
                }
            );
        }

        return(
            <div className={classes.Cart}>
                <h2 >Narudžba</h2>
                <ul>
                    {itemsList}
                </ul>
                {this.props.price > 0 ? 
                <div>
                    <p>Ukupan iznos: {this.props.price.toFixed(2)} KM</p> 
                    { this.props.isAuth ? 
                    <Button btnType="Success" clicked={this.props.orderContinued}>Naruči</Button> : 
                    <Button className={classes.btn} btnType="Success" clicked={this.props.orderContinued}>Prijavi se za narudžbu</Button> }
                </div> : null }
            </div>
        );
    }
};

const mapStateToProps = (state) => {
    return {
        orderItems: state.orderBuilder.orderItems,
        price: state.orderBuilder.totalPrice
    };
};

const mapDispatchToProps = dispatch => {
    return {
        onInputSizeChanged: (itemId, size) => dispatch(actions.changeItemSize(itemId, size)),
        onItemRemoved: (itemId) => dispatch(actions.removeItem(itemId))
    };
};

export default connect(mapStateToProps, mapDispatchToProps)(Cart);