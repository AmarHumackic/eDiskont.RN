import React from 'react';
import { View, Text, StyleSheet, TouchableOpacity } from 'react-native';

const order = (props) => (
    <TouchableOpacity style={styles.container} onPress={props.orderDetails}>
        <View>
            <Text>Naručio: {props.name}</Text>
            <Text>Ukupan iznos:
                <Text style={{ fontWeight: 'bold' }}> {Number.parseFloat(props.totalPrice).toFixed(2)} KM</Text>
            </Text>
            <Text>{props.date}</Text>
        </View>
    </TouchableOpacity>
);

const styles = StyleSheet.create({
    container: {
        borderWidth: 2,
        borderColor: 'lightseagreen',
        width: '90%',
        padding: 5,
        marginVertical: 5
    }
});

export default order;