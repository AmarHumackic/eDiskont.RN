import * as actionTypes from './actionTypes';
import axios from '../../../axios-config';
import * as actions from '../actions/index';
const qs = require('qs');

export const purchaseOrderSuccess = (orderData) => {
    return {
        type: actionTypes.PURCHASE_ORDER_SUCCESS
    };
};

export const purchaseOrderFail = (error) => {
    return {
        type: actionTypes.PURCHASE_ORDER_FAIL,
        error: error
    };
};

export const purchaseOrderStart = () => {
    return {
        type: actionTypes.PURCHASE_ORDER_START,
    };
};

export const purchaseOrder = (orderData, token) => {
    return dispatch => {
        dispatch(purchaseOrderStart());
        axios.post('/Orders/PostOrders/', qs.stringify({
            'date': orderData.date,
            'orderData': orderData.orderData,
            'orderItems': orderData.orderItems,
            'price': orderData.price,
            'userId': orderData.userId
        })).then(response => {
            dispatch(purchaseOrderSuccess());
            dispatch(actions.initItems());
            dispatch(fetchOrders('token', orderData.userId));
        }).catch(error => {
            dispatch(purchaseOrderFail(error));
            alert(error.message);
        });
    };
};

export const fetchOrderSuccess = (orders) => {
    return {
        type: actionTypes.FETCH_ORDER_SUCCESS,
        orders: orders
    }
};

export const fetchOrderFail = (error) => {
    return {
        type: actionTypes.FETCH_ORDER_FAIL,
        error: error
    };
};

export const fetchOrderStart = () => {
    return {
        type: actionTypes.FETCH_ORDER_START
    };
};

export const fetchOrders = (token, userId) => {
    return dispatch => {
        dispatch(fetchOrderStart());
        axios.get('/Orders/GetByUser?userId=' + userId).then(response => {
            dispatch(fetchOrderSuccess(response.data));
        }).catch(error => {
            dispatch(fetchOrderFail(error));
        });
    };
};