import * as actionTypes from './actionTypes';

export const addItem = (itemId, price, itemName, packSize) => {
    return {
        type: actionTypes.ADD_ITEM,
        itemId: itemId,
        price: price,
        itemName: itemName,
        packSize: packSize
    };
};

export const removeItem = (itemId) => {
    return {
        type: actionTypes.REMOVE_ITEM,
        itemId: itemId
    };
};

export const initItems = () => {
    return {
        type: actionTypes.INIT_ITEMS,
    };
};

export const fetchItemsFailed = () => {
    return {
        type: actionTypes.FETCH_ITEMS_FAILED
    };
};

export const changeItemSize = (itemId, size) => {
    return {
        type: actionTypes.CHANGE_ITEM_SIZE,
        itemId: itemId,
        size: size
    };
};