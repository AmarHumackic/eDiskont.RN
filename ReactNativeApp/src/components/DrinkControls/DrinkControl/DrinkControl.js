import React from 'react';
import { View, Text, StyleSheet, Image } from 'react-native';

import ButtonWithBackground from '../../UI/ButtonWithBackground/ButtonWithBackground';
import axios from '../../../../axios-config';

const drinkControl = props => {
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
    };

    return (
        <View style={styles.container}>
            <View style={styles.image}>
                <Image source={{ uri: `${axios.defaults.baseURL}/Items/GetImage?imageName=${props.photo}.jpg` }}
                    style={{ width: 40, height: 100 }}></Image>
            </View>
            <Text style={{ textTransform: 'capitalize' }}>{this.limitItemTitle(props.item)} - {props.size} x</Text>
            <Text>Cijena: {props.price} KM</Text>
            <ButtonWithBackground color="lightseagreen" tintColor="white" onPress={props.added}>Dodaj</ButtonWithBackground>
        </View>
    );
}

const styles = StyleSheet.create({
    container: {
        width: '50%',
        alignItems: "center"
    },
    image: {
        paddingTop: 15
    }
})

export default drinkControl;