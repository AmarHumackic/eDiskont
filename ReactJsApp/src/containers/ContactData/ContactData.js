import React, { Component } from 'react';
import { connect } from 'react-redux';

import Button from '../../components/UI/Button/Button';
import classes from './ContactData.css';
import Input from '../../components/UI/Input/Input';
import * as actions from '../../store/actions/index';
import { updateObject, checkValidity } from '../../shared/utility';

class ContactData extends Component {
    state = {
        orderForm: {
            name: {
                elementType: 'input',
                elementConfig: {
                    type: 'text',
                    placeholder: 'Ime i prezime'
                },
                value: '',
                validation: {
                    required: true
                },
                valid: false,
                touched: false
            },
            company: {
                elementType: 'input',
                elementConfig: {
                    type: 'text',
                    placeholder: 'Firma'
                },
                value: '',
                validation: {
                    required: true
                },
                valid: false,
                touched: false
            },
            address: {
                elementType: 'input',
                elementConfig: {
                    type: 'text',
                    placeholder: 'Adresa'
                },
                value: '',
                validation: {
                    required: true
                },
                valid: false,
                touched: false
            },
            city: {
                elementType: 'input',
                elementConfig: {
                    type: 'text',
                    placeholder: 'Grad'
                },
                value: '',
                validation: {
                    required: true
                },
                valid: false,
                touched: false
            },
            deliveryMethod: {
                elementType: 'select',
                elementConfig: {
                    options: [
                        {value: '1', displayValue: 'Brzo'},
                        {value: '2', displayValue: 'Jeftino'}
                    ]
                },
                value: '1',
                validation: {},
                valid: true
            },
        },
        formIsValid: false
    }

    orderHandler = (event) => {
        event.preventDefault();
        
        const formData = {};
        for(let formElement in this.state.orderForm) {
            formData[formElement] = this.state.orderForm[formElement].value;
        }
        var today = {
            day: new Date().getDate(),
            month: new Date().getMonth(),
            year: new Date().getFullYear(),
            hour: new Date().getHours(),
            minute: new Date().getMinutes()
        }
        const order = {
            orderItems: this.props.orderItems,
            price: this.props.totalPrice,
            orderData: formData,
            date: today.month + '.' + today.day + '.'  + today.year + ' ' + today.hour + ':' + today.minute,
            userId: this.props.userId
        }
        this.props.onOrderConfirm(order, this.props.token);
        this.props.history.replace('/orders');
    };

    inputChangedHandler = (event, inputIdentifier) => {
        const updatedFormElement = updateObject(this.state.orderForm[inputIdentifier], {
            value: event.target.value,
            valid: checkValidity(event.target.value, this.state.orderForm[inputIdentifier].validation),
            touched: true
        });
        const updatedOrderForm = updateObject(this.state.orderForm, {
            [inputIdentifier]: updatedFormElement
        });

        let formIsValid = true;
        for(let inputIdentifiers in updatedOrderForm) {
            formIsValid = updatedOrderForm[inputIdentifiers].valid && formIsValid;
        }
        
        this.setState({orderForm: updatedOrderForm, formIsValid: formIsValid});
    };

    render() {
        const formElementsArray = [];
        for(let key in this.state.orderForm) {
            formElementsArray.push({
                id: key,
                config: this.state.orderForm[key]
            });
        }

        let form = (
            <form onSubmit={this.orderHandler}>
                {formElementsArray.map(formElement => (
                    <Input key={formElement.id}
                        elementType={formElement.config.elementType} 
                        elementConfig={formElement.config.elementConfig}
                        value={formElement.config.value}
                        invalid={!formElement.config.valid}
                        shouldValidate={formElement.config.validation}
                        touched={formElement.config.touched}
                        changed={(event) => this.inputChangedHandler(event, formElement.id)}></Input>
                ))}
                <Button btnType="Success" disabled={!this.state.formIsValid}>Procesiraj narudžbu</Button>
            </form>
        );
        return (
            <div className={classes.ContactData}>
                <h4>Unesite Vaše podatke</h4>
                {form}
            </div>
        );
    }
};

const mapStateToProps = state => {
    return {
        orderItems: state.orderBuilder.orderItems,
        totalPrice: state.orderBuilder.totalPrice,
        token: state.auth.token,
        userId: state.auth.userId,
    };
};

const mapDispatchToProps = dispatch => {
    return {
        onOrderConfirm: (orderData, token) => dispatch(actions.purchaseOrder(orderData, token)),
    };
};

export default connect(mapStateToProps, mapDispatchToProps)(ContactData);