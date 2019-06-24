import React, { Component } from 'react';
import { connect } from 'react-redux';

import DrinkControls from '../../components/DrinkControls/DrinkControls';
import classes from './OrderBuilder.css';
import Cart from '../../components/Cart/Cart';
import * as actions from '../../store/actions/index';
import axios from '../../axios-config';
import Spinner from '../../components/UI/Spinner/Spinner';

export class OrderBuilder extends Component {
    state = {
        items: null,
        loading: false,
        currentId: 1
    }
    
    async componentDidMount() {
        if(!this.props.started) {
            this.props.onInitItems();
        }
    }

    async getItems() {
        const typeId = this.props.match.params.id;
        let response = await axios(`/Items/GetByType?typeId=${typeId}`);
        this.setState({ items: response.data, loading: false, currentId: typeId });
    };

    orderContinueHandler = () => {
        if(this.props.isAuthenticated) {
            this.props.history.push('/contact-data');
        } else {
            this.props.onSetAuthRedirectPath('/contact-data');
            this.props.history.push('/auth');
        }
    };

    render() {
        if(!this.state.items || this.state.currentId !== this.props.match.params.id) {
            this.getItems();
        }

        let items = null;
        if(this.state.items && !this.state.loading) {
            items = <DrinkControls items={this.state.items} itemAdded={this.props.onItemAdded}></DrinkControls>;
        }

        if(this.state.loading) {
            items = <div style={{
                position: 'fixed',
                top: '20%',
                left: '34%'
            }}><Spinner></Spinner></div>;
        }

        return (
            <div className={classes.OrderBuilder}>
            {items}
            <Cart orderContinued={this.orderContinueHandler} isAuth={this.props.isAuthenticated}></Cart>
            </div>
        );
    }
};

const mapStateToProps = state => {
    return {
        started: state.orderBuilder.started,
        price: state.orderBuilder.totalPrice,
        isAuthenticated: state.auth.token !== null,
    };
};

const mapDispatchToProps = dispatch => {
    return {
        onItemAdded: (itemId, price, itemName, packSize) => dispatch(actions.addItem(itemId, price, itemName, packSize)),
        onInitItems: () => dispatch(actions.initItems()),
        onSetAuthRedirectPath: (path) => dispatch(actions.setAuthRedirectPath(path))
    };
};

export default connect(mapStateToProps, mapDispatchToProps)(OrderBuilder);