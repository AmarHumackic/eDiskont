import axios from '../../axios-config';
import * as actionTypes from './actionTypes';
import * as actions from '../actions/index';
const qs = require('qs');

export const authStart = () => {
    return {
        type: actionTypes.AUTH_START
    };
};

export const authSuccess = (token, userId) => {
    return {
        type: actionTypes.AUTH_SUCCESS,
        idToken: token,
        userId: userId
    };
};

export const registerSuccess = () => {
    return {
        type: actionTypes.REGISTER_SUCCESS
    };
};

export const authFail = (error) => {
    return {
        type: actionTypes.AUTH_FAIL,
        error: error
    };
};

export const setErrorFalse = () => {
    return {
        type: actionTypes.SET_ERROR_FALSE
    };
};

export const logout = () => {
    localStorage.removeItem('token');
    localStorage.removeItem('expirationDate');
    localStorage.removeItem('userId');
    return {
        type: actionTypes.AUTH_LOGOUT
    };  
};

export const checkAuthTimeout = (expirationTime) => {
    return dispatch => {
        setTimeout(() => {
            dispatch(logout());
            dispatch(actions.initOrders());
        }, expirationTime * 1000);
    };
};

export const auth = (email, password, isSignup) => {
    return dispatch => {
        if(!isSignup) {
            dispatch(authStart());
            const queryParams = '?email=' + email + '&password=' + password;
            axios.get('/Users/LoginCheck' + queryParams).then(response => {
                const expirationDate = new Date(new Date().getTime() + response.data.ExpiresIn * 1000);
                localStorage.setItem('token', response.data.Token);
                localStorage.setItem('expirationDate', expirationDate);
                localStorage.setItem('userId', response.data.UserID);
                dispatch(authSuccess(response.data.Token, response.data.UserID));
                dispatch(checkAuthTimeout(response.data.ExpiresIn));
            }).catch(error => {
                dispatch(authFail(error));
                setTimeout(() => {
                    dispatch(setErrorFalse());
                }, 2000);
            });
        } else {
            dispatch(authStart());
            axios.post('/Users/PostUsers', qs.stringify({
                'email': email,
                'password': password
            })).then(response => {
                dispatch(registerSuccess());
            }).catch(error => {
                dispatch(authFail(error));
                setTimeout(() => {
                    dispatch(setErrorFalse());
                }, 2000);
            });
        }  
    };
};

export const setAuthRedirectPath = (path) => {
    return {
        type: actionTypes.SET_AUTH_REDIRECT_PATH,
        path: path
    };
};

export const authCheckState = () => {
    return dispatch => {
        const token = localStorage.getItem('token');
        if(!token) {
            dispatch(logout());
            dispatch(actions.initOrders());
        } else {
            const expirationDate = new Date(localStorage.getItem('expirationDate'));
            if(expirationDate <= new Date()) {
                dispatch(logout());
                dispatch(actions.initOrders());
            } else {
                const userId = localStorage.getItem('userId');
                dispatch(authSuccess(token, userId));
                dispatch(checkAuthTimeout((expirationDate.getTime() - new Date().getTime()) / 1000));
            }
            dispatch(authSuccess);
        }
    };
};