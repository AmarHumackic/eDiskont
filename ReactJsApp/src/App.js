import React, { Component } from 'react';
import { Route, Switch, withRouter, Redirect } from 'react-router-dom';
import { connect } from 'react-redux';

import './App.css';
import Layout from './hoc/Layout/Layout';
import OrderBuilder from './containers/OrderBuilder/OrderBuilder';
import ContactData from './containers/ContactData/ContactData';
import Orders from './containers/Orders/Orders';
import Auth from './containers/Auth/Auth';
import Logout from './containers/Auth/Logout/Logout';
import OrderDetails from './containers/OrderDetails/OrderDetails';
import * as actions from './store/actions/index';

class App extends Component {
  componentDidMount() {
    this.props.onTryAutoSignup();
  }

  render() {
    let routes = (
      <Switch>
        <Route path="/auth" component={Auth}></Route>
        <Route path="/items/:id" component={OrderBuilder}></Route>
        <Redirect to="/items/1" ></Redirect>
      </Switch>
    );

    if(this.props.isAuthenticated) {
      routes = (
        <Switch>
            <Route path="/logout" component={Logout}></Route>
            <Route path="/auth" component={Auth}></Route>
            <Route path="/orders" component={Orders}></Route>
            <Route path='/order-details' component={OrderDetails} />
            <Route path="/items/:id" component={OrderBuilder}></Route>
            <Route path="/contact-data" component={ContactData}></Route>
            <Redirect to="/items/1" ></Redirect>
          </Switch>
      ); 
    }
    return (
      <div className="App">
        <Layout>
          {routes}
        </Layout>
      </div>
    );
  }
}

const mapStateToProps = state => {
  return {
    isAuthenticated: state.auth.token !== null
  };
};

const mapDispatchToProps = dispatch => {
  return {
    onTryAutoSignup: () => dispatch(actions.authCheckState())
  };
};

export default withRouter(connect(mapStateToProps, mapDispatchToProps)(App));