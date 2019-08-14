import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';

class SplashScreen extends Component {
    render() {
        return (
            <View style={styles.viewStyles}>
                <Text style={styles.textStyles}>
                    eDiskont
                </Text>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    viewStyles: {
        flex: 1,
        alignItems: 'center',
        justifyContent: 'center',
        backgroundColor: 'lightseagreen'
    },
    textStyles: {
        color: 'white',
        fontSize: 40,
        fontWeight: 'bold'
    }
});

export default SplashScreen;