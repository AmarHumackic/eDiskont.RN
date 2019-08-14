import React, { Component } from 'react';
import { ActivityIndicator } from 'react-native';
import { connect } from 'react-redux';

import * as actions from '../../../store/actions/index';

class Logout extends Component {
    constructor(props) {
        super(props);
        this.props.onAuthLogout();
        this.props.navigation.navigate("OrderBuilderStackNavigator");
    }
    render() {
        return <ActivityIndicator></ActivityIndicator>;
    }
}

const mapDispatchToProps = dispatch => {
    return {
        onAuthLogout: () => dispatch(actions.authLogout())
    };
};

export default connect(null, mapDispatchToProps)(Logout);

