import AsyncStorage from '@react-native-community/async-storage';
import axios from '../../../axios-config';
import * as actionTypes from './actionTypes';
import Snackbar from 'react-native-snackbar';
const qs = require('qs');

export const authStart = () => {
    return {
        type: actionTypes.AUTH_START
    };
};

export const authSuccess = (token, userId, email) => {
    return {
        type: actionTypes.AUTH_SUCCESS,
        idToken: token,
        userId: userId,
        email: email
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

export const auth = (email, password, isSignup) => {
    return dispatch => {
        if (!isSignup) {
            dispatch(authStart());
            const queryParams = '?email=' + email + '&password=' + password;
            axios.get('/Users/LoginCheck' + queryParams).then(response => {
                dispatch(authStoreData(response.data.Token, response.data.UserID, response.data.Email));
                dispatch(authSuccess(response.data.Token, response.data.UserID, response.data.Email));
            }).catch(error => {
                alert("Nema interneta.");
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
                Snackbar.show({
                    title: 'Registracija je uspješna.',
                    duration: Snackbar.LENGTH_SHORT,
                    color: 'white'
                });
            }).catch(error => {
                alert("Nema interneta.");
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

export const authStoreData = (token, userId, email) => {
    return dispatch => {
        dispatch(authSetData(token, userId, email));
        AsyncStorage.setItem("auth:token", token);
        AsyncStorage.setItem("auth:userId", userId.toString());
        AsyncStorage.setItem("auth:email", email);
    };
};

export const authSetData = (token, userId, email) => {
    return {
        type: actionTypes.AUTH_SET_TOKEN,
        token: token,
        userId: userId,
        email: email
    };
};

export const authGetData = () => {
    return (dispatch, getState) => {
        const promise = new Promise((resolve, reject) => {
            const token = getState().auth.token;
            const userId = getState().auth.userId;
            const email = getState().auth.email;
            if (!token || !userId || !email) {
                let fetchedToken = null;
                let fetchedUserID = null;
                let fetchedEmail = null

                AsyncStorage.getItem("auth:token")
                    .catch(err => reject())
                    .then(tokenFromStorage => {
                        fetchedToken = tokenFromStorage;
                        if (fetchedToken) {
                            AsyncStorage.getItem("auth:userId")
                                .catch(err => reject())
                                .then(userIdFromStorage => {
                                    fetchedUserID = userIdFromStorage;
                                    if (fetchedUserID) {

                                        AsyncStorage.getItem("auth:email")
                                            .catch(err => reject())
                                            .then(emailFromStorage => {
                                                fetchedEmail = emailFromStorage;
                                                if (fetchedEmail) {
                                                    dispatch(authSetData(fetchedToken, fetchedUserID, fetchedEmail));
                                                    resolve(fetchedToken, fetchedUserID, fetchedEmail);
                                                    return;
                                                }
                                            });
                                    }
                                });
                        }
                    });
            } else {
                resolve(token, userId, email);
            }
        });
        return promise;
    };
};

export const authAutoSignIn = () => {
    return dispatch => {
        dispatch(authGetData());
    };
};

export const authClearStorage = () => {
    return dispatch => {
        AsyncStorage.removeItem("auth:token");
        AsyncStorage.removeItem("auth:userId");
        AsyncStorage.removeItem("auth:email");
    };
};

export const authLogout = () => {
    return dispatch => {
        dispatch(authClearStorage());
        dispatch(authRemoveToken());
    };
};

export const authRemoveToken = () => {
    return {
        type: actionTypes.AUTH_REMOVE_TOKEN
    };
};
