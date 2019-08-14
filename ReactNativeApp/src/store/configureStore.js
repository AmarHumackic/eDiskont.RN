import { createStore, combineReducers, compose, applyMiddleware } from "redux";
import thunk from "redux-thunk";

import orderBuilderReducer from "./reducers/orderBuilder";
import orderReducer from "./reducers/order";
import authReducer from "./reducers/auth";

const rootReducer = combineReducers({
  orderBuilder: orderBuilderReducer,
  order: orderReducer,
  auth: authReducer
});

let composeEnhancers = compose;

if (__DEV__) {
  composeEnhancers = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose;
}

const configureStore = () => {
  return createStore(rootReducer, composeEnhancers(applyMiddleware(thunk)));
};

export default configureStore;
