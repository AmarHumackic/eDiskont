import React, { Component } from 'react';
import { connect } from 'react-redux';
import { Redirect } from 'react-router-dom';

import Input from '../../components/UI/Input/Input';
import Button from '../../components/UI/Button/Button';
import classes from './Auth.css';
import * as actions from '../../store/actions/index';
import { updateObject, checkValidity } from '../../shared/utility';
import Spinner from '../../components/UI/Spinner/Spinner';

class Auth extends Component {
    state = {
        controls: {
            email: {
                elementType: 'input',
                elementConfig: {
                    type: 'email',
                    placeholder: 'E-mail adresa'
                },
                value: '',
                validation: {
                    required: true,
                    isEmail: true
                },
                valid: false,
                touched: false
            },
            password: {
                elementType: 'input',
                elementConfig: {
                    type: 'password',
                    placeholder: 'Lozinka'
                },
                value: '',
                validation: {
                    required: true,
                    minLength: 6
                },
                valid: false,
                touched: false
            },
        },
        isSignup: false
    }

    inputChangedHandler = (event, controlName) => {
        const updatedControls = updateObject(this.state.controls, {
            [controlName]: updateObject(this.state.controls[controlName], {
                value: event.target.value,
                valid: checkValidity(event.target.value, this.state.controls[controlName].validation),
                touched: true
            }),
        });
        this.setState({ controls: updatedControls });
    };

    submitHandler = (event) => {
        event.preventDefault();

        if(this.state.controls['email'].value !== '' && this.state.controls['password'].touched !== '') {
            this.props.onAuth(this.state.controls.email.value, this.state.controls.password.value, this.state.isSignup);
            if(!this.props.error && this.state.isSignup) {
                this.switchAuthModeHandler();
            } 
        } else {
            let prevState = {...this.state};
            prevState.controls['email'].touched = true;
            prevState.controls['password'].touched = true;
            this.setState({ state: prevState });
        }
            
    }

    resetControls = () => {
        let prevState = {...this.state};
        prevState.controls['email'].touched = false;
        prevState.controls['email'].valid = false;
        prevState.controls['email'].value = '';
        prevState.controls['password'].touched = false;
        prevState.controls['password'].valid = false;
        prevState.controls['password'].value = '';
        this.setState({ state: prevState });
    }

    switchAuthModeHandler = () => {
        this.setState(prevState => {
            return { isSignup: !prevState.isSignup };
        });
        this.resetControls();
    };

    errorNameHandler = (name) => {
        var splitted = name.split('_');
        return splitted.join(' ');
    };

    render() {
        const formElementsArray = [];
        for(let key in this.state.controls) {
            formElementsArray.push({
                id: key,
                config: this.state.controls[key]
            });
        }
        let form = formElementsArray.map(formElement => (
            <Input key={formElement.id}
                    elementType={formElement.config.elementType} 
                    elementConfig={formElement.config.elementConfig}
                    value={formElement.config.value}
                    invalid={!formElement.config.valid}
                    shouldValidate={formElement.config.validation}
                    touched={formElement.config.touched}
                    changed={(event) => this.inputChangedHandler(event, formElement.id)}></Input>
        ));

        if(this.props.loading) {
            form = <Spinner></Spinner>;
        }

        let errorMessage = null;
        if(this.props.error) {
            errorMessage = (
                <span>{this.errorNameHandler(this.props.error.message)}</span>
            );
        }

        let authRedirect = null;
        if(this.props.isAuthenticated) {
            authRedirect = <Redirect to={this.props.authRedirectPath}></Redirect>
        }

        return (
            <div className={classes.Auth}>
                {this.state.isSignup ? <p>Registracija na eDiskont</p> : <p>Prijava na eDiskont</p>}
                {authRedirect}
                {errorMessage}
                <form onSubmit={this.submitHandler}>
                    {form}
                    <Button btnType="Success">
                    {this.state.isSignup ? 'Registruj se' : 'Prijavi se'}
                    </Button>
                </form>
                <Button style={{float: 'right'}} clicked={this.switchAuthModeHandler} btnType="AppColor">
                    {this.state.isSignup ? 'IDI NA PRIJAVU' : 'IDI NA REGISTRACIJU'}
                </Button>
            </div>
        );
    }

}

const mapStateToProps = (state) => {
    return {
        loading: state.auth.loading,
        error: state.auth.error,
        isAuthenticated: state.auth.token !== null,
        authRedirectPath: state.auth.authRedirectPath
    };
};

const mapDispatchToProps = dispatch => {
    return {
        onAuth: (email, password, isSignup) => dispatch(actions.auth(email, password, isSignup)),
        onSetAuthRedirectPath: () => dispatch(actions.setAuthRedirectPath('/'))
    };
};

export default connect(mapStateToProps, mapDispatchToProps)(Auth);