import React, { Component } from 'react';
import { StyleSheet, FlatList } from 'react-native';

import DrinkControl from './DrinkControl/DrinkControl';

class DrinkControls extends Component {
    render() {
        return (
            <FlatList contentContainerStyle={styles.container} numColumns={2} data={this.props.items} 
                keyExtractor={(info, index) => index.toString()} renderItem={(info) => (
                <DrinkControl key={info.item.ItemID} item={info.item.ItemName} size={info.item.PackSize} 
                photo={info.item.ItemName} price={(info.item.Price * info.item.PackSize).toFixed(2)} 
                added={() => this.props.itemAdded(info.item.ItemID, info.item.Price, info.item.ItemName, info.item.PackSize)}></DrinkControl>
            )} />
        );
    }
}

const styles = StyleSheet.create({
    container: {
        width: '100%',
        flex: 1,
        justifyContent: 'space-between'
    }
});

export default DrinkControls;