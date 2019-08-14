import React, { Component } from 'react';
import { View, Text, ActivityIndicator, StyleSheet, ScrollView, Dimensions, Image } from 'react-native';
import { connect } from 'react-redux';
import NetInfo from "@react-native-community/netinfo";

import Order from '../../components/Order/Order';
import * as actions from '../../store/actions/index';
import Snackbar from 'react-native-snackbar';
import InternetErrorPhoto from '../../assets/interneterror.jpg';

class OrdersScreen extends Component {
    state = {
        userId: null,
        isConnected: true
    }

    checkFetchingOrders = () => {
        if (this.props.userId) {
            if (this.state.userId !== this.props.userId) {
                this.props.onFetchOrder(this.props.token, this.props.userId);
                this.setState({ userId: this.props.userId });
            }
        } else {
            this.navigateToAuth();
        }

    }

    componentDidMount() {
        this.subs = [
            this.props.navigation.addListener('didFocus', this.checkFetchingOrders),
        ];

        NetInfo.isConnected.addEventListener('connectionChange', this.handleConnectivityChange);
    }

    componentWillUnmount() {
        this.subs.forEach(sub => sub.remove());
        NetInfo.isConnected.removeEventListener('connectionChange', this.handleConnectivityChange);
    }

    handleConnectivityChange = isConnected => {
        this.setState({ isConnected: isConnected });
        if (isConnected) {
            this.checkFetchingOrders();
        }
    }

    navigateToAuth = () => {
        if (!this.props.userId) {
            this.props.navigation.navigate("AuthStackNavigator");

            Snackbar.show({
                title: 'Prijavite se za prikaz narudžbi.',
                duration: Snackbar.LENGTH_SHORT,
                color: 'white'
            });
        }
    }

    orderDetailsHandler = (i) => {
        this.props.navigation.navigate('OrderDetails', { order: this.props.orders[i] });
    };

    render() {
        let outputOrders = null;
        let paragraph = null;

        if (!this.state.isConnected) {
            outputOrders = (
                <View style={styles.networkError}>
                    <Text style={styles.errorText}>Nema interneta.</Text>
                    <Image source={InternetErrorPhoto} style={{ width: 200, height: 200 }}></Image>
                </View>
            );
        }
        else {
            if (this.props.orders) {
                outputOrders = this.props.orders.map((order, i) => {
                    return <Order key={order.OrderID} name={order.OrderData.FullName} date={order.Date} totalPrice={order.TotalPrice}
                        orderDetails={() => this.orderDetailsHandler(i)}></Order>;
                });
            }

            if (this.props.loading) {
                outputOrders = (
                    <View style={styles.loading}>
                        <ActivityIndicator size="large"></ActivityIndicator>
                    </View>
                );
            }

            if (this.props.orders.length > 0) {
                paragraph = <Text>Za prikaz detalja kliknite na narudžbu.</Text>;
            }
        }



        return (
            <ScrollView>
                <View style={styles.container}>
                    {paragraph}
                    {outputOrders}
                </View>
            </ScrollView>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        alignItems: 'center',
        justifyContent: 'space-between'
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
        orders: state.order.orders,
        loading: state.order.loading,
        token: state.auth.token,
        userId: state.auth.userId,
        started: state.orderBuilder.started
    };
};

const mapDispatchToProps = dispatch => {
    return {
        onFetchOrder: (token, userId) => dispatch(actions.fetchOrders(token, userId))
    };
};

export default connect(mapStateToProps, mapDispatchToProps)(OrdersScreen);