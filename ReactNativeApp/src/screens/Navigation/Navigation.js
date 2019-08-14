import React, { Component } from 'react';
import { View, Text, StyleSheet, Platform, SafeAreaView, Image } from 'react-native';
import {
    createSwitchNavigator,
    createAppContainer,
    createDrawerNavigator,
    createBottomTabNavigator,
    createStackNavigator,
    DrawerItems
} from 'react-navigation';
import { connect, } from 'react-redux';

import Icon from 'react-native-vector-icons/Ionicons';
import AuthScreen from '../Auth/Auth';
import CartScreen from '../Cart/Cart';
import ContactDataScreen from '../ContactData/ContactData';
import OrderBuilderScreen from '../OrderBuilder/OrderBuilder';
import OrderDetailsScreen from '../OrderDetails/OrderDetails';
import OrdersScreen from '../Orders/Orders';
import LogoutScreen from '../Auth/Logout/Logout';
import Logo from '../../assets/diskontlogo.jpg';
import NavigationService from './NavigationService';

class Navigation extends Component {
    render() {
        return <AppContainer ref={navigatorRef => {
            NavigationService.setTopLevelNavigator(navigatorRef);
        }} screenProps={{ email: this.props.email }} />;
    }
}

const OrderBuilderTabNavigator = createBottomTabNavigator(
    {
        Sokovi: { screen: OrderBuilderScreen, params: { typeId: 1 } },
        'Topli napici': { screen: OrderBuilderScreen, params: { typeId: 2 } },
        Alkohol: { screen: OrderBuilderScreen, params: { typeId: 3 } }
    },
    {
        defaultNavigationOptions: ({ navigation }) => ({
            tabBarIcon: ({ tintColor }) => {
                const { routeName } = navigation.state;
                let iconName;
                if (routeName === 'Sokovi') {
                    iconName = Platform.OS === 'android' ? 'md-wine' : 'ios-wine';
                } else if (routeName === 'Topli napici') {
                    iconName = Platform.OS === 'android' ? 'md-cafe' : 'ios-cafe';
                } else if (routeName === 'Alkohol') {
                    iconName = Platform.OS === 'android' ? 'md-beer' : 'ios-beer';
                }

                return <Icon name={iconName} size={25} color={tintColor} />;
            }
        }),
        tabBarOptions: {
            activeTintColor: 'lightseagreen',
            inactiveTintColor: 'gray'
        },
    }
)

const OrderBuilderStackNavigator = createStackNavigator(
    {
        OrderBuilderStackNavigator: OrderBuilderTabNavigator,
        Cart: { screen: CartScreen },
        ContactData: { screen: ContactDataScreen }
    },
    {
        defaultNavigationOptions: ({ navigation }) => {
            if (navigation.state.routeName === "Cart") {
                return {
                    title: "Narudžba",
                    headerStyle: {
                        backgroundColor: 'lightseagreen',
                    },
                    headerTintColor: 'white'
                };
            }
            else if (navigation.state.routeName === "ContactData") {
                return {
                    title: "Kontakt podaci",
                    headerStyle: {
                        backgroundColor: 'lightseagreen',
                    },
                    headerTintColor: 'white'
                };
            }
            return {
                title: "Proizvodi",
                headerLeft: (
                    <Icon
                        style={styles.headerLeft}
                        onPress={() => navigation.openDrawer()}
                        name={Platform.OS === 'android' ? "md-menu" : "ios-menu"}
                        size={30} />
                ),
                headerRight: (
                    <Icon
                        style={styles.headerRight}
                        onPress={() => navigation.navigate("Cart")}
                        name={Platform.OS === 'android' ? "md-cart" : "ios-cart"}
                        size={30} />
                ),
                headerStyle: {
                    backgroundColor: 'lightseagreen',
                },
                headerTintColor: 'white'
            };
        },
    }
);

const OrdersStackNavigator = createStackNavigator(
    {
        OrdersStackNavigator: { screen: OrdersScreen },
        Cart: { screen: CartScreen },
        ContactData: { screen: ContactDataScreen },
        OrderDetails: { screen: OrderDetailsScreen }
    },
    {
        defaultNavigationOptions: ({ navigation }) => {
            if (navigation.state.routeName === "Cart") {
                return {
                    title: "Narudžba",
                    headerStyle: {
                        backgroundColor: 'lightseagreen',
                    },
                    headerTintColor: 'white'
                };
            }
            else if (navigation.state.routeName === "ContactData") {
                return {
                    title: "Kontakt podaci",
                    headerStyle: {
                        backgroundColor: 'lightseagreen',
                    },
                    headerTintColor: 'white'
                };
            }
            else if (navigation.state.routeName === "OrderDetails") {
                return {
                    title: "Detalji narudžbe",
                    headerStyle: {
                        backgroundColor: 'lightseagreen',
                    },
                    headerTintColor: 'white'
                };
            }
            return {
                title: "Narudžbe",
                headerLeft: (
                    <Icon
                        style={styles.headerLeft}
                        onPress={() => navigation.openDrawer()}
                        name={Platform.OS === 'android' ? "md-menu" : "ios-menu"}
                        size={30} />
                ),
                headerRight: (
                    <Icon
                        style={styles.headerRight}
                        onPress={() => navigation.navigate("Cart")}
                        name={Platform.OS === 'android' ? "md-cart" : "ios-cart"}
                        size={30} />
                ),
                headerStyle: {
                    backgroundColor: 'lightseagreen',
                },
                headerTintColor: 'white'
            };
        }
    }
);

const AuthStackNavigator = createStackNavigator(
    {
        AuthStackNavigator: { screen: AuthScreen },
        Cart: { screen: CartScreen },
        ContactData: { screen: ContactDataScreen }
    },
    {
        defaultNavigationOptions: ({ navigation }) => {
            if (navigation.state.routeName === "Cart") {
                return {
                    title: "Narudžba",
                    headerStyle: {
                        backgroundColor: 'lightseagreen',
                    },
                    headerTintColor: 'white'
                };
            }
            else if (navigation.state.routeName === "ContactData") {
                return {
                    title: "Kontakt podaci",
                    headerStyle: {
                        backgroundColor: 'lightseagreen',
                    },
                    headerTintColor: 'white'
                };
            }
            return {
                title: "Prijava/Registracija",
                headerLeft: (
                    <Icon
                        style={styles.headerLeft}
                        onPress={() => navigation.openDrawer()}
                        name={Platform.OS === 'android' ? "md-menu" : "ios-menu"}
                        size={30} />
                ),
                headerRight: (
                    <Icon
                        style={styles.headerRight}
                        onPress={() => navigation.navigate("Cart")}
                        name={Platform.OS === 'android' ? "md-cart" : "ios-cart"}
                        size={30} />
                ),
                headerStyle: {
                    backgroundColor: 'lightseagreen',
                },
                headerTintColor: 'white'
            };
        },
    }
);

const AppDrawerNavigator = createDrawerNavigator({
    Proizvodi: {
        screen: OrderBuilderStackNavigator,
        params: { length: 55 },
        navigationOptions: () => ({
            drawerIcon: () => (
                <Icon name={Platform.OS === 'android' ? "md-pricetags" : "ios-pricetags"} size={25} ></Icon>
            ),
        })
    },
    'Narudžbe': {
        screen: OrdersStackNavigator,
        navigationOptions: () => ({
            drawerIcon: () => (
                <Icon name={Platform.OS === 'android' ? "md-list" : "ios-list"} size={25} ></Icon>
            )
        })

    },
    'Prijava/Registracija': {
        screen: AuthStackNavigator,
        navigationOptions: () => ({
            drawerIcon: () => (
                <Icon name={Platform.OS === 'android' ? "md-log-in" : "ios-log-in"} size={25} ></Icon>
            )
        })
    },
    'Odjava': {
        screen: LogoutScreen,
        navigationOptions: () => ({
            drawerIcon: () => (
                <Icon name={Platform.OS === 'android' ? "md-log-out" : "ios-log-out"} size={25} ></Icon>
            )
        })
    }
},
    {
        contentComponent: (props) => {
            var copyprops = Object.assign({}, props);
            if (props.screenProps.email) {
                copyprops.items = copyprops.items.filter(item => item.key !== 'Prijava/Registracija')
            } else {
                copyprops.items = copyprops.items.filter(item => item.key !== 'Odjava')
            }

            return (
                <SafeAreaView forceInset={{ top: 'always', horizontal: 'never' }}>
                    <View style={{ flexDirection: 'column', paddingTop: 10 }}>
                        <View style={{ alignItems: 'center', backgroundColor: '#fff' }}>
                            <Image style={{ width: 170, height: 150 }} source={Logo} />
                        </View>
                        {props.screenProps.email ?
                            <Text style={{ color: '#000', paddingLeft: 15, fontWeight: 'bold', fontStyle: 'italic' }}>
                                Prijavljeni ste, {'\n'}{props.screenProps.email}
                            </Text> : null
                        }
                    </View>
                    <DrawerItems {...copyprops}
                        activeTintColor='lightseagreen' activeBackgroundColor='#e6ffff'
                        inactiveTintColor='lightseagreen' inactiveBackgroundColor='white'
                        style={{ backgroundColor: 'white' }} labelStyle={{ color: 'lightseagreen', fontSize: 16 }} />
                </SafeAreaView>
            );
        }
    });

const AppSwitchNavigator = createSwitchNavigator({
    Proizvodi: AppDrawerNavigator,
    'Narudžbe': AppDrawerNavigator,
    'Prijava/Registracija': AppDrawerNavigator,
    'Odjava': AppDrawerNavigator,
    ContactData: { screen: ContactDataScreen },
    OrderDetails: { screen: OrderDetailsScreen }
});

const AppContainer = createAppContainer(AppSwitchNavigator);

const styles = StyleSheet.create({
    headerLeft: {
        paddingLeft: 10,
        color: "#fff"
    },
    headerRight: {
        paddingRight: 10,
        color: "#fff"
    }
});

const mapStateToProps = state => {
    return {
        email: state.auth.email
    };
};

export default connect(mapStateToProps)(Navigation);