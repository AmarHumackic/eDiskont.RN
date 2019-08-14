import React, { Component } from 'react';
import { View, Text, StyleSheet, ScrollView } from 'react-native';

import { capitalizeFirstLetter } from '../../utility/validation';

class OrderDetailsScreen extends Component {

    render() {
        const order = this.props.navigation.getParam("order");

        const items = [];
        for (let key in order.Items) {

            items.push({
                name: capitalizeFirstLetter(order.Items[key].Name),
                amount: order.Items[key].Amount,
                price: order.Items[key].Price,
            });
        }

        const itemOutput = items.map(item => {
            const amountPrice = item.amount * item.price;
            return <Text style={styles.basicText} key={item.name}>
                {item.name}: ({item.amount}) x ({item.price}) KM = {amountPrice.toFixed(2)} KM</Text>;
        });

        return (
            <ScrollView>
                <View style={styles.container}>
                    <Text style={styles.mainText}>Narudžba:</Text>
                    {itemOutput}
                    <Text style={styles.mainText}>Kontakt podaci:</Text>
                    <Text style={styles.basicText}>Ime: {order.OrderData.FullName}</Text>
                    <Text style={styles.basicText}>Firma: {order.OrderData.Company}</Text>
                    <Text style={styles.basicText}>Adresa: {order.OrderData.DeliveryAddress}</Text>
                    <Text style={styles.basicText}>Grad: {order.OrderData.City}</Text>
                    <Text style={styles.basicText}>Isporuka: {order.OrderData.DeliveryMethod}</Text>

                    <Text style={styles.totalPrice}>
                        Ukupan iznos: {Number.parseFloat(order.TotalPrice).toFixed(2)} KM</Text>
                    <Text style={styles.date}>Naručeno: {order.Date}</Text>
                </View>
            </ScrollView>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        paddingHorizontal: 10
    },
    mainText: {
        fontWeight: 'bold',
        fontSize: 18,
        paddingVertical: 8
    },
    basicText: {
        fontSize: 16,
        padding: 2,
        borderWidth: 1,
        borderColor: 'gray',
        paddingLeft: 5
    },
    totalPrice: {
        fontSize: 18,
        fontWeight: 'bold',
        alignItems: 'center',
        paddingTop: 10
    },
    date: {
        fontStyle: 'italic',
        fontSize: 14,
        alignItems: 'center',
        paddingTop: 5
    }
});

export default OrderDetailsScreen;