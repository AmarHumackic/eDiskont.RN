import * as actionTypes from '../actions/actionTypes';
import { updateObject, capitalizeFirstLetter } from '../../utility/validation';
import Snackbar from 'react-native-snackbar';

const initialState = {
    orderItems: [],
    totalPrice: 0,
    error: false,
    building: false,
    started: false
};

const addItem = (state, action) => {
    let exists = false, itemKey=-1;
    for(let key in Object.keys(state.orderItems)) {
        if(state.orderItems[key].itemId === action.itemId) {
            exists = true;
            itemKey = key;
        }
    }
    if(exists) {
        let prevState = {...state};
        const newSize = state.orderItems[itemKey].value + action.packSize;
        prevState.orderItems[itemKey]["value"] = newSize;
        prevState.totalPrice = state.totalPrice + (action.price * action.packSize);

        Snackbar.show({
            title: 'Narudžba: ' + capitalizeFirstLetter(action.itemName) + ' x ' + newSize + '.',
            duration: Snackbar.LENGTH_SHORT,
            color: 'white'
        });
        return prevState;
    } else {
        const newItem = { "itemId": action.itemId, "value": action.packSize, "itemName": action.itemName, "price": action.price };
        const updatedState = {
            orderItems: state.orderItems.concat(newItem),
            totalPrice: state.totalPrice + (action.price * action.packSize),
            building: true
    }
    Snackbar.show({
        title: 'Narudžba: ' + capitalizeFirstLetter(action.itemName) + ' x ' + action.packSize + '.',
        duration: Snackbar.LENGTH_SHORT,
        color: 'white'
    });
    return updateObject(state, updatedState);
    }
};

const removeItem = (state, action) => {
    let itemDeleted = null;
    for(let key in Object.keys(state.orderItems)) {
        if(state.orderItems[key].itemId === action.itemId) {
            itemDeleted = state.orderItems[key];
        }
    }
    const itemPrice = itemDeleted.price;
    const lastSize = itemDeleted.value;
    const updatedState = {
        orderItems: state.orderItems.filter(item => item !== itemDeleted),
        totalPrice: state.totalPrice - (itemPrice * lastSize),
        building: true
    }
    return updateObject(state, updatedState);
};

const initItems = (state, action) => {
    return updateObject(state, {
        orderItems: [],
        totalPrice: 0,
        error: false,
        building: false,
        started: true
    });
};

const fetchItemsFailed = (state, action) => {
    return updateObject(state, { error: true });
};

const changeItemSize = (state, action) => {
    let itemKey=-1;
    for(let key in Object.keys(state.orderItems)) {
        if(state.orderItems[key].itemId === action.itemId) {
            itemKey = key;
        }
    }
    const lastSize = state.orderItems[itemKey].value;
    let prevState = {...state};
    prevState.orderItems[itemKey]["value"] = action.size;
    prevState.totalPrice = state.totalPrice + (state.orderItems[itemKey].price * action.size) - (state.orderItems[itemKey].price * lastSize);

    return prevState;
};

const reducer = (state = initialState, action) => {
    switch(action.type) {
        case(actionTypes.ADD_ITEM): return addItem(state, action);
        case(actionTypes.REMOVE_ITEM): return removeItem(state, action);
        case(actionTypes.INIT_ITEMS): return initItems(state, action);
        case(actionTypes.FETCH_ITEMS_FAILED): return fetchItemsFailed(state, action);
        case(actionTypes.CHANGE_ITEM_SIZE): return changeItemSize(state, action);
        default: return state;
    }
};

export default reducer;