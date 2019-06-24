import React, { Component } from 'react';
import { connect} from 'react-redux';

import Order from '../../components/Order/Order';
import * as actions from '../../store/actions/index';
import classes from './Orders.css';
import Spinner from '../../components/UI/Spinner/Spinner';

class Orders extends Component {
    componentDidMount() {
        if(this.props.orders.length === 0 || !this.props.started) {
            this.props.onFetchOrder(this.props.token, this.props.userId);
        }
    }

    orderDetailsHandler = (i) => {
        this.props.history.push('/order-details', { ...this.props.orders[i] });
    };

    render() {
        let outputOrders = null;
        if(!this.props.loading) {
            outputOrders = this.props.orders.map((order, i) => {
                return <Order key={order.OrderID} name={order.OrderData.FullName} date={order.Date} totalPrice={order.TotalPrice}
                    orderDetails={() => this.orderDetailsHandler(i)}></Order>;
            });
        } else {
            outputOrders = <div style={{
                position: 'fixed',
                top: '20%',
                left: '40%'
            }}><Spinner></Spinner></div>;
        }
     
        let paragraph = null;
        if(this.props.orders.length > 0) {
            paragraph =  <p className={classes.p}>Za prikaz detalja kliknite na narudžbu.</p>;
        }
        return (
            <div>
                {paragraph}
                {outputOrders}
            </div>
        );
    }
}

const mapStateToProps = state => {
    return {
        orders: state.order.orders,
        loading: state.order.loading,
        token: state.auth.token,
        userId: state.auth.userId,
        started: state.orderBuilder.started
    };
};

const mapDispatchToProps = dispatch => {
    return {
        onFetchOrder: (token, userId) => dispatch(actions.fetchOrders(token, userId))
    };
};

export default connect(mapStateToProps, mapDispatchToProps)(Orders);