import * as actionTypes from '../actions/actionTypes';
import { updateObject } from '../../shared/utility';

const initialState = {
    orders: [],
    loading: false,
    purchased: false
};

const purchaseInit = (state, action) => {
    return updateObject(state, { purchased: false });
};

const purchaseOrderStart = (state, action) => {
    return updateObject(state, { loading: true });
};

const purchaseOrderSuccess = (state, action) => {
    return updateObject(state, {
        loading: false,
        purchased: true,
    });
};

const purchaseOrderFail = (state, action) => {
    return updateObject(state, { loading: false });
};

const fetchOrderStart = (state, action) => {
    return updateObject(state, { loading: true });  
};

const fetchOrderFail = (state, action) => {
    return updateObject(state, { loading: false });
};

const fetchOrderSuccess = (state, action) => {
    return updateObject(state, { 
        orders: action.orders,
        loading: false
    });
}; 

const initOrders = (state, action) => {
    return updateObject(state, {
        orders: [],
        loading: false,
        purchased: false
    });
};

const reducer = (state = initialState, action) => {
    switch(action.type) {
        case(actionTypes.PURCHASE_INIT): return purchaseInit(state, action);
        case(actionTypes.PURCHASE_ORDER_START): return purchaseOrderStart(state, action);
        case(actionTypes.PURCHASE_ORDER_SUCCESS): return purchaseOrderSuccess(state, action);
        case(actionTypes.PURCHASE_ORDER_FAIL): return purchaseOrderFail(state, action);
        case(actionTypes.FETCH_ORDER_START): return fetchOrderStart(state, action);
        case(actionTypes.FETCH_ORDER_SUCCESS): return fetchOrderSuccess(state, action);
        case(actionTypes.FETCH_ORDER_FAIL): return fetchOrderFail(state, action);
        case(actionTypes.INIT_ORDERS): return initOrders(state, action);
        default: return state;
    }
};

export default reducer;