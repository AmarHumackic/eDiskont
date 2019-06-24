import React, { Component } from 'react';
import { Redirect } from 'react-router-dom';
import { connect } from 'react-redux';

import * as actions from '../../../store/actions/index';

class Logout extends Component {
    componentDidMount() {
        this.props.onLogout();
        this.props.onInitOrders();
    }

    render() {
        return (
            <Redirect to="/"></Redirect>
        );
    }   
};

const mapDispatchToProps = dispatch => {
    return {
        onLogout: () => dispatch(actions.logout()),
        onInitOrders: () => dispatch(actions.initOrders())
    };
};

export default connect(null, mapDispatchToProps)(Logout);