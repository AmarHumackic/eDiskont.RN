import * as actionTypes from '../actions/actionTypes';
import { updateObject } from '../../utility/validation';
import NavigationService from '../../screens/Navigation/NavigationService';

const initialState = {
    token: null,
    userId: null,
    email: null,
    error: null,
    loading: false,
    authRedirectPath: '/'
};
    
const authStart = (state, action) => {
    return updateObject(state, { 
        error: null,
        loading: true
    });
};

const authSuccess = (state, action) => {
    if(state.authRedirectPath === 'contactData') {
        NavigationService.back();
        NavigationService.navigate('Cart');
    } else {
        NavigationService.navigate('OrderBuilderStackNavigator');
    }

    return updateObject(state, {
        token: action.idToken,
        userId: action.userId,
        email: action.email,
        error: null,
        loading: false
    });
};

const registerSuccess = (state, action) => {
    return updateObject(state, { error: null, loading: false });
}

const authFail = (state, action) => {
    return updateObject(state, { 
        error: action.error,
        loading: false
    });
};

const setErrorFalse = (state, action) => {
    return updateObject(state, { error: false });
};

const authLogout = (state, action) => {
    NavigationService.navigate('OrderBuilderStackNavigator');
    return updateObject(state, {
        token: null,
        userId: null,
        email: null
    });
};

const setAuthRedirectPath = (state, action) => {
    return updateObject(state, { authRedirectPath: action.path });
};

const authSetToken = (state, action) => {
    return updateObject(state, {
        token: action.token,
        userId: action.userId,
        email: action.email
    });
};

const authRemoveToken = (state, action) => {
    return updateObject(state, {
        token: null,
        userId: null,
        email: null
    });
};

const reducer = (state = initialState, action) => {
    switch(action.type) {
        case(actionTypes.AUTH_START): return authStart(state, action);
        case(actionTypes.AUTH_SUCCESS): return authSuccess(state, action);
        case(actionTypes.AUTH_FAIL): return authFail(state, action);
        case(actionTypes.AUTH_LOGOUT): return authLogout(state, action);
        case(actionTypes.SET_AUTH_REDIRECT_PATH): return setAuthRedirectPath(state, action);
        case(actionTypes.SET_ERROR_FALSE): return setErrorFalse(state, action);
        case(actionTypes.REGISTER_SUCCESS): return registerSuccess(state, action);
        case(actionTypes.AUTH_SET_TOKEN): return authSetToken(state, action);
        case(actionTypes.AUTH_REMOVE_TOKEN): return authRemoveToken(state, action);
        default: return state;
    }
};

export default reducer;