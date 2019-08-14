import React, { Component } from 'react';
import { View, StyleSheet, Picker, ScrollView } from 'react-native';
import { connect } from 'react-redux';

import * as actions from '../../store/actions/index';
import validate from "../../utility/validation";
import DefaultInput from '../../components/UI/DefaultInput/DefaultInput';
import ButtonWithBackground from '../../components/UI/ButtonWithBackground/ButtonWithBackground';
import Snackbar from 'react-native-snackbar';

class ContactDataScreen extends Component {
    state = {
        orderForm: {
            name: {
                value: "",
                valid: false,
                validationRules: {
                    notEmpty: true
                },
                touched: false
            },
            company: {
                value: "",
                valid: false,
                validationRules: {
                    notEmpty: true
                },
                touched: false
            },
            address: {
                value: "",
                valid: false,
                validationRules: {
                    notEmpty: true
                },
                touched: false
            },
            city: {
                value: "",
                valid: false,
                validationRules: {
                    notEmpty: true
                },
                touched: false
            },
            deliveryMethod: {
                value: "1",
                valid: true,
                validationRules: {

                },
                touched: true
            }
        },
        formIsValid: false
    }

    updateInputState = (key, value) => {
        let connectedValue = {};
        this.setState(prevState => {
            return {
                orderForm: {
                    ...prevState.orderForm,
                    [key]: {
                        ...prevState.orderForm[key],
                        value: value,
                        valid: validate(value, prevState.orderForm[key].validationRules, connectedValue),
                        touched: true
                    }
                },
                formIsValid: this.state.formIsValid
            };
        });

        this.setState(prevState => {
            let formIsValid = true;
            for (let inputIdentifiers in prevState.orderForm) {
                formIsValid = prevState.orderForm[inputIdentifiers].valid && formIsValid;
            }
            return {
                orderForm: prevState.orderForm,
                formIsValid: formIsValid
            }
        });
    };

    orderHandler = () => {
        const formData = {};
        for (let formElement in this.state.orderForm) {
            formData[formElement] = this.state.orderForm[formElement].value;
        }
        var today = {
            day: new Date().getDate(),
            month: new Date().getMonth(),
            year: new Date().getFullYear(),
            hour: new Date().getHours(),
            minute: new Date().getMinutes()
        }
        const order = {
            orderItems: this.props.orderItems,
            price: this.props.totalPrice,
            orderData: formData,
            date: today.month + '.' + today.day + '.' + today.year + ' ' + today.hour + ':' + today.minute,
            userId: this.props.userId
        }

        this.props.onOrderConfirm(order, this.props.token);
        Snackbar.show({
            title: 'Narudžba je uspješno procesirana.',
            duration: Snackbar.LENGTH_LONG,
            color: 'white'
        });
        this.props.navigation.popToTop();
        this.props.navigation.navigate("OrdersStackNavigator");
    }

    render() {
        return (
            <ScrollView keyboardShouldPersistTaps={'handled'}>
                <View style={styles.container}>
                    <DefaultInput
                        placeholder="Ime"
                        style={styles.input}
                        value={this.state.orderForm.name.value}
                        onChangeText={val => this.updateInputState("name", val)}
                        valid={this.state.orderForm.name.valid}
                        touched={this.state.orderForm.name.touched}
                    />
                    <DefaultInput
                        placeholder="Firma"
                        style={styles.input}
                        value={this.state.orderForm.company.value}
                        onChangeText={val => this.updateInputState("company", val)}
                        valid={this.state.orderForm.company.valid}
                        touched={this.state.orderForm.company.touched}
                    />
                    <DefaultInput
                        placeholder="Adresa"
                        style={styles.input}
                        value={this.state.orderForm.address.value}
                        onChangeText={val => this.updateInputState("address", val)}
                        valid={this.state.orderForm.address.valid}
                        touched={this.state.orderForm.address.touched}
                    />
                    <DefaultInput
                        placeholder="Grad"
                        style={styles.input}
                        value={this.state.orderForm.city.value}
                        onChangeText={val => this.updateInputState("city", val)}
                        valid={this.state.orderForm.city.valid}
                        touched={this.state.orderForm.city.touched}
                    />
                    <View style={styles.inputPicker}>
                        <Picker
                            selectedValue={this.state.orderForm.deliveryMethod.value}
                            mode="dialog"
                            onValueChange={(itemValue, itemIndex) =>
                                this.updateInputState("deliveryMethod", itemValue)
                            }>
                            <Picker.Item label="Brzo" value="1" />
                            <Picker.Item label="Jeftino" value="2" />
                        </Picker>
                    </View>
                    <ButtonWithBackground
                        color="#29aaf4" tintColor="white"
                        onPress={this.orderHandler}
                        disabled={!this.state.formIsValid}>Procesiraj narudžbu</ButtonWithBackground>
                </View>
            </ScrollView>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        alignItems: "center",
        paddingTop: 10
    },
    input: {
        width: '90%',
        backgroundColor: "#eee",
        borderColor: "#bbb",
        borderRadius: 5,
        fontSize: 16
    },
    inputPicker: {
        width: "90%",
        backgroundColor: "#eee",
        borderWidth: 1,
        borderColor: "#bbb",
        padding: 0,
        marginVertical: 8,
        borderRadius: 5,
        fontSize: 16
    }

});

const mapStateToProps = state => {
    return {
        orderItems: state.orderBuilder.orderItems,
        totalPrice: state.orderBuilder.totalPrice,
        token: state.auth.token,
        userId: state.auth.userId,
    };
};

const mapDispatchToProps = dispatch => {
    return {
        onOrderConfirm: (orderData, token) => dispatch(actions.purchaseOrder(orderData, token)),
    };
};

export default connect(mapStateToProps, mapDispatchToProps)(ContactDataScreen);