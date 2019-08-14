import React, { Component } from 'react';
import { View, Text, ScrollView, StyleSheet, ActivityIndicator, Dimensions, YellowBox, Image } from 'react-native';
import { connect } from 'react-redux';
import NetInfo from "@react-native-community/netinfo";

import axios from '../../../axios-config';
import DrinkControls from '../../components/DrinkControls/DrinkControls';
import * as actions from '../../store/actions/index';
import InternetErrorPhoto from '../../assets/interneterror.jpg';

class OrderBuilderScreen extends Component {
    constructor(props) {
        super(props);

        YellowBox.ignoreWarnings([
            'Warning: componentWillUpdate is deprecated'
        ]);
    }

    state = {
        items: null,
        loading: false,
        isConnected: true
    }

    async componentDidMount() {
        if (!this.props.started) {
            this.props.onInitItems();
        }
        this.props.onAutoSignIn();

        NetInfo.isConnected.addEventListener('connectionChange', this.handleConnectivityChange);
    }

    componentWillUnmount() {
        NetInfo.isConnected.removeEventListener('connectionChange', this.handleConnectivityChange);
    }

    handleConnectivityChange = isConnected => {
        this.setState({ isConnected: isConnected });
        if (isConnected) {
            this.getItems();
        }
    }

    getItems = async () => {
        this.setState({ items: null, loading: true });
        const typeId = this.props.navigation.getParam("typeId");
        await axios(`/Items/GetByType?typeId=${typeId}`).then(response => {
            this.setState({ items: response.data, loading: false });
        }).catch(err => {
            this.setState({ loading: false });
        });
    };

    render() {
        let items = null;

        if (!this.state.isConnected) {
            items = (
                <View style={styles.networkError}>
                    <Text style={styles.errorText}>Nema interneta.</Text>
                    <Image source={InternetErrorPhoto} style={{ width: 200, height: 200 }}></Image>
                </View>
            );
        }
        else if (!this.state.items || this.state.loading) {
            items = (
                <View style={styles.loading}>
                    <ActivityIndicator size="large"></ActivityIndicator>
                </View>
            );
        }
        else {
            items = <DrinkControls items={this.state.items} itemAdded={this.props.onItemAdded}></DrinkControls>;
        }

        return (
            <ScrollView>
                <View style={styles.container}>
                    {items}
                </View>
            </ScrollView>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1
    },
    loading: {
        flex: 1,
        alignItems: 'center',
        justifyContent: 'center',
        marginTop: Dimensions.get("window").height / 2 - 40
    },
    networkError: {
        alignItems: 'center',
        justifyContent: 'center',
        marginTop: '50%'
    },
    errorText: {
        fontWeight: 'bold',
        fontSize: 22,
        paddingBottom: 20
    }
});

const mapStateToProps = state => {
    return {
        started: state.orderBuilder.started,
        userId: state.auth.userId
    };
};

const mapDispatchToProps = dispatch => {
    return {
        onItemAdded: (itemId, price, itemName, packSize) => dispatch(actions.addItem(itemId, price, itemName, packSize)),
        onInitItems: () => dispatch(actions.initItems()),
        onAutoSignIn: () => dispatch(actions.authAutoSignIn())
    };
};

export default connect(mapStateToProps, mapDispatchToProps)(OrderBuilderScreen);
