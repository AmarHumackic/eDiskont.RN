import React, { Component } from 'react';
import { View, Text, TouchableOpacity, Platform, StyleSheet, ScrollView, TextInput } from 'react-native';
import { connect } from 'react-redux';

import * as actions from '../../store/actions/index';
import Icon from "react-native-vector-icons/Ionicons";
import ButtonWithBackground from '../../components/UI/ButtonWithBackground/ButtonWithBackground';

class CartScreen extends Component {
    checkValidity(size) {
        const sizeInt = size ? parseInt(size, 10) : 0;
        if (/^[1-9]\d*$/.test(sizeInt)) {
            return true;
        } else {
            return false;
        }
    }

    inputChangedHandler = (size, itemId) => {
        if (this.checkValidity(size)) {
            this.props.onInputSizeChanged(itemId, parseInt(size, 10));
        } else {
            this.props.onInputSizeChanged(itemId, null);
        }
    }

    removeItemHadler = (itemId) => {
        this.props.onItemRemoved(itemId);
    }

    limitItemTitle = (title, limit = 17) => {
        const newTitle = [];
        if (title.length > limit) {
            title.split(' ').reduce((acc, cur) => {
                if (acc + cur.length <= limit) {
                    newTitle.push(cur);
                }
                return acc + cur.length;
            }, 0);

            return `${newTitle.join(' ')}...`;
        }
        return title;
    }

    orderContinueHandler = () => {
        if (this.props.userId) {
            this.props.navigation.navigate("ContactData");
        } else {
            this.props.onSetAuthRedirectPath('contactData');
            this.props.navigation.navigate("AuthStackNavigator")
        }
    }

    render() {
        let itemsList = null;
        let totalPrice = <Text style={styles.emptyCart}>Dodajte proizvode za narudžbu.</Text>;
        let paddingBottomView = null;
        let submitButton = null;

        if (this.props.orderItems.length > 0) {
            itemsList = this.props.orderItems.map(item => {
                item.valid = this.checkValidity(item.value);
                return (
                    <View key={item.itemId} style={styles.itemContainer}>
                        <Text style={styles.textName}>{this.limitItemTitle(item.itemName)}</Text>
                        <TextInput style={!item.valid ? styles.invalidTextInput : styles.textInputValue}
                            keyboardType={'numeric'}
                            onChangeText={(size) => this.inputChangedHandler(size, item.itemId)}
                            value={item.value ? item.value.toString() : null} />
                        <TouchableOpacity style={styles.trashIcon} onPress={() => this.removeItemHadler(item.itemId)}>
                            <View>
                                <Icon size={30} color="red"
                                    name={Platform.OS === "android" ? "md-trash" : "ios-trash"} />
                            </View>
                        </TouchableOpacity>
                    </View>
                );
            });

            paddingBottomView = <View style={{ paddingBottom: 10 }}></View>;
            totalPrice = <Text style={styles.totalPrice}>Ukupan iznos: {this.props.price.toFixed(2)} KM</Text>;
            submitButton = (
                <ButtonWithBackground
                    style={styles.submit}
                    color="#29aaf4" tintColor="white"
                    onPress={this.orderContinueHandler}
                    disabled={false}>{this.props.userId ? 'Naruči' : 'Prijavi se'}</ButtonWithBackground>
            );
        }

        return (
            <ScrollView keyboardShouldPersistTaps={'handled'}>
                <View>
                    {itemsList}
                    {paddingBottomView}
                    {totalPrice}
                    {submitButton}
                </View>
            </ScrollView>
        );
    }
}

const styles = StyleSheet.create({
    itemContainer: {
        width: '100%',
        flexDirection: 'row',
        flexWrap: 'wrap',
        paddingTop: 10,
    },
    textName: {
        fontSize: 20,
        textTransform: 'capitalize',
        fontWeight: 'bold',
        width: '60%',
        paddingLeft: 15,
    },
    textInputValue: {
        fontSize: 18,
        width: '20%',
        height: 30,
        borderColor: 'gray',
        borderWidth: 0.3,
        paddingVertical: 0,
        marginVertical: 0
    },
    trashIcon: {
        width: '20%',
        justifyContent: 'center',
        alignItems: 'center',
    },
    totalPrice: {
        paddingLeft: 15,
        borderTopColor: 'lightseagreen',
        borderTopWidth: 4,
        fontWeight: 'bold',
        fontSize: 20,
        paddingTop: 10
    },
    emptyCart: {
        fontSize: 16,
        color: 'lightseagreen',
        textAlignVertical: 'center',
        textAlign: 'center'
    },
    invalidTextInput: {
        fontSize: 18,
        width: '20%',
        height: 30,
        borderColor: 'red',
        borderWidth: 2,
        paddingVertical: 0,
        marginVertical: 0
    },
    submit: {
        alignSelf: 'center',
        alignItems: 'center',
        width: 100,
        margin: 10,
        borderRadius: 5,
        borderWidth: 1,
        borderColor: "black",
        backgroundColor: '#29aaf4',
        fontSize: 16
    }
})

const mapStateToProps = (state) => {
    return {
        orderItems: state.orderBuilder.orderItems,
        price: state.orderBuilder.totalPrice,
        userId: state.auth.userId
    };
};

const mapDispatchToProps = dispatch => {
    return {
        onInputSizeChanged: (itemId, size) => dispatch(actions.changeItemSize(itemId, size)),
        onItemRemoved: (itemId) => dispatch(actions.removeItem(itemId)),
        onSetAuthRedirectPath: (path) => dispatch(actions.setAuthRedirectPath(path))
    };
};

export default connect(mapStateToProps, mapDispatchToProps)(CartScreen);